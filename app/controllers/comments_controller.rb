class CommentsController < ApplicationController
  before_action :must_be_logged_in!
  def new
    @post = Post.find_by(id: params[:post_id]) 
    @comment = Comment.new
    render :new
  end
  
  def create
    if comment_params
      save_comment(comment_params)
    elsif reply_params
      save_comment(reply_params)
    end
  end

  def show
    @comment = set_comment
    @post = set_post
    render :show
  end

  private

  # This allows me to save either a child comment or top level without repeating code
  def save_comment(comment_or_reply_params)
    @comment = Comment.new(comment_or_reply_params)
    @comment.author_id = current_user.id
    post = Post.find_by(id: comment_or_reply_params[:post_id])
    if reply_params && @comment.save
      parent_comment = Comment.find_by(id: @comment.parent_comment_id)
      redirect_to comment_url(parent_comment)
    elsif comment_params && @comment.save
      redirect_to post_url(post)
    else
      flash[:error] = 'We had a problem saving your comment'
      redirect_to post_url(post)
    end
      
  end

  def comment_params
    if params[:comment]
      params.require(:comment).permit(:post_id, :content)
    else 
      nil
    end
  end

  def reply_params
    if params[:reply]
      params.require(:reply).permit(:post_id, :content, :parent_comment_id)
    else
      nil
    end
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def set_post
    @post = Post.find_by(id: set_comment.post_id)
  end
end
