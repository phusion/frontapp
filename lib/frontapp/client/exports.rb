module Frontapp
  class Client
    module Exports

      def exports(params = {})
        list("exports", params)
      end

      # Parameters
      # Name       Type    Description
      # ------------------------------
      # export_id  string  ID of the requested export
      # ------------------------------
      def get_export(export_id)
        get("exports/#{export_id}")
      end

      # Allowed attributes:
      # Name                  Type    Description
      # -------------------------
      # inbox_id              string (optional)   ID of the inbox to export the analytics for. If omitted, the export will contain all the inboxes.
      # tag_id                string (optional)   ID the tag to export the analytics for. If omitted, the export will contain all the tags.
      # start                 number              Start time of the data to include in the export.
      # end                   number              End time of the data to include in the export.
      # timezone              string (optional)   Name of the timezone to format the dates. If omitted, the export will use UTC.
      # should_export_events  boolean (optional)  Whether to export all the events or only messages. Default to false.
      # -------------------------
      def create_export!(params = {})
        cleaned = params.permit(:inbox_id,
                                :tag_id,
                                :start,
                                :end,
                                :timezone,
                                :should_export_events)
        create("exports", cleaned)
      end

      # Allowed attributes:
      # Name                  Type    Description
      # -------------------------
      # inbox_id              string (optional)   ID of the inbox to export the analytics for. If omitted, the export will contain all the inboxes.
      # tag_id                string (optional)   ID the tag to export the analytics for. If omitted, the export will contain all the tags.
      # start                 number              Start time of the data to include in the export.
      # end                   number              End time of the data to include in the export.
      # timezone              string (optional)   Name of the timezone to format the dates. If omitted, the export will use UTC.
      # should_export_events  boolean (optional)  Whether to export all the events or only messages. Default to false.
      # -------------------------
      def create_export_for_team!(team_id, params = {})
        cleaned = params.permit(:inbox_id,
                                :tag_id,
                                :start,
                                :end,
                                :timezone,
                                :should_export_events)
        create("teams/#{team_id}/exports", cleaned)
      end

    end
  end
end