class UsersController < ApplicationController
  # ログインしていないユーザはログイン画面に飛ばす
  # Sessions_helperから飛ばしている
  skip_before_action :login_required, only: [:new, :create]
  # before_action :set_user, only: [:show, :edit, :update]

# Sessions Helper  異なるユーザーページに旋廻しない制御
  before_action :correct_user,only:[:show]

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
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

end
  # def set_user
  #  @user = User.find(params[:id])
  # end
