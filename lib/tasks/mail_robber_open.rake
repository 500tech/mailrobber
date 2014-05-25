namespace :mail_robber do
  desc 'Open emails page in a web browser'
  task :open do
    config_file = Rails.root.join('config', 'initializers', 'mail_robber.rb')
    config_line = /config.token\s*=\s*'(?<token>.*)'/
    token = File.read(config_file).match(config_line)['token']
    Launchy.open("http://www.mailrobber.com/#/#{token}")
  end
end
