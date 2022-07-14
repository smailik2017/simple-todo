module Types
  include Dry.Types()
  Currency = Types::String.default('RUB').enum('RUB', 'USD', 'EUR')
end
