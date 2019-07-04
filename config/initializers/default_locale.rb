I18n.available_locales = %w(en)
require "i18n/backend/fallbacks"
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)

I18n.default_locale = 'en'
