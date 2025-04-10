xml.instruct!
  xml.invoice do
    xml.id @invoice.id
    xml.sub_total @invoice.sub_total
    xml.taxes @invoice.taxes
    xml.total @invoice.total
    xml.company @invoice.company.name
    xml.client @invoice.client.name
  end
