MailRobber.configure do |config|
  config.enabled        = true
  config.block_delivery = false
  config.token          = '<%= token %>'
end
