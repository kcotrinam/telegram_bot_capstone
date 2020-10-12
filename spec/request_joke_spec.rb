require_relative '../lib/request_joke'

describe JokeRequest do
  let(:new_joke) { JokeRequest.new }
  context '#joke' do
    it 'When joke method is called, returns a String' do
      expect(new_joke.joke('dev')).to be_a String
    end

    it 'When joke method is called, It does not return a Number' do
      expect(new_joke.joke('dev')).not_to be_a Numeric
    end

    it 'When joke method is called, It does not return false' do
      expect(new_joke.joke('dev')).not_to eql(false)
    end
  end

  context '#random_joke' do
    it 'When random_joke method is called, It returns a string' do
      expect(new_joke.random_joke).to be_a String
    end
    it 'When random_joke method is called, It does not return an array' do
      expect(new_joke.random_joke).not_to be_a Array
    end
    it 'When random_joke method is called, It does not return true' do
      expect(new_joke.random_joke).not_to be true
    end
  end
end
