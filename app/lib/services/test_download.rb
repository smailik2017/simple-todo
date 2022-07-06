module Services
  class TestDownload
    include Callable

    def call
      package, sheet = excel_create
      (-5..5).each_with_index do |x, i|
        sheet.add_row [x, "=A#{i+1}*A#{i+1}"]
      end

      package.to_stream.read
    end

    private

    def excel_create
      package = Axlsx::Package.new
      workbook = package.workbook
      sheet = workbook.add_worksheet(name: I18n.t('active_admin.test_data'))

      [package, sheet]
    end

  end
end
