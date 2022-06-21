RootApi::prefix :users_api

class Users < Grape::API
  helpers ParamsHelper, FiltersHelper

  desc 'Список пользователей'
  params do
    use :filters
  end
  get '/' do
    present user_scope, with: Entities::User
  end
  route_param :user_id, type: Integer do
    before do
      @user = user_scope.find params[:user_id]
    end
    desc 'Получить информацию о пользователе'
    params do
      use :filters
    end
    
    get '/' do
      present @user, with: Entities::User
    end
  end
end