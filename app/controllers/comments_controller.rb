class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    @comments = @article.comments
  end

  def create
    @comment = @article.comments.new(comment_params)
    if @comment.save
      redirect_to article_comments_path(@article), notice: 'Comment was successfully created.'
    else
      render :index, alert: 'Error creating comment.'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to article_comments_path(@article), notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_comments_path(@article), notice: 'Comment was successfully destroyed.'
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
