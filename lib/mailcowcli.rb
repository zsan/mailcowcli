require "thor"
require "json"
require "yaml"
require "faraday"
require "mailcowcli/version"
require "mailcowcli/sub_commands"
require "mailcowcli/sub_commands/aliases"
require "mailcowcli/sub_commands/domains"
require "mailcowcli/sub_commands/mailboxes"
require "mailcowcli/commands"

module Mailcowcli
  class ErrorRequirement < StandardError
  end
end
