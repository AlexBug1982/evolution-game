# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include LanguageHelper
  include CookieHelper
  include SessionHelper
  protect_from_forgery with: :exception
  before_action :find_or_create_world
  before_action :store_env_in_cookie
  before_action :authenticate_user!

  attr_reader :current_player, :user_language
  helper_method :current_player,
                :logged_in?,
                :log_in,
                :user_language,
                :translate_with_user_language,
                :path_with_protocol_and_port

  def logged_in?
    current_player.present?
  end

  protected

  def authenticate_user!
    find_current_player
    logged_in? ? on_logged_in : on_not_logged_in
  end

  def on_logged_in; end

  def on_not_logged_in
    return if admin_page?
    if @session_error
      redirect_to root_path(session_error: @session_error)
    else
      redirect_to root_path
    end
  end

  def find_current_player
    player_id = get_player_id()
    current_player_finder = PlayerServices::Session::Runtime::PlayerFinder.new(player_id)
    current_player_finder.call
    @current_player = current_player_finder.current_player
    if current_player
      set_session_token(current_player_finder.player.session_token)
    else
      @session_error = current_player_finder.error
    end
    @user_language = 'en'
  end

  def fetch_userable
  end

  private

  def find_or_create_world
    @world = World.first
    if @world.blank?
      @world = World.create! width: 120, height: 60
    end
  end

  def admin_page?
    admin_path = '/admin'
    request.original_url.include? admin_path
  end

  def builder_errors_to_loca_errors(errors)
    loca_erros = []
    errors.each do |type, message|
      type_string = type.to_s
      message_id = message.parameterize.underscore
      content = translate_with_user_language('form_errors.' + type_string + '_' + message_id)
      loca_erros.push([type_string, content])
    end
    loca_erros
  end

  def path_with_protocol_and_port(path)
    request.protocol + request.host_with_port + path
  end

  def get_site_links_with_base(path)
    request.base_url + '/' + path
  end

  def redirect_by_request_type(url)
    if request.xhr?
      render js: "window.location='#{url}'"
    else
      redirect_to url, status: 303, turbolinks: false
    end
  end

  def app_dashboard_path
    current_player.userable_proxy.logged_in_start_path
  end

end
