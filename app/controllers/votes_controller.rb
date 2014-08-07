class VotesController < ApplicationController
  def create
    post_id = params[:comment_id] ? Comment.find(params[:comment_id]).post_id : params[:post_id]
    @voteable =
      params[:comment_id] ? Comment.find(params[:comment_id]) : Post.find(params[:post_id])
    @vote = current_user.votes.new(value: params[:value], voteable: @voteable)

    if @vote.save
      redirect_to post_url(post_id)
    else
      flash[:errors] = @vote.errors.full_messages
      redirect_to post_url(post_id)
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    post_id =
      @vote.voteable_type == "post" ? @vote.voteable_id : Comment.find(@vote.voteable_id).post_id

    if @vote.destroy
      redirect_to post_url(post_id)
    else
      flash[:errors] = @vote.errors.full_messages
      redirect_to post_url(post_id)
    end
  end
end
