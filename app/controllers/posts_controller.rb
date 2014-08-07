class PostsController < ApplicationController
  def new
    @post = current_user.authored_posts.new
    render :new
  end

  def create
    @post = current_user.authored_posts.new(post_params)

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = current_user.authored_posts.find(params[:id])
    if @post
      render :edit
    else
      render status: 401
    end
  end

  def update
    @post = current_user.authored_posts.find(params[:id])
    if @post.nil?
      render status: 401
    elsif @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments_by_parent_id

    render :show
  end

end


