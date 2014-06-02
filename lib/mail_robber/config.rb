module MailRobber
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Configuration.new
    yield(config)
    ActionMailer::Base.register_interceptor(MailRobber) if config.enabled
  end

  class Configuration
    attr_accessor :token, :enabled, :block_delivery

    def initialize
      @token = nil
      @enabled = true
      @block_delivery = false
    end
  end
end
