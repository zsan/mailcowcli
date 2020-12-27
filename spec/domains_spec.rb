RSpec.describe Mailcowcli::SubCommands::Domains, :vcr do
  let(:options) {
    {
      "config" => "/fake/file",
      "api_key" => "foobarbaz",
      "api_server" => "https://rsync.example.com"
    }
  }

  before do
    @mailcow = Mailcowcli::Commands.new
    @mailcow.options = options
  end

  it "creates domain" do
    captured = @mailcow.domains(:create, "--domain", "example.com")
    expect(captured[0]["type"]).to eq("success")
    expect(captured[1]["msg"][0]).to eq("domain_added")
    expect(captured[1]["msg"][1]).to eq("example.com")
  end

  it "shows domain" do
    captured = @mailcow.domains(:show, "--domain", "example.com")
    expect(captured["domain_name"]).to eq "example.com"
  end

  it "updates domain" do
    captured = @mailcow.domains(:update, "--domain", "example.com",
      "--attr", "description:my new description", "quota:13000")
    expect(captured[0]["type"]).to eq("success")
    expect(captured[0]["msg"][1]).to eq("example.com")
    expect(captured[0]["msg"][0]).to eq("domain_modified")
  end

  it "deletes domain" do
    captured = @mailcow.domains(:delete, "--items", "example.com")
    expect(captured[0]["type"]).to eq("success")
    expect(captured[0]["msg"][1]).to eq("example.com")
    expect(captured[0]["msg"][0]).to eq("domain_removed")
  end

  it "indexes domains" do
    captured = @mailcow.domains(:index)
    expect(captured.length).to eq 2
  end
end
