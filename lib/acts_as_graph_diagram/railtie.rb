# frozen_string_literal: true

module ActsAsGraphDiagram
  class Railtie < ::Rails::Railtie
    initializer 'acts_as_graph_diagram.active_record' do |_app|
      ActiveSupport.on_load :active_record do
        include ActsAsGraphDiagram::Node
      end
    end
  end
end
