# MailRobber

Simple email testing for Rails

## Installation

Add this line to your application's Gemfile:

    gem 'mail_robber'

And then execute:

    $ bundle

Register your app in MailRobber service:

    $ rails g mail_robber:install

This will be added to your config/initializers/mail_robber.rb

    MailRobber.configure do |config|
      config.enabled = true        # enable mail interception
      config.block_delivery = true # don't proceed sending email
      config.token = 'token-for-your-application'
    end

To open a page with your emails, run:

    $ rake mail_robber:open
