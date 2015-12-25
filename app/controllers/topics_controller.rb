class TopicsController < ApplicationController
	before_action :authenticate_user!, :except => [:index]
  before_action :set_topic, :only => [:edit, :show, :destroy, :update]


	def index
    @topics = Topic.page(params[:page]).per(5)
  end
  


  def show
  	@comments = @topic.comments 

  	if params[:comment_id]
      @comment = Comment.find(params[:comment_id])
    else
      @comment = Comment.new
    end 
  end


	def new
    @topic = Topic.new
	end

	def create
		@topic = Topic.new(topic_params)
		@topic.user = current_user

		if @topic.save
		  redirect_to topics_path
		  flash[:notice] = "event was successfully created"
		else
			render :action => :new
		end
  end


  def edit
  end


	def update
		if @topic.update(topic_params)
		  redirect_to topics_path
		  flash[:notice] = "event was successfully updated"
		else
			render :action => :edit
		end
    
	end

  def destroy
  	@topic.destroy
  	flash[:alert] = "event was successfully deleted"
  	redirect_to :action => :index
  end


  private

  def topic_params
  	params.require(:topic).permit(:title, :content, :category_id )

  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
