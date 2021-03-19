class ApplicationController < ActionController::Base
  # セッション用のヘルパーモジュールをインクルードする
  #【7】ログイン機能
  protect_from_forgery with: :exception
  include SessionsHelper

  # ログインしていないユーザはログイン画面に飛ばす
  before_action :login_required
  private
    def login_required
      redirect_to new_session_path unless current_user
  end
end
