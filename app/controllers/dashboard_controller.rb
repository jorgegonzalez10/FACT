class DashboardController < ApplicationController
  def index
    # Clientes y empresas por mes
    @clientes_por_mes = Client.group_by_month(:created_at, format: "%B", locale: :es).count
    @empresas_por_mes = Company.group_by_month(:created_at, format: "%B", locale: :es).count

    # Facturas por mes (conteo y suma total)
    @invoices_by_month = Invoice.group_by_month(:created_at, format: "%B", locale: :es, default_value: 0, last: 12).count
    @total_invoice_amount_by_month = Invoice.group_by_month(:created_at, format: "%B", locale: :es, default_value: 0, last: 12).sum(:total)


    # Proporción de facturas por empresa
    @invoices_by_company = Invoice.joins(:company).group('companies.name').count

    # Resumen general de entidades
    @resumen_por_tipo = {
      "Clientes" => Client.count,
      "Empresas" => Company.count
    }

    @total_clients = Client.count
    @total_companies = Company.count

    # Últimos clientes registrados
    @ultimos_clientes = Client.order(created_at: :desc).limit(5)

    # Total de facturas
    @invoices = Invoice.all
    @invoices_count = @invoices.count

    # Promedio mensual de facturación
    if @total_invoice_amount_by_month.present?
      total_sum = @total_invoice_amount_by_month.values.sum
      month_count = @total_invoice_amount_by_month.values.size
      @monthly_avg = (total_sum / month_count.to_f).round(2)
    else
      @monthly_avg = 0
    end
  end
end
