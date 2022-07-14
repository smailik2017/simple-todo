require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

class User
  extend Dry::Initializer

  param :first_name
  param :last_name
  param :middle_name, default: proc { '-' }
  option :email
  option :login, optional: true
end

user = User.new 'Иванов', 'Сергей', email: 's.ivanov@example.com'
# user = User.new 'Иванов', 'Сергей', 'Петрович', email: 's.ivanov@example.com'
# user = User.new 'Иванов', 'Сергей', 'Петрович'
# user = User.new

p user.first_name # => 'Иванов'
p user.last_name # => 'Сергей'
p user.middle_name # => 'Петрович'
p user.email # => 's.ivanov@example.com'
p user.login # => nil
