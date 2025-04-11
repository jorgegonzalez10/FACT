xml.instruct!
xml.FacturaElectronica do
  xml.DatosGenerales do
    xml.Version "1.0"
    xml.Serie "A"
    xml.Folio @invoice.id
    xml.Fecha @invoice.created_at.strftime("%Y-%m-%dT%H:%M:%S")
    xml.FormaDePago @invoice.payment_method
    xml.MetodoDePago @invoice.payment_type
    xml.Moneda "MXN"
    xml.TipoDeComprobante "ingreso"
  end

  xml.Emisor do
    xml.Rfc @invoice.company.rfc
    xml.Nombre @invoice.company.name
    xml.RegimenFiscal @invoice.company.fiscal_number
    xml.Domicilio do
      xml.Calle "Calle falsa 123"
      xml.Colonia "Centro"
      xml.Municipio "Ciudad de México"
      xml.Estado "CDMX"
      xml.Pais "México"
      xml.CodigoPostal @invoice.company.postal
    end
  end

  xml.Receptor do
    xml.Rfc @invoice.client.rfc
    xml.Nombre @invoice.client.fiscal_name
    xml.UsoCFDI "G03"
    xml.Domicilio do
      xml.Calle "Av. siempre viva 456"
      xml.Colonia "Industrial"
      xml.Municipio "Guadalajara"
      xml.Estado "Jalisco"
      xml.Pais "México"
      xml.CodigoPostal @invoice.client.postal
    end
  end

  xml.Conceptos do
    @invoice.detail_invoices.each do |detail|
      xml.Concepto do
        xml.ClaveProdServ "01010101"
        xml.NoIdentificacion detail.product_number
        xml.Cantidad detail.amount
        xml.ClaveUnidad "H87"
        xml.Unidad "Pieza"
        xml.Descripcion detail.description
        xml.ValorUnitario detail.unit_value
        xml.Importe detail.amount * detail.unit_value
        xml.Impuestos do
          xml.Traslados do
            xml.Traslado do
              xml.Base detail.amount * detail.unit_value
              xml.Impuesto "002"
              xml.TipoFactor "Tasa"
              xml.TasaOCuota "0.1600"
              xml.Importe detail.amount * detail.unit_value * 0.16
            end
          end
        end
      end
    end
  end

  xml.Impuestos do
    xml.TotalImpuestosTrasladados @invoice.taxes
    xml.Traslados do
      xml.Traslado do
        xml.Impuesto "002"
        xml.TipoFactor "Tasa"
        xml.TasaOCuota "0.1600"
        xml.Importe @invoice.taxes
      end
    end
  end

  xml.Complemento do
    xml.TimbreFiscalDigital do
      xml.UUID SecureRandom.uuid.upcase
      xml.FechaTimbrado Time.now.strftime("%Y-%m-%dT%H:%M:%S")
      xml.RfcProvCertif "AAA010101AAA"
      xml.SelloCFD SecureRandom.hex(32).upcase
      xml.NoCertificadoSAT rand(10**20).to_s.rjust(20,'0')
      xml.SelloSAT SecureRandom.hex(32).upcase
    end
  end

  # Secciones adicionales para hacerlo más extenso
  10.times do |i|
    xml.CampoAdicional do
      xml.Nombre "InformacionExtra#{i}"
      xml.Valor "Valor de ejemplo #{i}"
    end
  end

  xml.Observaciones "Factura generada automáticamente el #{Time.now.strftime('%d/%m/%Y')}"
  xml.VersionCFDI "4.0"
  xml.SelloDigital SecureRandom.hex(64).upcase
  xml.CadenaOriginal "||#{@invoice.id}|#{@invoice.company.rfc}|#{Time.now.strftime('%Y-%m-%d')}||"
end
