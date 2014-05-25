require 'mail_robber'
require 'rails'

module MailRobber
  class Railtie < Rails::Railtie
    railtie_name :mail_robber

    rake_tasks do
      load "tasks/mail_robber_open.rake"
    end
  end
end
