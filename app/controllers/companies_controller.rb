class CompaniesController < ApplicationController
  before_action :authenticate_user!

  def index
    @companies = Company.order('created_at DESC')
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :post_code, :address, :website, :category_id, :occupation_id,
                                    :characteristic, :first_reason, :second_reason, :third_reason).merge(user_id: current_user.id)
  end

end