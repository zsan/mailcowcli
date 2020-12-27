require 'byebug'
module Mailcowcli
  class SubCommands < Thor
    no_commands do
      def api_base_path
        "/api/v1"
      end

      def run_request api_path:, json:, req_method:, return_response: false
        api_full_path = options["api_server"] + api_base_path + api_path

        if req_method.eql? "get"
          resp = Faraday.get(api_full_path, {}, request_headers)
        elsif req_method.eql? "post"
          resp = Faraday.post(api_full_path, json.to_json, request_headers)
        else
          raise "unknown req method"
        end

        parsed = nil

        if resp.success?
          parsed = JSON.parse(resp.body)

          if self.current_command_chain.last.to_s =~ /\A(show|index)\z/
            say resp.body, :green
          elsif
            if parsed && parsed[0]["type"].eql?("success")
              say resp.body, :green
            else
              say resp.body, :red
            end
          end
        else
          say resp.body, :red
        end

        parsed
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