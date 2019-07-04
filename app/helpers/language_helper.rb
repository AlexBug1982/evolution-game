# frozen_string_literal: true

module LanguageHelper

  def translate_with_user_language(key, *args)
    user_language = 'en'
    if args.present? && args.size.positive?
      args_list = args.first
      if args_list.size == 1
        arg_key_1 = args_list.keys[0]
        arg_value_1 = args_list.values[0]
        I18n.t(key, arg_key_1 => arg_value_1, locale: user_language)
      elsif args_list.size == 2
        arg_key_1 = args_list.keys[0]
        arg_value_1 = args_list.values[0]
        arg_key_2 = args_list.keys[1]
        arg_value_2 = args_list.values[1]
        I18n.t(key, arg_key_1 => arg_value_1, arg_key_2 => arg_value_2, locale: user_language)
      elsif args_list.size == 3
        arg_key_1 = args_list.keys[0]
        arg_value_1 = args_list.values[0]
        arg_key_2 = args_list.keys[1]
        arg_value_2 = args_list.values[1]
        arg_key_3 = args_list.keys[2]
        arg_value_3 = args_list.values[2]
        I18n.t(key, arg_key_1 => arg_value_1, arg_key_2 => arg_value_2, arg_key_3 => arg_value_3, locale: user_language)
      end
    else
      I18n.t(key, locale: user_language)
    end
  end

end
