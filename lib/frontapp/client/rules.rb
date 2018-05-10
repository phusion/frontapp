module Frontapp
  class Client
    module Rules

      def rules(params = {})
        list("/rules", params)
      end

      # Parameters
      # Name     Type    Description
      # ----------------------------
      # rule_id  string  Id of the requested rule
      # ----------------------------
      def get_rule(rule_id)
        get("/rules/#{rule_id}")
      end

    end
  end
end
