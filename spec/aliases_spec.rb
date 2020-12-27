RSpec.describe Mailcowcli::SubCommands::Aliases, :vcr do
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

  it "creates alias" do
    captured = @mailcow.aliases(:create,
      "--address", "foo@example.com", "--goto", "bar@example.com",
    )
    expect(captured[0]["type"]).to eq("success")
    expect(captured[0]["msg"][0]).to eq("alias_added")
    expect(captured[0]["msg"][1]).to eq("foo@example.com")
    # alias id
    expect(captured[0]["msg"][2]).to eq("28")
  end

  it "shows alias" do
    captured = @mailcow.aliases(:show, "--id", 28)
    expect(captured["address"]).to eq "foo@example.com"
    expect(captured["goto"]).to eq "bar@example.com"
  end

  it "indexes aliases" do
    captured = @mailcow.aliases(:index)
    expect(captured.length).to eq 1
  end

  it "updates alias" do
    captured = @mailcow.aliases(:update, "--ids",
      "foo@example.com", "--attr", "goto:baz@example.com")
    expect(captured[0]["type"]).to eq("success")
    expect(captured[0]["msg"][1]).to eq("foo@example.com")
    expect(captured[0]["msg"][0]).to eq("alias_modified")
  end

  it "deletes alias" do
    captured = @mailcow.aliases(:delete, "--ids", "29")
    expect(captured[0]["type"]).to eq("success")
    expect(captured[0]["msg"][1]).to eq("foo@example.com")
    expect(captured[0]["msg"][0]).to eq("alias_removed")
  end
end
