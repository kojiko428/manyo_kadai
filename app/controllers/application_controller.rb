class ApplicationController < ActionController::Base
  # セッション用のヘルパーモジュールをインクルードする
  #【7】ログイン機能
  protect_from_forgery with: :exception
  include SessionsHelper

  # sessions_controller ログインしていないユーザはログイン画面に飛ばす
  before_action :login_required
  private
    def login_required
      # flash[:notice] = "ログインもしくはアカウントを作成してください"
      redirect_to new_session_path unless current_user
  end

  # current_user以外のマイページ（userのshow画面）にアクセスしたらタスク一覧に遷移
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
  end
end
