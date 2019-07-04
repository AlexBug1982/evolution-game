require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WeSourceChat
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.load_defaults 5.1
    config.active_job.queue_adapter = :sidekiq

    config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    config.action_mailer.default_url_options = { host: 'gmail.com' }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              'email-smtp.eu-west-1.amazonaws.com',
      port:                 587,
      domain:               'gmail.com',
      user_name:            'username',
      password:             'password',
      authentication:       'login',
      enable_starttls_auto: true
    }
  end
end
