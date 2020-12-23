require_relative 'lib/mailcowcli/version'

Gem::Specification.new do |spec|
  spec.name          = "mailcowcli"
  spec.version       = Mailcowcli::VERSION
  spec.authors       = ["zsan"]
  spec.email         = ["zaksantanu@gmail.com"]

  spec.summary       = %q{mailcow cli - commands }
  spec.description   = %q{mailcow cli - commands - using API requests}
  spec.homepage      = "https://github.com/zsan/mailcowcli.git"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/zsan/mailcowcli"
  spec.metadata["changelog_uri"] = "https://github.com/zsan/mailcowcli/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_development_dependency "rspec", "~> 3.10.0"
  spec.add_development_dependency "thor", "~> 1.0.1"
  spec.add_development_dependency "faraday", "~> 1.2.0"
end
