# rubocop: disable Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/AbcSize,Layout/LineLength

require 'telegram/bot'
require_relative '../lib/request_joke.rb'
require 'dotenv/load'

class Bot
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

  private

  def instruction
    'Use /start , /stop, You can choose beetwing these categories: /dev /science /random /money /celebrity /explicit /sport'
  end

  def start_bot
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          @category.random_joke
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, #{instruction}")
        when '/dev'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('dev'), date: message.date)
        when '/science'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('science'), date: message.date)
        when '/money'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('money'), date: message.date)
        when '/celebrity'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('celebrity'), date: message.date)
        when '/explicit'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('explicit'), date: message.date)
        when '/sport'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('sport'), date: message.date)
        when '/random'
          bot.api.send_message(chat_id: message.chat.id, text: @category.random_joke.to_s, date: message.date)
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        else
          bot.api.send_message(chat_id: message.chat.id, text: "Wrong! #{message.from.first_name}, #{instruction}")
        end
      end
    end
  end
end

# rubocop: enable Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/AbcSize,Layout/LineLength
