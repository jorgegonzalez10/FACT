class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.user = current_user
    if @company.save
      flash[:notice] = "¡Compañía creada exitosamente!"
      redirect_to companies_path
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @company = Company.find(params[:id])
    if @company.location.present?
      parts = @company.location.split(',').map(&:strip)
      @company.street = parts[0]
      @company.number = parts[1]
      @company.neighborhood = parts[2]
      @company.city = parts[3]
      @company.state = parts[4]
      @company.zip_code = parts[5]
    end
  end

  def update
    @company = Company.find(params[:id])
    @company.update(company_params)
    redirect_to company_path(@company)
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to companies_path, status: :see_other
  end

  private

  def company_params
    params.require(:company).permit(:name, :fiscal_number, :postal, :certificate, :location, :time, :photo,  :street, :number, :neighborhood, :city, :state, :zip_code)
  end
end
