class Mailcowcli::SubCommands::Domains < Mailcowcli::SubCommands
  desc "create", "create domains"
  option :domain, type: "string", required: true, desc: "fully qualified domain name"
  option :description, type: "string", required: false, default: "domain name", desc: "description"
  option :aliases, type: "numeric", required: false, default: 400, desc: "Max possible aliases"
  option :mailboxes, type: "numeric", required: false, default: 10, desc: "Max. possible mailboxes"
  option :defquota, type: "numeric", required: false, default: 3072, desc: "predefined mailbox quota in add mailbox form"
  option :maxquota, type: "numeric", required: false, default: 10240, desc: "Max. quota per mailbox (MiB)"
  option :quota, type: "numeric", required: false, default: 10240, desc: "Total domain quota"
  option :rl_value, type: "numeric", required: false, default: 10, desc: "number rate limit value"
  option :rl_frame, type: "string", required: false, default: "s", desc: "s (second), m (minute), h (hour) or d (day)"
  option :backupmx, type: "numeric", required: false, default: 0, desc: "relay domain or not"
  option :relay_all_recipients, type: "numeric", required: false, default: 0, desc: "if not, then you have to create 'dummy' mailbox for each address to relay"
  option :lang, type: "string", required: false, default: "en", desc: "language"
  option :active, type: "numeric", required: false, default: 1, desc: "Domain active or not"
  def create
    json = {
      "domain" => options["domain"],
      "description" => options["description"],
      "aliases" => options["aliases"],
      "mailboxes" => options["mailboxes"],
      "defquota" => options["defquota"],
      "maxquota" => options["maxquota"],
      "quota" => options["quota"],
      "rl_value" => options["rl_value"],
      "rl_frame" => options["rl_frame"],
      "backupmx" => options["backupmx"],
      "relay_all_recipients" => options["relay_all_recipients"],
      "lang" => options["lang"],
      "active" => options["active"]
    }

    run_request(options: options, api_path: "/edit/domain", json: json, req_method: "post")
  end
end
