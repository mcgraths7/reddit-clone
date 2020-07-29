class TopicsController < ApplicationController
  before_action :only_moderator_can_edit_topic, only: [:edit, :update, :destroy]
  before_action :topic_must_exist, only: [:show, :edit, :update, :destroy]
  before_action :must_be_logged_in!
  def index
    @feed_posts = current_user.feed_posts
    render :feed
  end

  def new
    @topic = Topic.new
    render :new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.moderator_id = current_user.id
    if @topic.save
      flash[:info] = 'Topic created successfully'
      redirect_to topic_url(@topic)
    else
      flash.now[:error] = @topic.errors.full_messages
      render :new
    end
  end

  def show
    @topic = set_topic
    render :show
  end

  def edit
    @topic = set_topic
    render :edit
  end

  def update
    @topic = set_topic
    if @topic.update(topic_params)
      flash[:info] = "Successfully updated #{@topic.title}"
      redirect_to topic_url(@topic)
    else
      flash.now[:error] = @topic.errors.full_messages
      render :edit
    end
  end

  def destroy
    @topic = set_topic
    @topic.destroy
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :description, :id)
  end

  def set_topic
    Topic.find_by(id: params[:id])
  end

  def only_moderator_can_edit_topic
    unless current_user.id === set_topic.moderator_id
      flash[:error] = 'Only the moderator may edit this topic'
      redirect_to topic_url(current_topic)
    end
  end

  def topic_must_exist
    @topic = set_topic
    if @topic.nil?
      flash[:error] = "Topic not found"
      redirect_to 'shared/not_found'
    end
  end
end