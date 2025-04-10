class DashboardController < ApplicationController
  def index
    @clientes_por_mes = Client.group_by_month(:created_at, format: "%B", locale: :es).count
    @clientes_por_mes = Client.group_by_month(:created_at, format: "%B", locale: :es).count
    @empresas_por_mes = Company.group_by_month(:created_at, format: "%B", locale: :es).count
    @invoices_by_month = Invoice.group_by_month(:created_at, format: "%B", locale: :es).count
    @total_invoice_amount_by_month = Invoice.group_by_month(:created_at, format: "%B", locale: :es).sum(:total)
    @invoices_by_company = Invoice.joins(:company)
                               .group('companies.name')
                               .count

    @resumen_por_tipo = {
      "Clientes" => Client.count,
      "Empresas" => Company.count
    }

    @total_clients = Client.count
    @total_companies = Company.count

    @ultimos_clientes = Client.order(created_at: :desc).limit(5)
  end
end
