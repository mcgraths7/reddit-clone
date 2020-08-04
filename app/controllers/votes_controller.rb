class VotesController < ApplicationController
  def vote
    votable = set_post_or_comment
    author = User.find(votable.author_id)
    # If votable responds to "slug", it's a post. Otherwise, it's a comment. Nil if the vote isn't found
    found_vote_type = votable.respond_to?(:slug) ? 'Post' : 'Comment'
    Vote.toggle_vote(current_user.id, found_vote_type, votable.id, params[:vote_value].to_i)
    if params[:origin] === '/feed' || params[:origin] === '/'
      redirect_to feed_url
    elsif params[:origin].include?('posts')
      redirect_to post_url(set_post_or_comment)
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

  def render_feed
    pc = PostsController.new
    pc.request = request
    pc.response = response
    pc.process(:feed)
  end

  def render_post(post)
    pc = PostsController.new
    pc.request = request
    pc.response = response
    @post = post
    pc.show
  end

end