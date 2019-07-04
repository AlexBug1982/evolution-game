# frozen_string_literal: true
class PlayerController < ApplicationController
  layout false

  def index
  end


  def create_player
    service = PlayerServices::Persist::Creator.new(params, user_language)
    service.call
    if service.valid?
      @player = service.player
      AddNewPlayerJob.perform_now(@player)
      set_player_id(@player.id)
      set_session_token(@player.session_token)
      redirect_to root_path
    else
      @errors = builder_errors_to_loca_errors(service.errors)
      pp @errors
    end
  end

  def view_path(sub_path)
    controller_name + '/' + sub_path
  end

  protected

  def on_logged_in
    redirect_to root_path
  end

  def on_not_logged_in
  end

end
