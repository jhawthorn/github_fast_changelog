require 'graphql/client'
require 'graphql/client/http'

require "github_fast_changelog/version"

module GithubFastChangelog
  HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
    def headers(context)
      if token = ENV['GITHUB_ACCESS_TOKEN']
        { "Authorization" => "Bearer #{token}" }
      else
        fail "Missing ENV GITHUB_ACCESS_TOKEN"
      end
    end
  end
  Schema = GraphQL::Client.load_schema(HTTP)
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

  MergedPullsQuery = Client.parse <<-GRAPHQL
    query($before: String, $owner: String!, $name: String!) {
      repository(owner: $owner, name: $name) {
        name
        pullRequests(last:100, before: $before, states:MERGED) {
          pageInfo {
            endCursor
            hasNextPage
            hasPreviousPage
            startCursor
          }
          edges {
            node {
              id
              number
              title
              url
              author {
                login
                url
              }
              mergedAt
              mergeCommit {
                oid
              }
            }
          }
        }
      }
    }
  GRAPHQL

  def self.each_pull_request(owner:, name:)
    cursor = nil
    loop do
      result = Client.query(MergedPullsQuery, variables: {
        before: cursor,
        owner: owner,
        name: name
      })
      data = result.data.repository.pull_requests
      more = data.page_info.has_previous_page
      cursor = data.page_info.start_cursor

      data.edges.reverse.map do |edge|
        yield edge.node
      end

      break unless more
    end
  end
end
