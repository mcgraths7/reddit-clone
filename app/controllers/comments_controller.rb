class CommentsController < ApplicationController
  before_action :must_be_logged_in!
  before_action :cannot_up_or_downvote_own_comment, only: [:upvote, :downvote]
  
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
    @comments_by_parent = set_post.comments_by_parent
    render :show
  end


  def upvote
    comment = set_comment
    author = User.find(comment.author_id)
    comment.votes << Vote.create(user_id: current_user.id, value: 1)
    if comment.update(karma: comment.karma + 1) && author.update(comment_karma: author.comment_karma + 1)
      redirect_to post_url(comment.post)
    else
      flash[:error] = 'There was a problem upvoting.'
      redirect_to post_url(comment.post)
    end
  end

  def downvote
    comment = set_comment
    author = User.find(comment.author_id)
    comment.votes << Vote.create(user_id: current_user.id, value: -1)
    if comment.update(karma: comment.karma - 1) && author.update(comment_karma: author.comment_karma - 1)
      redirect_to post_url(comment.post)
    else
      flash[:error] = 'There was a problem upvoting.'
      redirect_to post_url(comment.post)
    end
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

  def cannot_up_or_downvote_own_comment
    comment = set_comment
    unless Vote.where(votable_id: comment.id, votable_type: 'Comment', user_id: current_user.id).empty?
      flash[:warning] =  'You may not upvote or downvote your own comment' 
    end
  end
end
