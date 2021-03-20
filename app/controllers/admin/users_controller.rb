class Admin::UsersController < ApplicationController
before_action :set_user, only: [:edit, :update, :destroy, :show]

  # binding.pry

  def index
    # N＋1問題
    @users = User.select(:id, :name, :email, :admin).order(created_at: :asc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_url(@user.id), notice: "ユーザー登録しました。"
    else
      render :new, notice: "ユーザー登録に失敗しました"
    end
  end

  def show
    # @users = User.find(params[:id])
  end

  def edit
    # @users = User.find(params[:id])
  end

  def update
    # @users = User.find(params[:id])
    if @user.update(user_params)
    redirect_to admin_user_path(@user), notice: "ユーザーの登録内容を更新しました"
      else
        render :edit, notice: "更新に失敗しました"
      end
    end

    def destroy
      # @users = User.find(params[:id])
      @user.destroy
      redirect_to admin_user_url, notice: "#{@users.name} さん関連のデータを削除しました"
    end

    private
    def user_params
      params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

end
