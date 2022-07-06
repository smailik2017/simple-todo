module Services
  class UsersImport
    include Callable

    def call(file_path)
      xlsx = Roo::Spreadsheet.open(file_path, extension: :xlsx)
      xlsx.default_sheet = xlsx.sheets.first

      roles = Role.all.map { |role| [role.code, role.id] }.to_h

      xlsx.each_row_streaming(pad_cells: true).each do |row|
        id, name, email, code, delete = parse_params(row)
        if delete == 'delete'
          Rails.logger.info "Delete user #{id}"
          User.find(id).destroy
        else
          begin
            usr = User.find(id)
            Rails.logger.info "Update user #{id}"
            usr.update(name: name, email: email, role_id: roles[code])

          rescue ActiveRecord::RecordNotFound
            Rails.logger.info 'Create user'
            if id.nil?
              Rails.logger.info 'Create user with new ID'
              User.create(name: name, email: email, role_id: roles[code], password: '111111')
            else
              Rails.logger.info "Create user with ID = #{id}"
              User.create(id: id, name: name, email: email, role_id: roles[code], password: '111111')
            end
          end
        end
      end
    end

    private

    def parse_params(row)
      [
        row[0].value.to_i, # id
        row[1].value,      # name
        row[2].value,      # email
        row[3].value,      # code (role)
        row[4].value       # delete?
      ]
    end
  end
end
