module Mailcowcli
  class SubCommands < Thor
    no_commands do
      def run_request options:, api_path:, json:, req_method:, return_response: false
        pp options
      end
    end
  end
end