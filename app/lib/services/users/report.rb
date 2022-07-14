class Services::Users::Report
  include Callable
  extend Dry::Initializer

  param :from
  param :to

  def call
    package = Axlsx::Package.new
    workbook = package.workbook
    sheet = workbook.add_worksheet(name: I18n.t('active_admin.users'))
    
    scope(from, to).find_each do |user|
      sheet.add_row [user.name, user.tasks.size, user.items.size]
    end
    package.to_stream.read
  end
  
  private
  
  def scope(from, to)
    scope = User.includes(tasks: :items).order(:name)
    scope = scope.where(created_at: from..to) if from || to
    scope
  end
end