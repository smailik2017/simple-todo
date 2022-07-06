if Rails.env.development?
  namespace :aasm_diagram_traffic_light do
    desc 'generate diagrams'
    task traffic_light: :environment do
      AASMDiagram::Diagram.new(TrafficLight.new.aasm, 'tmp/traffic_light.png')
      puts 'Diagram created in tmp/traffic_light.png'
    end
  end
end
