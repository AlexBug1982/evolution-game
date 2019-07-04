# frozen_string_literal: true

module PlayerServices::Persist
  class Creator
    include PlayerServices::Persist::Modules::PlayerCreator
    include BooleanHelper
    include ActiveRecordErrorParser

    attr_reader :create_params, :user_language
    attr_accessor :errors

    def initialize(params, user_language)
      @create_params = params
      @user_language = user_language
    end

    def call
      @errors = ActiveModel::Errors.new(self)
      check_calculation
      create_player if valid?
    end

    def valid?
      errors.empty?
    end

    private

    CALCULATION_RESULT = 7
    def check_calculation
      calculation = create_params[:calculation]
      if calculation.blank? || calculation.to_i != CALCULATION_RESULT
        add_new_error('calculation', 'wrong')
      end # calculation != CALCULATION_RESULT
    end

    def add_new_error(key, error)
      errors.add(key.to_sym, error)
    end
  end
end
