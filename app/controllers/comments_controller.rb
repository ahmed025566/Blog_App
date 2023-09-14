class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(user_id: current_user.id, post_id: params[:post_id], **comment_params)

    if @comment.save
      flash[:notice] = 'comment created successfully'
      redirect_to user_post_path(user_id: current_user.id, id: params[:post_id])
    else
      render :new, alert: 'An error has occurred while creating the comment'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.post.comments_counter -= 1
    @comment.post.save
    @comment.destroy
    redirect_to user_posts_path
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def index
    @comments = Comment.all
    render json: @comments
  end
end
