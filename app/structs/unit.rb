class Unit < Dry::Struct
  attribute :name, Types::String
  attribute? :description, Types::String
  attribute :price, Types::Coercible::Float
  attribute :currency, Types::Currency
  attribute :attachments, Types::Array do
    attribute :name, Types::String
    attribute :url, Types::String
  end

  def in_rub
    return price if currency == 'RUB'
    rate_currency(currency) * price
  end

  private

  def rate_currency(valute)
    src = 'https://www.cbr-xml-daily.ru/daily_json.js'
    response = HTTParty.get(src)
    CurrencyCbr.new(JSON.parse(response.body)['Valute'].select { |v| v == valute }[valute].map { |k, v| [k.to_sym, v] }.to_h).Value
  end

end
