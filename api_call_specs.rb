require 'rspec'
require_relative 'api_call'

RSpec.describe ApiRest do
  context '#posts' do
    it 'should return the posts from the api' do
      expect(posts).to_eq 'blabla'
    end
  end
end
