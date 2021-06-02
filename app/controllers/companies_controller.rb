class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, except: [:index, :new, :create]

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

  def show
    @comment = Comment.new
    @comments = @company.comments.includes(:user)
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to company_path(@company.id)
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to root_path
  end

  private
  def company_params
    params.require(:company).permit(:name, :post_code, :address, :website, :category_id, :occupation_id,
                                    :characteristic, :first_reason, :second_reason, :third_reason).merge(user_id: current_user.id)
  end

  def set_company
    @company = Company.find(params[:id])
  end

end