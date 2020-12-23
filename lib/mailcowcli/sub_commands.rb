module Mailcowcli
  class SubCommands < Thor
    no_commands do
      def api_base_path
        "/api/v1"
      end

      def run_request api_path:, json:, req_method:, return_response: false
        api_full_path = options["api_server"] + api_base_path + api_path
        resp = Faraday.post(api_full_path, json.to_json, request_headers)

        parsed = JSON.parse(resp.body)
        if parsed && parsed[0]["type"].eql?("success")
          say parsed, :green
        else
          say parsed, :red
        end
      end

      def request_headers
        {
          "Content-Type" => "application/json",
          "X-Api-Key" => options["api_key"]
        }
      end
    end
  end
end