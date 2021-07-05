require 'rubygems'
require 'httparty'
require 'json'

# this is a playground, not a real-life app. Dumb comments are here for ME.
class ApiRest
  include HTTParty
  base_uri 'edutechional-resty.herokuapp.com/' # the api we need to call

  def posts
    self.class.get('/posts.json') # part of the url we wanna call
  end

  api_rest = ApiRest.new
  api_rest.posts.each do |post|
    p "Title: #{post['title']}" # we wanna grab the title key from each posts
    p "Description: #{post['description']}"
  end
end
