MailRobber.configure do |config|

  # Enable mail interception (true/false)
  # When enabled, all emails will be captured and
  # stored on www.mailrobber.com/yourapikey
  config.enabled        = !Rails.env.production?

  # Stop emails from being sent via selected delivery mechanism
  # Set to false (or !Rails.env.production?)
  # to send emails when on production environment
  config.block_delivery = true

  # Your app token (generated automatically)
  # Use rails g mail_robber:install to generate
  # a new initializer file with a new token
  # Use rake mail_robber:open to open url with this token
  config.token          = '<%= token %>'
end
