require "net/http"
require "uri"
require "mail_robber/version"
require "mail_robber/config"
require "mail_robber/railtie" if defined?(Rails)
require "launchy"

module MailRobber
  def self.delivering_email(message)
    params = { token:       self.config.token,
               from:        message.from,
               to:          message.to,
               cc:          message.cc,
               bcc:         message.bcc,
               subject:     message.subject }

    if message.multipart?
      # If message is HTML-only and has attachments,
      # it is considered multipart, but doesn't have
      # text_part, which is required by MailRobber
      params[:text_part] = message.text_part.body.raw_source || message.html_part.body.raw_source
      params[:html_part] = message.html_part.body.raw_source if message.html_part
    else
      case message.mime_type
      when 'text/html'
        params[:text_part] = message.body.raw_source
        params[:html_part] = message.body.raw_source
      when 'text/plain'
        params[:text_part] = message.body.raw_source
      end
    end

    attachments = message.attachments.map do |a|
      { content_type: a.content_type,
        filename:     a.filename,
        raw_source:   a.body.raw_source }
    end
    params[:attachments] = Marshal::dump(attachments)

    intercept_letter(params) if self.config.enabled
    block_delivery(message) if self.config.block_delivery
  end

  private
    def self.intercept_letter(params)
      Rails.logger.debug "MailRobber intercepting email"
      begin
        Net::HTTP.post_form(URI.parse('http://mailrobber.com/api/emails/create'), params)
      rescue
        raise 'Couldn\'t send email to MailRobber'
      end
    end

    def self.block_delivery(message)
      message.perform_deliveries = false
      Rails.logger.debug "MailRobber prevented sending email #{message.inspect}!"
    end
end
