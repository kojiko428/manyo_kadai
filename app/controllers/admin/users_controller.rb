class Admin::UsersController < ApplicationController
before_action :set_user, only: [:edit, :update, :destroy, :show]
# 管理者確認
before_action :require_admin
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
      redirect_to admin_user_path(@user.id), notice: "ユーザー登録しました。"
    else
      render :new, notice: "ユーザー登録に失敗しました"
    end
  end

  def show
    @tasks = @user.tasks
    @tasks = @tasks.page(params[:page]).per(10)
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
        render :edit, notice: "管理者がいなくなるため更新できません"
      end
    end

    def destroy
      # @users = User.find(params[:id])
      if @user.destroy
      redirect_to admin_users_path, notice: "#{@user.name} さん関連のデータを削除しました"
      else
      redirect_to admin_users_path, notice: "管理者がいなくなるため削除できません"
      end
    end

    private
    def user_params
      params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_admin
      # 現在のユーザーでなく、管理者でもない
      if current_user.nil? || !current_user.admin?
        redirect_to tasks_path, notice: "管理者以外はアクセスできません。"
      end
    end

end
