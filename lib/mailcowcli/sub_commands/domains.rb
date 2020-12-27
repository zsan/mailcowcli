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

    run_request(api_path: "/add/domain", json: json, req_method: "post")
  end

  desc "delete", "delete single or multiple domain(s)"
  option :items, type: :array, required: true, desc: "List of domains you want to delete"
  def delete
    json = options["items"]
    run_request(api_path: "/delete/domain", json: json, req_method: "post")
  end

  desc "index", "list all domains"
  def index
    run_request(api_path: "/get/domain/all", json: {}, req_method: "get")
  end

  desc "show", "show domain detailed information"
  option :domain, type: :string, required: true, desc: "Domain name"
  def show
    domain_name = options["domain"]
    run_request(api_path: "/get/domain/#{domain_name}", json: {}, req_method: "get")
  end

  desc "update", "update domain"
  option :domain, type: "array", required: true, desc: "fully qualified domain name"
  option :attr, type: "hash", required: true, desc: <<-ATTR
Valid keys (description, aliases, mailboxes, defquota, maxquota, quota, active, gal,
relayhost, backupmx, relay_all_recipients, lang)
ATTR
  def update
    json = {
      "items" => options["domain"],
      "attr" => options["attr"]
    }

    run_request(api_path: "/edit/domain", json: json, req_method: "post")
  end
end