module SessionHelper

  def get_session_token
    session[:base_user_id]
  end

  def set_session_token(session_token)
    session[:base_user_id] = session_token
  end

  def delete_session_token
    session.delete :base_user_id
  end

end
