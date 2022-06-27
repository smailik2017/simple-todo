# frozen_string_literal: true

RootApi.prefix :roles_api

class Roles < Grape::API
  helpers ParamsHelper, FiltersHelper

  desc 'Список ролей'
  params do
    use :filters
  end
  get '/' do
    present role_scope, with: Entities::Role
  end
  route_param :role_id, type: Integer do
    before do
      @role = role_scope.find params[:role_id]
    end
    desc 'Получить информацию о роли'
    params do
      use :filters
    end

    get '/' do
      present @role, with: Entities::Role
    end
  end
end
