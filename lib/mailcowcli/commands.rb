module Mailcowcli
  class Commands < Thor
    class_option :api_key, type: :string, desc: "Api's key, read and write"
    class_option :api_server, type: :string, desc: "Api's server and port, usually http://127.0.0.1:8080"
    class_option :private_key, type: :string, desc: "Private key that used to deploy mailcow"
    class_option :mailcow_domain, type: :string, desc: "Mailcow's domain, eg: https://rsync.radithya.net"
    class_option :user, type: :string, desc: "User that used to deploy mailcow, ubuntu or deployer"
    class_option :dry_run, type: :boolean, default: false,  desc: "Print the ansible command without running any real request"
    class_option :config, type: :string, default: "#{ENV["HOME"]}/.mailcow_cli/config.yaml",  desc: "configuration file"

    desc "domains", "Domain operations"
    subcommand "domains", SubCommands::Domains

    def self.exit_on_failure?
      # do nothing
      # https://github.com/erikhuda/thor/issues/244
    end

    private

    def options

    end
  end
end