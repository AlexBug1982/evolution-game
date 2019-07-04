# frozen_string_literal: true

class ErrorsController < ApplicationController
  layout false

  def not_found
    puts 'not_found'
    respond_to do |format|
      format.html { render status: 404 }
      format.json { render json: { error: 'Resource not found' }, status: 404 }
    end
  end

  def unacceptable
    puts 'unacceptable'
    respond_to do |format|
      format.html { render status: 422 }
      format.json { render json: { error: 'Params unacceptable' }, status: 422 }
    end
  end

  def internal_error
    puts 'internal_error'
    respond_to do |format|
      format.html { render status: 500 }
      format.json { render json: { error: 'Internal server error' }, status: 500 }
    end
  end
end
