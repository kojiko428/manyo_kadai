class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

     def index
      @tasks = Task.all
      # binding.pry # raise
     end
     def new
      @task =Task.new
     end
     # 追記する
     def create
       @task = current_user.tasks.build(task_params)
       # @task=Task.create(task_params)
       # @task.user_id = current_task.id  ↑Buildメソッドにて省略
       # 現在ログインしているuserのidを、taskのuser_idカラムに挿入する
       if params[:back]
        render :new
      elsif @task.save
       # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
        redirect_to new_task_path , notice: " #{@task.user.name}さんがブログを作成しました！"
       else
       # 入力フォームを再描画します。
        render :new
        end
     end

    def show
      @favorite = current_user.favorites.find_by(task_id: @task.id)
      # @task = Task.find(params[:id])
    end

    def edit
      # @task = Task.find(params[:id])
    end
    def update
      # @task = Task.find(params[:id])

      if @task.update(task_params)
        redirect_to tasks_path , notice: " #{@task.user.name}さんがブログを編集しました！"
      else
        render :edit
      end
    end

     def destroy
       @task.destroy
       redirect_to tasks_path, notice:"#{@task.user.name}さんがブログを削除しました！"
     end

     def confirm
        @task = current_user.tasks.build(task_params)
         # @task = Task.new(task_params)
         # @task.user_id = current_task.id Buildメソッドにて省略
         # # 現在ログインしているuserのidを、taskのuser_idカラムに挿入する
         render :new if @task.invalid?
       end


    private
    def task_params
      params.require(:task).permit(:title, :content)
    end
    def set_task
    @task = Task.find(params[:id])
    end


end
