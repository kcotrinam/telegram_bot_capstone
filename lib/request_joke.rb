require 'json'
require 'rest-client'

class JokeRequest
  def initialize
    @url_cat = 'https://api.chucknorris.io/jokes/categories'
    @url_random = 'https://api.chucknorris.io/jokes/random'
    @categories = []
    @joke = ''
  end

  def category_list
    RestClient.get(@url_cat) do |response|
      if response.code == 200
        @categories = JSON.parse response.to_str
      else
        puts 'no connection'
      end
    end
    @categories
  end

  def joke(category)
    RestClient.get("https://api.chucknorris.io/jokes/random?category=#{category}") do |response, result|
      if response.code == 200
        result = JSON.parse response.to_str
        @joke = result['value']
      else
        puts 'no connection'
      end
    end
  end

  def random_joke
    RestClient.get(@url_random) do |response, result|
      if response.code == 200
        result = JSON.parse response.to_str
        @joke = result['value']
      else
        puts 'no connection'
      end
    end
  end
end
