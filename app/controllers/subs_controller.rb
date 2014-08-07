class SubsController < ApplicationController
  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = current_user.moderated_subs.new
    render :new
  end

  def create
    @sub = current_user.moderated_subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.moderator != current_user
      flash[:notice] = ["You are not authorized to edit this sub."]
      redirect_to sub_url(@sub)
    elsif @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
