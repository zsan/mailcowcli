class Mailcowcli::SubCommands::Mailboxes < Mailcowcli::SubCommands
  desc "create", "create mailbox"

  option :local_part, type: "string", required: true, desc: "Left part of email address"
  option :domain, type: "string", required: true, desc: "Domain name"
  option :name, type: "string", required: true, desc: "Full name of the mailbox user"
  option :quota, type: "numeric", required: false, default: 3072, desc: "Mailbox quota"
  option :password, type: "string", required: true, desc: "Mailbox password"
  # option :password_confirm, type: "string",  required: true, desc: "Mailbox password for confirmation"
  option :active, type: "numeric", required: false, default: 1, desc: "Is mailbox active or not"
  option :force_pw_update, type: "numeric", required: false, default: 1, desc: "Forces the user to update its password on first login"
  option :tls_enforce_in, type: "numeric", required: false, default: 1, desc: "Force inbound email tls encryption"
  option :tls_enforce_out, type: "numeric", required: false, default: 1, desc: "Force outbound email tls encryption"

  def create
    json = {
      "local_part" => options["local_part"],
      "domain" => options["domain"],
      "name" => options["name"],
      "quota" => options["quota"],
      "password" => options["password"],
      "password2" => options["password"],
      "active" => options["active"],
      "force_pw_update" => options["force_pw_update"],
      "tls_enforce_in" => options["tls_enforce_in"],
      "tls_enforce_out" => options["tls_enforce_out"]
    }

    run_request(api_path: "/add/mailbox", json: json, req_method: "post")
  end

  desc "delete", "delete mailboxes"
  option :addresses, type: :array, required: true, desc: "List of mailbox addresses you want to delete"
  def delete
    json = options["addresses"]
    run_request(api_path: "/delete/mailbox", json: json, req_method: "post")
  end

  desc "index", "list all mailboxes"
  def index
    run_request(api_path: "/get/mailbox/all", json: {}, req_method: "get")
  end

  desc "show", "show mailbox detailed information"
  option :address, type: "string", required: true, desc: "mailbox ID"
  def show
    address = options["address"]
    run_request(api_path: "/get/mailbox/#{address}", json: {}, req_method: "get")
  end

  desc "update", "update mailboxes"
  option :addresses, type: "array", required: true, desc: "mailbox addresses"
  option :attr, type: "hash", required: true, desc: <<-ATTR
  Valid keys (name, quota, password, password2, active, sender_acl:[], force_pw_update, sogo_access)
  ATTR

  def update
    json = {
      "items" => options["addresses"],
      "attr" => options["attr"]
    }
    run_request(api_path: "/edit/mailbox", json: json, req_method: "post")
  end
end