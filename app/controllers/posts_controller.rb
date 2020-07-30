class PostsController < ApplicationController
  before_action :post_must_exist, only: [:show, :edit, :update]
  before_action :only_owner_can_edit_post, only: [:edit, :update]
  before_action :only_moderator_or_owner_can_destroy_post, only: [:destroy]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.topic_id = topic_param[:topic_id]
    if @post.save
      render :show
    else
      flash.now[:error] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = set_post
    @comments_by_parent = @post.comments_by_parent
    render :show
  end

  def edit
    @post = set_post
    render :edit
  end

  def update
    @post = set_post
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:error] = 'There was a problem'
      render :edit
    end
  end

  def destroy
    @post = set_post
    if @post.destroy
      redirect_to topics_url
    else
      flash.now[:error] = 'Post could not be deleted'
      render :show
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :url, :topic_id)
  end

  def set_post
    Post.find_by(id: params[:id])
  end

  def topic_param
    params.permit(:topic_id)
  end

  def post_must_exist
    @post = set_post
    if @post.nil?
      flash[:error] = 'Post not found'
      redirect_to topic_url(set_topic)
    end
  end

  def only_owner_can_edit_post
    unless current_user.id === set_post.author_id
      flash[:warning] = 'Only the author may edit the post'
      redirect_to post_url(set_post)
    end
  end

  def only_moderator_or_owner_can_destroy_post
    unless current_user.id === set_post.author_id || current_user.id === set_topic.moderator_id
      flash[:warning] = 'Only the post owner or the topic moderator may destroy this post'
      redirect_to post_url(set_post)
    end
  end
end
