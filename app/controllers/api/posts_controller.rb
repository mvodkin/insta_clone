class Api::PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      render :index
    else
      render json: @post.errors.full_messages, status: 422
    end
  end

  def show
    @post = Post.find(params[:id])
    if @post
      render :show
    else
      render json: "Post not found", status: 422
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render :index
    else
      render json: @post.errors.full_messages, status: 422
    end
  end

  def edit
    show
  end

  def index
    if params[:explore] == "true"
      @posts = Post.all.order("posts.id DESC").includes(:author, :likers, comments: :user)
    elsif params[:userId] == ""
      @posts = Post.feed(current_user)
        .preload(:author, :likers, comments: :user)
    else
      @posts = Post.where(user_id: params[:userId])
        .includes(:author, :likers, comments: :user)
    end
    render :index
  end

  private

  def post_params
    params.require(:post).permit(:description, drawing: [])
  end

end
