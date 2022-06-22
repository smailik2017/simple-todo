# frozen_string_literal: true

class RootApi < Grape::API
  format :json

  mount Tasks
  mount Users
  mount Roles
end
