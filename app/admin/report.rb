ActiveAdmin.register_page 'report' do
  menu priority: 7, label: proc { I18n.t('active_admin.report') }
  action_item :export_users do
    link_to I18n.t('active_admin.statistics'), admin_report_path, method: :post
  end

  controller do
    def date_interval
      report = params['report_form']
      return [nil, nil] unless report

      from_date = Time.find_zone('Moscow').local(
        report['from(1i)'].to_i,
        report['from(2i)'].to_i,
        report['from(3i)'].to_i,
        report['from(4i)'].to_i,
        report['from(5i)'].to_i
      )
      to_date = Time.find_zone('Moscow').local(
        report['to(1i)'],
        report['to(2i)'],
        report['to(3i)'],
        report['to(4i)'],
        report['to(5i)']
      )

      return [from_date, to_date]
    end
  end

  page_action :report, method: :post do
    from_date, to_date = date_interval
    send_data Services::UsersReport.call(from_date, to_date),
              type: 'application/octet-stream',
              filename: 'user.xlsx'
  end

  content title: proc { I18n.t('active_admin.users') } do
    render partial: 'form'
  end

end