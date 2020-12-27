class Mailcowcli::SubCommands::Aliases < Mailcowcli::SubCommands
  desc "create", "create alias"
  option :address, type: "string", required: true, desc: "Alias address"
  option :goto, type: "string", required: true, desc: "Destination address, comma separated"
  option :goto_null, type: "numeric", required: false, default: 0, desc: "Silently ignore"
  option :goto_spam, type: "numeric", required: false, default: 0, desc: "Learn as spam"
  option :goto_ham, type: "numeric", required: false, default: 0, desc: "Learn as ham"
  option :active, type: "numeric", required: false, default: 1, desc: "Alias active or not"

  def create
    json = {
      "address" => options["address"],
      "goto" => options["goto"],
      "goto_null" => options["goto_null"],
      "goto_spam" => options["goto_spam"],
      "goto_ham" => options["goto_ham"],
      "active" => options["active"]
    }

    run_request(api_path: "/add/alias", json: json, req_method: "post")
  end

  desc "delete", "delete aliases"
  option :ids, type: :array, required: true, desc: "List of alias IDs you want to delete"
  def delete
    json = options["ids"]
    run_request(api_path: "/delete/alias", json: json, req_method: "post")
  end

  desc "index", "list all aliases"
  def index
    run_request(api_path: "/get/alias/all", json: {}, req_method: "get")
  end

  desc "show", "show alias detailed information"
  option :id, type: :numeric, required: true, desc: "Alias ID"
  def show
    id = options["id"]
    run_request(api_path: "/get/alias/#{id}", json: {}, req_method: "get")
  end

  desc "update", "update aliases"
  option :ids, type: "array", required: true, desc: "Alias IDs number"
  option :attr, type: "hash", required: true,
    desc: "Valid keys (goto, goto_null, goto_spam, goto_ham, active)"
  def update
    json = {
      "items" => options["ids"],
      "attr" => options["attr"]
    }
    run_request(api_path: "/edit/alias", json: json, req_method: "post")
  end
end
