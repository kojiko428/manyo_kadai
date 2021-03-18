class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
# binding.pry

def index
   @tasks = Task.all.order(created_at: :desc)
   @tasks = @tasks.all.order(deadline: :desc) if params[:sort_deadline]
   @tasks = @tasks.all.order(priority: :asc) if params[:sort_priority]
   @tasks = @tasks.search_title(params[:'タイトル検索']) if params[:'タイトル検索']
# 選択しない場合の空欄やnilを受け付けないようにする
   if params[:'ステータス検索'] != "" && params[:'ステータス検索'] != nil
     @tasks = @tasks.search_status(params[:'ステータス検索'])
   end
   @tasks = @tasks.page(params[:page]).per(10)
 end


  def new
    @task =Task.new
  end
     # 追記する
  def create
       # 【5】 @task = current_user.tasks.build(task_params)
    @task=Task.create(task_params)
       # @task.user_id = current_task.id  ↑Buildメソッドにて省略
       # 現在ログインしているuserのidを、taskのuser_idカラムに挿入する
    if params[:back]
      render :new
    elsif @task.save
       # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
       #【5】{@task.user.name}さんが
      redirect_to tasks_path , notice: " タスクを作成しました！"
    else
       # 入力フォームを再描画します。
      render :new
    end
  end

  def show
      #【6】 @favorite = current_user.favorites.find_by(task_id: @task.id)
      # @task = Task.find(params[:id])
  end

  def edit
      # @task = Task.find(params[:id])
  end

  def update
      # @task = Task.find(params[:id])
      # 【5】{@task.user.name}さんが
    if @task.update(task_params)
      redirect_to tasks_path , notice: " タスクを編集しました！"
    else
      render :edit
    end
  end
     #【5】{@task.user.name}さんが
  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  def confirm
        # 【5】@task = current_user.tasks.build(task_params)
    @task = Task.new(task_params)
         # @task.user_id = current_task.id Buildメソッドにて省略
         # # 現在ログインしているuserのidを、taskのuser_idカラムに挿入する
    render :new if @task.invalid?
  end


  private
  def task_params
      # 【step3】merge 複数のハッシュを結合させるメソッド
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
      .merge(status: params[:task][:status].to_i, priority: params[:task][:priority].to_i)

  end

  def set_task
    @task = Task.find(params[:id])
  end
end
