module Contracts
  class CurrencyCbr < Contracts::Application
    def self.call(options)
      new.call(options)
    end

    params do
      required(:ID).filled(:string)
      required(:NumCode).filled(:string)
      required(:CharCode).filled(:string)
      required(:Nominal).filled(:integer)
      required(:Name).filled(:string)
      required(:Value).filled(:float, gt?: 0)
      required(:Previous).filled(:float, gt?: 0)
    end

    rule(:ID) do
      key.failure('Поле ID должно состоять из 6-ти символов') unless value.size == 6
    end

    rule(:NumCode) do
      key.failure('Поле NumCode должно состоять из 3-х символа') unless value.size == 3
    end

    rule(:CharCode) do
      key.failure('Поле CharCode должно состоять из 3-х символа') unless value.size == 3
    end

  end
end
