class DashboardController < ApplicationController
  def index
    @clientes_por_mes = Client.group_by_month(:created_at, format: "%B", locale: :es).count
    @clientes_por_mes = Client.group_by_month(:created_at, format: "%B", locale: :es).count
    @empresas_por_mes = Company.group_by_month(:created_at, format: "%B", locale: :es).count

    @resumen_por_tipo = {
      "Clientes" => Client.count,
      "Empresas" => Company.count
    }

    @total_clients = Client.count
    @total_companies = Company.count

    @ultimos_clientes = Client.order(created_at: :desc).limit(5)
  end
end
