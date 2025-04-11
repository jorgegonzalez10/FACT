xml.instruct!
  xml.invoice do
    xml.id @invoice.id
    xml.company do
      xml.name @invoice.company.name
      xml.rfc @invoice.company.rfc
      xml.fiscal_number @invoice.company.fiscal_number
      xml.location @invoice.company.location
      xml.postal @invoice.company.postal
    end
    xml.client do
      xml.name @invoice.client.fiscal_name
      xml.rfc @invoice.client.rfc
      xml.fiscal_number @invoice.client.fiscal_number
      xml.phone @invoice.client.phone
      xml.email @invoice.client.email
      xml.postal @invoice.client.postal
    end
    xml.details do
      @invoice.detail_invoices.each do |detail|
        xml.detail do
          xml.amount detail.amount
          xml.product_number detail.product_number
          xml.description detail.description
          xml.unit_value number_with_precision(detail.unit_value, precision: 2)
          xml.total number_with_precision(detail.amount * detail.unit_value, precision: 2)
        end
      end
    end
    xml.totals do
      xml.subtotal number_with_precision(@invoice.sub_total, precision: 2)
      xml.taxes number_with_precision(@invoice.taxes, precision: 2)
      xml.total number_with_precision(@invoice.total, precision: 2)
    end
  end
