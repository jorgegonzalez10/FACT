# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

DetailInvoice.destroy_all
Invoice.destroy_all
Client.destroy_all
Company.destroy_all
User.destroy_all

User.create!(
  email: 'rodrigo@gmail.com',
  password: '123456',
  password_confirmation: '123456'
)

Client.create!([
  {
    fiscal_name: "Grupo Alcántar-Flores",
    rfc: "LVQN403987MKW",
    fiscal_number: 225332693,
    postal: "48045-4901",
    phone: "(796)022-2192",
    email: "eugeniamascarenas@fuentes.info",
    created_at: "2025-03-27 11:32:09"
  },
  {
    fiscal_name: "Bustamante, del Valle y Corona",
    rfc: "LBRQ943724RJP",
    fiscal_number: 264134385,
    postal: "43210-9534",
    phone: "+03(7)0718657858",
    email: "haroalejandro@maya.org",
    created_at: "2024-11-20 12:09:59"
  },
  {
    fiscal_name: "Industrias Nopalverde S.A.",
    rfc: "MNJX823456VZZ",
    fiscal_number: 248914327,
    postal: "01984-2103",
    phone: "555-144-2299",
    email: "contacto@nopalverde.com",
    created_at: "2025-01-05 15:44:21"
  },
  {
    fiscal_name: "Tacos El Güero Hermanos",
    rfc: "TGHR920811UIO",
    fiscal_number: 212854093,
    postal: "70293-1229",
    phone: "(555) 333-7788",
    email: "tacoselguero@protonmail.com",
    created_at: "2024-10-19 08:23:17"
  },
  {
    fiscal_name: "Logística y Carga Pacheco",
    rfc: "LCPR731026GHY",
    fiscal_number: 286192874,
    postal: "03420-8831",
    phone: "(33) 1034 5588",
    email: "info@logipacheco.mx",
    created_at: "2025-02-15 10:52:12"
  },
  {
    fiscal_name: "Construcciones Altiplano",
    rfc: "CALT860903PLH",
    fiscal_number: 251493812,
    postal: "88003-0405",
    phone: "5587-234-1190",
    email: "proyectos@altiplano.net",
    created_at: "2024-12-07 17:10:30"
  },
  {
    fiscal_name: "Transportes de Occidente",
    rfc: "TROC991115QES",
    fiscal_number: 238109284,
    postal: "39182-0284",
    phone: "555-903-1111",
    email: "ventas@occidente.com",
    created_at: "2025-03-03 09:19:46"
  },
  {
    fiscal_name: "Mercado Digital MX",
    rfc: "MDMX050623TSD",
    fiscal_number: 244509882,
    postal: "05300-2911",
    phone: "55 2048 8888",
    email: "soporte@mercadodigital.mx",
    created_at: "2024-11-11 18:47:00"
  },
  {
    fiscal_name: "Panadería Delicias Caseras",
    rfc: "PADC950212KWN",
    fiscal_number: 211987322,
    postal: "03630-4392",
    phone: "55 3081 3322",
    email: "delicias@pan.mx",
    created_at: "2024-12-25 07:55:33"
  },
  {
    fiscal_name: "Consultoría Verde y Asociados",
    rfc: "CVYA780303MZT",
    fiscal_number: 275932839,
    postal: "10384-9830",
    phone: "5584-9283",
    email: "contacto@verdeasociados.org",
    created_at: "2025-01-30 16:00:11"
  },
  {
    fiscal_name: "Café La Montaña",
    rfc: "CLMT871020UIE",
    fiscal_number: 200983123,
    postal: "84200-2841",
    phone: "771-223-8822",
    email: "lamontaña@cafes.mx",
    created_at: "2025-03-12 14:38:45"
  },
  {
    fiscal_name: "Diseños Agave Azul",
    rfc: "DAAZ970611JRB",
    fiscal_number: 261927347,
    postal: "52418-0392",
    phone: "33 1414 1029",
    email: "info@agaveazul.com",
    created_at: "2025-04-02 11:04:00"
  },
  {
    fiscal_name: "Estudio Legal Ocampo",
    rfc: "ELOC880512SDF",
    fiscal_number: 276198430,
    postal: "30184-2041",
    phone: "55-1123-9348",
    email: "asesoria@ocampolegal.com",
    created_at: "2024-10-27 20:30:49"
  },
  {
    fiscal_name: "Ferretería El Martillo",
    rfc: "FEMR920129UKW",
    fiscal_number: 202847298,
    postal: "04019-2891",
    phone: "55 4512 7783",
    email: "contacto@ferremartillo.mx",
    created_at: "2025-01-16 12:48:55"
  },
  {
    fiscal_name: "Agencia Creativa Prisma",
    rfc: "ACPR941203EWT",
    fiscal_number: 231092284,
    postal: "90840-9184",
    phone: "33 9238 8888",
    email: "hola@prismacreativa.com",
    created_at: "2025-04-13 09:17:12"
  }
])


company1 = Company.create!(
  name: "Facturas del Norte S.A.",
  rfc: "FNRT920101AAA",
  fiscal_number: 123456789,
  postal: 12345,
  certificate: "CERT123",
  location: "Monterrey, NL",
  time_date: Date.today,
  user: User.first
)

company2 = Company.create!(
  name: "Grupo Contable del Sur",
  rfc: "GCSU950202BBB",
  fiscal_number: 987654321,
  postal: 54321,
  certificate: "CERT456",
  location: "Mérida, Yucatán",
  time_date: Date.today,
  user: User.first
)

# Distribuir los 15 clientes entre ambas compañías
clients = Client.all.shuffle
half = clients.size / 2

clients[0...half].each { |client| client.update!(company: company1) }
clients[half..].each { |client| client.update!(company: company2) }

# Crear facturas aleatorias para cada cliente
payment_types = ["PUE", "PPD"]
payment_methods = ["03 - Transferencia electrónica", "01 - Efectivo", "04 - Tarjeta de crédito"]

clients.each do |client|
  rand(2..5).times do
    created_at = rand(Date.new(2024, 10, 1)..Date.today).to_datetime
    sub_total = rand(1000..10000)
    taxes = (sub_total * 0.16).round(2)
    total = (sub_total + taxes).round(2)

    Invoice.create!(
      company: client.company,
      client: client,
      payment_type: payment_types.sample,
      payment_method: payment_methods.sample,
      sub_total: sub_total,
      taxes: taxes,
      total: total,
      created_at: created_at,
      updated_at: created_at
    )
  end
end
