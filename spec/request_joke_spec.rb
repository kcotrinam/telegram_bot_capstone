require_relative '../lib/request_joke'

describe JokeRequest do
  let(:new_joke) { JokeRequest.new }
  context '#joke' do
    it 'When joke method is called, returns a String' do
      expect(new_joke.joke('dev')).to be_a String
    end
  end

  context '#random_joke' do
    it 'When random_joke method is called, It returns a string' do
      expect(new_joke.random_joke).to be_a String
    end
  end
end
