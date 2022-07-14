module Contracts
  class Unit < Contracts::Application
    def self.call(options)
      new.call(options)
    end

    params do
      required(:name).filled(:string)
      optional(:description).maybe(:string)
      required(:price).value(:float, gt?: 0)
      optional(:currency).maybe(:string)
      required(:attachments).array(:hash) do
        required(:name).filled(:string)
        required(:url).filled(:string)
      end
    end

    rule(:name) do
      key.failure('Длина названия превышает 80 символов') if value.size > 80
    end

    rule(:description) do
      unless value.nil?
        key.failure('Длина Описания должна быть не менее 100 символов') if value.size < 100
      end
    end

    rule(:attachments) do
      key.failure('Колличество вложение должно быть больше одного и не более 10') unless (2..10).include?(value.size)
    end

  end
end
