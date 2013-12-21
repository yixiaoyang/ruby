require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module BizInviteSys
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    # bootstrap
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
  
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local
    
    config.assets.logger = false
    config.assets.logger = nil
    
    # mailer
    # Don't care if the mailer can't send
    config.action_mailer.raise_delivery_errors = true
    # Gmail SMTP server setup
    config.action_mailer.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      :address => "smtp.gmail.com",
      :port => 587,
      :user_name => "ee",
      :password => 'ee',
      :authentication       => 'plain',
      :enable_starttls_auto => true
    }
    
    #ActionMailer::Base.smtp_settings = {
    #    :address              => "smtp.163.com",
    #    :port                 => 25,
    #    :domain               => "163.com",
    #    :user_name            => "hityixiaoyang",
    #    :password             => "123456",
    #    :authentication       => "plain",
    #    :enable_starttls_auto => true
    #}
  
  end
end
