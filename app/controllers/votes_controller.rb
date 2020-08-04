class VotesController < ApplicationController
  # before_action :cannot_up_or_downvote_own_comment, only: [:vote]

  def vote
    votable = set_post_or_comment
    author = User.find(votable.author_id)
    # If votable responds to "slug", it's a post. Otherwise, it's a comment. Nil if the vote isn't found
    found_vote_type = votable.respond_to?(:slug) ? 'Post' : 'Comment'
    Vote.toggle_vote(current_user.id, found_vote_type, votable.id, params[:vote_value].to_i)
    if params[:origin] === '/feed' || params[:origin] === '/'
      redirect_to feed_url
    elsif params[:origin].include?('posts')
      post_friendly_id = params[:origin].split('/').last # captures the end of the origin url, which includes the id
      post = Post.friendly.find(post_friendly_id)
      redirect_to post_url(post)
    elsif params[:origin].include?('comments')
      redirect_to comment_url(set_post_or_comment)
    end
  end

  private
  def set_post_or_comment
    if params[:id].to_i === 0
      # id is a Friendly_Id => Trying to upvote/downvote a post
      set_post
    elsif params[:id].to_i > 0
      # id is a number => Trying to upvote/downvote a comment
      set_comment
    end
  end

  def set_post
    Post.friendly.find(params[:id])
  end

  def set_comment
    Comment.find(params[:id])
  end

  # def cannot_up_or_downvote_own_comment
  #   comment = set_comment
  #   unless Vote.where(votable_id: comment.id, votable_type: 'Comment', user_id: current_user.id).empty?
  #     flash[:warning] =  'You may not upvote or downvote your own comment' 
  #   end
  # end

end