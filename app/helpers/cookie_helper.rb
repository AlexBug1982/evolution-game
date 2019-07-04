module CookieHelper
  def get_player_id
    cookies.permanent[:player_id]
  end

  def set_player_id(player_id)
    cookies.permanent[:player_id] = player_id
  end

  def delete_player_id
    cookies.delete :player_id
  end

  def store_env_in_cookie
    cookies.permanent[:env] = Rails.env
  end

  def get_bid_session_slug
    cookies[:bid_session]
  end

  def set_bid_session_slug(bid_session_slug)
    cookies[:bid_session] = bid_session_slug
  end
end
