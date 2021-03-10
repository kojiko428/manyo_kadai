class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(task_id: params[:task_id])
    redirect_to tasks_path, notice: "#{favorite.task.user.name}さんのタスクをお気に入り登録しました"
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to tasks_path, notice: "#{favorite.task.user.name}さんのタスクをお気に入り解除しました"
  end
end
