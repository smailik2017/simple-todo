module Entities
  class Task < Grape::Entity
    include ActionView::Helpers::TextHelper
    root  'tasks', 'task'

    expose  :id,
            :name,
            :description,
            :done,
            :deadline
  
    expose  :user, using: 'Entities::User' do |task, _|
      task.user
    end

    def name
      truncate(object.name)
    end

    def description
      truncate(object.description)
    end
  end

  class User < Grape::Entity
    include ActionView::Helpers::TextHelper
    root  'users', 'user'

    expose  :id,
            :name,
            :email
  
    expose :role, using: 'Entities::Role' do |user, _|
      user.role
    end
  end

  class Role < Grape::Entity
    include ActionView::Helpers::TextHelper
    root  'roles', 'role'

    expose  :id,
            :name,
            :code
  
  end
end
