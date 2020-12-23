require "thor"
require "json"
require "yaml"
require "mailcowcli/version"
require "mailcowcli/sub_commands"
require "mailcowcli/sub_commands/domains"
require "mailcowcli/commands"

module Mailcowcli
  class ErrorRequirement < StandardError
  end
end
