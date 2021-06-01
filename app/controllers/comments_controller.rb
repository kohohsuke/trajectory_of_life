class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comment_params)
    redirect_to "/companies/#{@comment.company.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, company_id: params[:company_id])
  end

end
