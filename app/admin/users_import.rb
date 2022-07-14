ActiveAdmin.register_page 'import_export_users' do
  menu prioroty: 6, label: proc { I18n.t('active_admin.import_export_users') }

  page_action :download, method: :post do
    send_data Services::Users::Download.call,
              type: 'application/octet-stream',
              filename: 'user.xlsx'
  end

  page_action :upload, method: :post do
    Services::Users::Import.call(params['uploads_form']['excel'].tempfile)
    flash[:notice] = I18n.t('active_admin.notice.users_updated_succsessfuly')
    redirect_to action: :index
  end

  content title: proc { I18n.t('active_admin.import_export_users') } do
    panel I18n.t('active_admin.export') do
      semantic_form_for 'downloads_form', url: { action: :download } do |f|
        f.button I18n.t('active_admin.button.download')
      end
    end

    panel I18n.t('active_admin.import') do
      form_for 'uploads_form', url: { action: :upload }, html: { multipart: true } do |f|
        f.file_field :excel, as: :file
        f.button I18n.t('active_admin.button.upload')
      end
    end

  end
end