require 'rails/generators/base'
require 'securerandom'

module MailRobber
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Register your app with a new API key within MailRobber service."

      source_root File.expand_path("../../templates", __FILE__)

      @@token = SecureRandom.hex(16)

      def copy_initializer
        template 'mail_robber.rb', 'config/initializers/mail_robber.rb'
      end

      def token
        @@token
      end

      begin
        params = { app_name: Rails.application.class.parent,
                   token:    @@token }
        Net::HTTP.post_form(URI.parse("http://mailrobber.com/api/apps/create/"), params)
        Launchy.open("http://mailrobber.com/#/#{@@token}")
      rescue
        raise 'Couldn\'t create app within MailRobber service. Check config/initializers/mail_robber.rb'
      end
    end
  end
end
