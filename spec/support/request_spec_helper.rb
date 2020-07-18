module RequestSpecHelper

  def log_in(user)
    cookies[:user_id] = user.id
  end

end