RSpec.describe Mailcowcli::SubCommands::Domains, :vcr do
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

  it "creates domain" do
    captured =  @mailcow.domains(:create, "--domain", "example.com")
    expect(captured[0]["type"]).eql?("success")
    expect(captured[1]["msg"]).eql?("domain_added")
    expect(captured[1]["msg"][1]).eql?("example.com")
  end
end
