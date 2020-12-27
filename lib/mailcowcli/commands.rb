module Mailcowcli
  class Commands < Thor
    class_option :api_key, type: :string, desc: "Api's key, read and write"
    class_option :api_server, type: :string, desc: "Api's server/domain"
    class_option :dry_run, type: :boolean, default: false,  desc: "Without running any real request"
    class_option :config, type: :string, default: "#{ENV["HOME"]}/.mailcowcli/config.yaml",  desc: "configuration file"

    desc "aliases", "Alias operations"
    subcommand "aliases", SubCommands::Aliases

    desc "domains", "Domain operations"
    subcommand "domains", SubCommands::Domains

    desc "mailboxes", "Mailbox operations"
    subcommand "mailboxes", SubCommands::Mailboxes

    def self.exit_on_failure?
      # do nothing
      # https://github.com/erikhuda/thor/issues/244
    end

    private

    def options
      original_options = super
      filename = original_options["config"]

      merged = {}

      if filename && File.exist?(filename)
        defaults = ::YAML.load_file(filename) || {}
        # alternatively, set original_options[:langs] and then return it
        merged = defaults.merge(original_options)
      else
        merged = original_options
      end

      ["api_key", "api_server"].each do |opt|
        unless merged[opt]
          raise ErrorRequirement, "missing --#{opt}"
        end
      end

      merged
    end
  end
end