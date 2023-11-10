class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    respond_to do |format|
      format.html do
        @comment = Comment.new(user_id: current_user.id, post_id: params[:post_id], **comment_params)

        if @comment.save
          flash[:notice] = 'Your comment was added successfully'
          redirect_to user_posts_path(params[:user_id])
        else
          flash[:alert] = 'Opps, something went wrong, try again!'
          render :new
        end
      end
      format.json do
        @comment = Comment.new(user: User.find(params[:user_id]), post: Post.find(params[:post_id]), **comment_params)
        render json: { message: 'Comment created successfully' }, status: 201 if @comment.save

        render json: @comment.errors, status: 401 unless @comment.save
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Invalid post or user id' }, status: 422
      end
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
