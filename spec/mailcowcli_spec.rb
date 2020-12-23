RSpec.describe Mailcowcli, :vcr do
  let(:options){
    {
      "config"  => "/fake/file",
      "api_key" => "foobarbaz",
      "api_server" => "https://rsync.example.com",
    }
  }

  before do
    @mailcow = Mailcowcli::Commands.new
    @mailcow.options = options
  end

  it "has a version number" do
    expect(Mailcowcli::VERSION).not_to be nil
  end

  it "shows help on create" do
    captured =  @mailcow.domains(:create, "--domain", "example.com")
    expect(captured[0]["type"]).eql?("success")
     #    {"type"=>"success",
     #  "log"=>
     #   ["ratelimit",
     #    "edit",
     #    "domain",
     #    {"rl_value"=>10, "rl_frame"=>"s", "object"=>"example.com"}],
     #  "msg"=>["rl_saved", "example.com"]},
     # {"type"=>"success",
     #  "log"=>
     #   ["mailbox",
     #    "add",
     #    "domain",
     #    {"domain"=>"example.com",
     #     "description"=>"domain name",
     #     "aliases"=>400,
     #     "mailboxes"=>10,
     #     "defquota"=>3072,
     #     "maxquota"=>10240,
     #     "quota"=>10240,
     #     "rl_value"=>10,
     #     "rl_frame"=>"s",
     #     "backupmx"=>0,
     #     "relay_all_recipients"=>0,
     #     "lang"=>"en",
     #     "active"=>1},
     #    nil],
     #  "msg"=>["domain_added", "example.com"]}]

  end
end
