module SessionsHelper
  #【1】 ログイン中のユーザを取得
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  #【1】またユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    current_user.present?
  end
end
