class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.user = current_user
    if @company.save
      redirect_to companies_path(@companies)
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to companies_path, status: :see_other
  end

  private

  def company_params
    params.require(:company).permit(:name, :fiscal_number, :postal, :certificate, :location, :time, :photo)
  end
end
