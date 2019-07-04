# frozen_string_literal: true

class WelcomeController < ApplicationController
  layout :resolve_layout

  def index
    render 'welcome/index', layout: false
  end

  protected

  def on_logged_in; end

  def on_not_logged_in
    redirect_to signup_player_path
  end

  private

  def resolve_layout
    case action_name
    when 'confirm', 'change_password'
      'application'
    else
      false
    end
  end
end
