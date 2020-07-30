class CommentsController < ApplicationController
  before_action :must_be_logged_in!
  def new
    @post = Post.find_by(id: params[:post_id]) 
    @comment = Comment.new
    render :new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    post = Post.find_by(id: @comment.post_id)
    if @comment.save
      redirect_to post_url(post)
    else
      flash.now[:error] = 'We had a problem saving your comment'
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :content, :parent_comment_id)
  end
end
