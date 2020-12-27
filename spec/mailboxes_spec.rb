RSpec.describe Mailcowcli::SubCommands::Mailboxes, :vcr do
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

  it "creates mailbox" do
    captured = @mailcow.mailboxes(:create,
      "--local-part", "foo", "--domain", "example.com",
      "--name", "foobar",  "--password", "mypassword")
    expect(captured[0]["type"]).to eq("success")
    expect(captured[0]["msg"][0]).to eq("mailbox_added")
    expect(captured[0]["msg"][1]).to eq("foo@example.com")
  end

  it "shows mailbox" do
    captured = @mailcow.mailboxes(:show, "--address", "foo@example.com")
    expect(captured["username"]).to eq "foo@example.com"
    expect(captured["name"]).to eq "foobar"
  end

  it "indexes mailboxes" do
    captured = @mailcow.mailboxes(:index)
    expect(captured.length).to eq 1
  end

  it "updates mailbox" do
    captured = @mailcow.mailboxes(:update, "--addresses", "foo@example.com", "--attr", "name:john")
    expect(captured[0]["type"]).to eq("success")
    expect(captured[0]["msg"][1]).to eq("foo@example.com")
    expect(captured[0]["msg"][0]).to eq("mailbox_modified")
  end

  it "deletes mailbox" do
    captured = @mailcow.mailboxes(:delete, "--addresses", "foo@example.com")
    expect(captured[0]["type"]).to eq("success")
    expect(captured[0]["msg"][1]).to eq("foo@example.com")
    expect(captured[0]["msg"][0]).to eq("mailbox_removed")
  end
end
