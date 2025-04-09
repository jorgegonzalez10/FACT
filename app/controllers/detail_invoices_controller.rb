class DetailInvoicesController < ApplicationController
  before_action :set_invoice

  def new
    @detail_invoice = @invoice.detail_invoices.build
  end

  def create
    @detail_invoice = @invoice.detail_invoices.build(detail_invoice_params)

    if @detail_invoice.save
      redirect_to @invoice, notice: "Detalle de factura agregado."
    else
      render :new
    end
  end

  def destroy
    @detail_invoice = @invoice.detail_invoices.find(params[:id])
    @detail_invoice.destroy
    redirect_to @invoice, notice: "Detalle de factura eliminado."
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:invoice_id])
  end

  def detail_invoice_params
    params.require(:detail_invoice).permit(:product_number, :amount, :unit_value, :description)
  end
end
