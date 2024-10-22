module Frontapp
  class Client
    module Teams

      def teams(params = {}, &)
        list("teams", params, &)
      end

      # Parameters
      # Name     Type    Description
      # --------------------------------
      # team_id  string  Id of the requested team
      # --------------------------------
      def get_team(team_id)
        get("teams/#{team_id}")
      end
    end
  end
end