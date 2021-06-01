class CommentsController < ApplicationController

  def create
    Comment.create(comment_params)
    redirect_to company_path(@company.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, company_id: params[:company_id])
  end

end
