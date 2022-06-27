# frozen_string_literal: true

RootApi.prefix :tasks_api

class Tasks < Grape::API
  helpers ParamsHelper, FiltersHelper

  desc 'Список дел'
  params do
    use :filters
  end
  get '/' do
    present task_scope, with: Entities::Task
  end
  route_param :task_id, type: Integer do
    before do
      @task = task_scope.find params[:task_id]
    end
    desc 'Получить информацию о деле'
    params do
      use :filters
    end

    get '/' do
      present @task, with: Entities::Task
    end
  end
end
