class UsersController < ApplicationController
  # ログインしていないユーザはログイン画面に飛ばす
  # Sessions_helperから飛ばしている
  skip_before_action :login_required, only: [:new, :create]
  # before_action :set_user, only: [:show, :edit, :update]

# Sessions Helper  異なるユーザーページに旋廻しない制御
  before_action :correct_user,only:[:show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

# 【2】
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
    # 即ログイン
    session[:user_id] = @user.id
    redirect_to user_path(@user.id)
    else
    render :new
    end
  end

  def show
    # @user = User.find(params[:id])
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "プロフィールを編集しました！"
    else
      render :edit
    end
  end
  def destroy
    # @users = User.find(params[:id])
    @users.destroy    #{@user.name}さん
    redirect_to admin_user_url, notice: "関連のデータを削除しました"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def set_user
   @users = User.find(params[:id])
  end

end
