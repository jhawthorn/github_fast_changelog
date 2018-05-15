# GithubFastChangelog

Uses GitHub's v4 GraphQL API to generate a CHANGELOG from PRs matching a list of commits.

I used to use [GitHub Changelog
Generator](https://github.com/github-changelog-generator/github-changelog-generator)
(which is a better and way more complete project), but the project I worked on
was too large (several thousand PRs) and always hit github's rate limit.

This project uses GitHub's v4 GraphQL API to query the PRs very efficiently and shouldn't ever hit the rate limit

## Installation

    $ gem install github_fast_changelog

## Usage

This expects a list of commits (some of which should match the merge commit of a PR) on STDIN. Writes markdown to STDOUT.

    $ export GITHUB_ACCESS_TOKEN=....
    $ git rev-list v2.4...v2.5 | github_fast_changelog example/github_repo > CHANGELOG.md


Output is:

```
- Add usage instructions to README [#1](https://github.com/jhawthorn/github_fast_changelog/pull/1) ([jhawthorn](https://github.com/jhawthorn))
```

Rendered:

- Add usage instructions to README [#1](https://github.com/jhawthorn/github_fast_changelog/pull/1) ([jhawthorn](https://github.com/jhawthorn))


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jhawthorn/github_fast_changelog. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GithubFastChangelog project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jhawthorn/github_fast_changelog/blob/master/CODE_OF_CONDUCT.md).
