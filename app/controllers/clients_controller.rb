class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to clients_path, notice: "Cliente guardado correctamente"
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    @client.update(client_params)
    redirect_to clients_path
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_path, status: :see_other
  end
end

private

def client_params
  params.require(:client).permit(:rfc, :fiscal_name, :fiscal_number, :postal, :phone, :email)
end
