class Unit < Dry::Struct
  Currency = Types::String.default('RUB').enum('RUB', 'USD', 'EUR')

  attribute :name, Types::String
  attribute? :description, Types::String
  attribute :price, Types::Coercible::Float
  attribute :currency, Currency
  attribute :attachments, Types::Array do
    attribute :name, Types::String
    attribute :url, Types::String
  end
end

# u = Unit.new(
#   name: 'MacBookPro',
#   description: 'Описание',
#   price: 200000.0,
#   attachments: [
#     { name: 'Внешний вид', url: '/apple/macbookpro/view.jpg' },
#     { name: 'Вид сбоку', url: '/apple/macbookpro/side_view.jpg' }
#   ]
# )

# unit = {
#   name: 'MacBookPro',
#   description: 'Описание',
#   price: 200000.0,
#   attachments: [
#     { name: 'Внешний вид', url: '/apple/macbookpro/view.jpg' },
#     { name: 'Вид сбоку', url: '/apple/macbookpro/side_view.jpg' }
#   ]
# }
