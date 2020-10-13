require 'json'
require 'rest-client'

class JokeRequest
  def initialize
    @url_cat = 'https://api.chucknorris.io/jokes/categories'
    @url_random = 'https://api.chucknorris.io/jokes/random'
    @joke = ''
  end

  def joke(category)
    RestClient.get("#{@url_random}?category=#{category}") do |response, result|
      if response.code == 200
        result = JSON.parse response.to_str
        @joke = result['value']
      end
    end
  end

  def random_joke
    RestClient.get(@url_random) do |response, result|
      if response.code == 200
        result = JSON.parse response.to_str
        @joke = result['value']
      end
    end
  end
end
