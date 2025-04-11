class InvoiceMailer < ApplicationMailer
  def send_pdf
    @user = params[:user]
    @invoice = params[:invoice]

    pdf = WickedPdf.new.pdf_from_string(
      ApplicationController.render(
        template: "invoices/show",
        layout: "pdf",
        assigns: { invoice: @invoice, pdf: true }
      )
    )

    attachments["factura-#{@invoice.id}.pdf"] = {
      mime_type: 'application/pdf',
      content: pdf
    }

    mail(
      to: @user.email,
      subject: "Factura ##{@invoice.id} en PDF"
    )
  end
end

