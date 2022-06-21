module ParamsHelper
  extend Grape::API::Helpers

  params :filters do
    optional  :all,
              type: Boolean,
              desc: 'весь список дел, включая завершенные'
  end
end
