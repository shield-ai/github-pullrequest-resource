require 'octokit'
require_relative '../pull_request'

module Filters
  class All
    def initialize(pull_requests: [], input: Input.instance)
      @input = input
    end

    def pull_requests
      @pull_requests ||= Octokit.pulls(input.source.repo, pull_options).map do |pr|
        PullRequest.new(pr: pr)
      end
    end

    private

    attr_reader :input

    def pull_options
      options = { state: input.source.state,
                  sort: input.source.sort,
                  direction: input.source.direction }
      options[:base] = input.source.base if input.source.base
      options
    end
  end
end
