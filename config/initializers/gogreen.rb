module GoGreen 
  class Config
    cattr_accessor :email_sender
  end
end

if File.exist? "#{RAILS_ROOT}/config/gogreen.yml"
  YAML.load_file("#{RAILS_ROOT}/config/gogreen.yml").each do |key, value|
    GoGreen::Config.send "#{key}=", value
  end 
else
  GoGreen::Config.email_sender = "default@example.com"  
end
