module Sinatra
  module Slack
    module Helpers
      class ActionRequest
        attr_reader :name, :value

        def initialize(name, value, body = nil)
          @name = name
          @value = value
        end

        def self.parse(params)
          payload = JSON.parse params["payload"]

          return unless payload["type"] == "interactive_message"

          action = payload["actions"].first
          value = action["value"] if action.has_key?("value")
          value = action["selected_options"].first["value"] if action.has_key?("selected_options")
          name = payload["callback_id"]

          self.new(name, value)
        end
      end
    end
  end
end