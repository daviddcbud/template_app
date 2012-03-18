module SessionsHelper
  
  def create_session_token
    SecureRandom.urlsafe_base64
  end

  def signed_in?
    !current_user.nil?
  end
  def sign_out
    current_user = nil
    cookies.delete(:session_token)
  end
  
  def sign_in(user)
    cookies.permanent[:session_token] = user.session_token
    current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_session_token
  end
  
  private
       
      def user_from_session_token
        session_token = cookies[:session_token]
        User.find_by_session_token(session_token) unless cookies[:session_token].nil?
      end
end
