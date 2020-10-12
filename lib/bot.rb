require 'telegram/bot'
require_relative '../lib/request_joke.rb'
require 'dotenv/load'

class Bot
  attr_reader :token
  attr_reader :category

  def initialize
    @token = ENV['TELEGRAM_API_KEY']
    @category = JokeRequest.new
    begin
      print 'Ready! Go and have fun...'
      start_bot
    rescue Telegram::Bot::Exceptions::ResponseError => e
      puts "Bot not connecting properly. Presenting: #{e}"
    end
  end

  def instruction
    'Use /start to start the bot, /stop to stop the bot, You can choose beetwing these categories: /dev /science /random'
  end

  private

  def start_bot
    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          @category.random_joke
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, Welcome to chuckjoke. #{instruction}")
        when '/dev'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('dev'), date: message.date)
        when '/science'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('science'), date: message.date)
        when '/random'
          bot.api.send_message(chat_id: message.chat.id, text: @category.random_joke.to_s, date: message.date)
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        else
          bot.api.send_message(chat_id: message.chat.id, text: "Wrong entry, #{message.from.first_name}, please, #{instruction}")
        end
      end
    end
  end
end
