class CurrencyCbr < Dry::Struct
  attribute :ID, Types::String
  attribute :NumCode, Types::String
  attribute :CharCode, Types::String
  attribute :Nominal, Types::Integer
  attribute :Name, Types::String
  attribute :Value, Types::Coercible::Float
  attribute :Previous, Types::Coercible::Float
end
