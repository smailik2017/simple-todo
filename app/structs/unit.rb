class Unit < Dry::Struct
  attribute :name, Types::String
  attribute? :description, Types::String
  attribute :price, Types::Coercible::Float
  attribute :currency, Types::Currency
  attribute :attachments, Types::Array do
    attribute :name, Types::String
    attribute :url, Types::String
  end

  # Цена позиции в рублях
  def in_rub
    rate_currency(currency) * price
  end

  private

  # Курс валюты к рублю. 
  ## Если данные неправильные, возвращаем 0
  ## Если текущая валюты RUB возвращаем 1
  def rate_currency(valute)
    return 1 if valute == 'RUB'
    src = 'https://www.cbr-xml-daily.ru/daily_json.js'
    response = HTTParty.get(src)
    cbr = JSON.parse(response.body)['Valute'].select { |v| v == valute }[valute].map { |k, v| [k.to_sym, v] }.to_h
    result = Contracts::CurrencyCbr.call(cbr)
    result.success? ? result[:Value] : 0
  end

end
