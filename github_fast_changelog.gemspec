
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "github_fast_changelog/version"

Gem::Specification.new do |spec|
  spec.name          = "github_fast_changelog"
  spec.version       = GithubFastChangelog::VERSION
  spec.authors       = ["John Hawthorn"]
  spec.email         = ["john@hawthorn.email"]

  spec.summary       = %q{Generates a CHANGELOG based on GitHub PRs}
  spec.description   = %q{Uses GitHub's v4 GraphQL API to generate a CHANGELOG from PRs matching a list of commits}
  spec.homepage      = "https://github.com/jhawthorn/github_fast_changelog"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "graphql", "~> 1.6"
  spec.add_dependency "graphql-client"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
