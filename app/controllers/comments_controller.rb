class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_movie, only: [:create, :destroy]

  def create
    comment = Comment.new(comment_params)
    comment.assign_attributes(user: current_user, movie: @movie)
    if comment.save
      redirect_to movie_path(@movie), notice: "Comment created successfully"
    else
      flash[:alert] = comment.errors.full_messages
      render "movies/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to movie_path(@movie), notice: "The comment has been removed"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def fetch_movie
    @movie = Movie.find(params[:movie_id])
  end
end
