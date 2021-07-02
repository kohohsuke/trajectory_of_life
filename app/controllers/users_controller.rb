class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @category_graph_data = Company.category_data_acquisition_for_graphs
  end

end
