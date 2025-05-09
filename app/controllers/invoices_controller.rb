class InvoicesController < ApplicationController
  def index
    @pagy, @invoices = pagy(Invoice.all)
  end

  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Factura_#{@invoice.id}",
               template: "invoices/show",
               layout: "pdf",
               formats: [:html],
               locals: { pdf: true }
      end
      format.xml
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to invoice_path(@invoice), notice: 'Factura actualizada.'
    else
      redirect_to invoice_path(@invoice), alert: 'Error al actualizar.'
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy
    redirect_to invoices_path, status: :see_other
  end

  def new
    @invoice = Invoice.new
    @detail_invoice = @invoice.detail_invoices.build

    @companies = Company.all
    @clients = Client.all
    @company = Company.new
    @client = Client.new
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      @invoice.calculated_totals
      redirect_to @invoice, notice: 'Factura creada con éxito.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(
      :company_id, :client_id, :payment_type, :payment_method, :sub_total, :taxes, :total,
      detail_invoices_attributes: [:product_number, :amount, :unit_value, :description]
    )
  end
end
