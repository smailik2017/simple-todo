# frozen_string_literal: true

namespace :fill_test_data_1 do
  desc 'TODO'
  task execute: :environment do
    # Deleating all tables #
    puts 'Delete all data in tables'
    Item.delete_all
    Task.delete_all
    User.delete_all
    Role.delete_all
    State.delete_all
  end
end
