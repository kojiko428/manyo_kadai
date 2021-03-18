class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # binding.pry
      # # タスクの一覧
      # @tasks = Task.all
      # #=>新しい順の投稿一覧  created_atは作成日時 descは降
      # @tasks = Task.all.order(created_at: :desc)
    if params[:'タイトル検索'].present? && params[:'ステータス検索'].present?
      @tasks = Task.search_status_title params[:'タイトル検索'],params[:'ステータス検索']
    elsif params[:'タイトル検索'].present?
      @tasks = Task.search_title params[:'タイトル検索']
    elsif params[:'ステータス検索'].present?
      @tasks = Task.search_status params[:'ステータス検索']
    else
    # paramsでソートからのデータをキャッチ (nil?メソッド)
    if params[:sort_deadline].nil?
       # trueを返したら表示
      @tasks = Task.all.order(created_at: :desc)
    else
      @tasks = Task.all.order(deadline: :desc)
    end
    end
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
      redirect_to tasks_path , notice: " ブログを作成しました！"
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
      redirect_to tasks_path , notice: " ブログを編集しました！"
    else
      render :edit
    end
  end
     #【5】{@task.user.name}さんが
  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"ブログを削除しました！"
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
    params.require(:task).permit(:title, :content, :deadline, :status).merge(status: params[:task][:status].to_i)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
