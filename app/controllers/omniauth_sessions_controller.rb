class OmniauthSessionsController < ActionController::Base
  def create
    if (auth_hash.fetch("provider") == "developer" || OmniAuth.config.test_mode) && Rails.env.production?
      raise SecurityError, "test provider can't be used in production"
    end

    user = OmniauthRequest.user(auth_hash)
    cookies.encrypted[:user_id] = {value: user.id, expires: 1.week.since, httponly: true, secure: Rails.env.production?}
    redirect_to referer
    flash[:notice] = I18n.t "admin.sessions.success"
    session[:return_to] = nil
  end

  private

  def auth_hash
    request.env.fetch("omniauth.auth")
  end

  def referer
    session[:return_to] || request.env["omniauth.origin"] || root_path
  end
end
