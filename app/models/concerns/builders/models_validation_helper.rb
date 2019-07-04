module Builders::ModelsValidationHelper
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Validations
    attr_reader :manual_validation_failed

    validate :validate_models

    private

    # Define which models should be validated
    def models_to_validate
      raise NotImplementedError
    end

    def validate_models
      models_to_validate.each do |entity|
        instance_var = instance_variable_get("@#{entity}")
        next unless instance_var.present?
        instance_var.errors.each { |k, v| errors.add("#{entity}_#{k}", v) } unless instance_var.valid?
      end
    end

    def add_manual_validation_error(key, error)
      errors.add(key.to_sym, error)
    end
  end
end
