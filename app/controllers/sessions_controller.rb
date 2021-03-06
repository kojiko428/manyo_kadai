class SessionsController < ApplicationController
# app/controllers/application_controller.rb
# ログインしていないユーザはログイン画面に飛ばす
skip_before_action :login_required, only: [:new, :create]

  def new
    # ログイン中ユーザの新規登録画面に行かせないように制御
    if logged_in?
      redirect_to tasks_path, notice:'すでにログインしています。'
    else
      @user = User.new
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
