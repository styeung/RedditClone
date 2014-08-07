class CommentsController < ApplicationController
  def new
    @comment = current_user.authored_comments.new
    @parent_type = params[:post_id].nil? ? :comment : :post
    @id = params[:post_id].nil? ? params[:comment_id] : params[:post_id]

    render :new
  end

  def create
    @comment = current_user.authored_comments.new(comment_params)

    if params[:post_id]
      @comment.post_id = params[:post_id]
    else
      parent_comment = Comment.find(params[:comment_id])
      @comment.parent_comment_id = parent_comment.id
      @comment.post_id = parent_comment.post_id
    end

    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy

    redirect_to post_url(@post)
  end

end
