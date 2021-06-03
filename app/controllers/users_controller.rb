class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @category_graph_data = Company.category_data_acquisition_for_graphs
  end

end
