if Rails.env.development?
  namespace :aasm_diagram_task do
    desc 'generate diagrams'
    task task: :environment do
      AASMDiagram::Diagram.new(Task.new.aasm, 'tmp/task.png')
      puts 'Diagram created in tmp/task.png'
    end
  end
end
