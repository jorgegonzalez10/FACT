class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def create
    @company = Company.new(company_params)
    @company.user = current_user
    if @company.save
      if  params[:company][:origin] == 'invoice_modal'
        redirect_to new_invoice_path
      else
        redirect_to companies_path
      end
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
    params.require(:company).permit(:origin, :name, :fiscal_number, :postal, :certificate, :location, :time, :photo,  :street, :number, :neighborhood, :city, :state, :zip_code)
  end
end
