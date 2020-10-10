# rubocop: disable Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/AbcSize,Layout/LineLength

require 'telegram/bot'
require_relative '../lib/request_joke.rb'

class Bot
  attr_reader :token
  attr_reader :category

  def initialize
    @token = '1152730733:AAEr8ZjNR6PNWum0jXRetvdDQxWk5JsOsLQ'
    @category = JokeRequest.new
    begin
      start_bot
    rescue Telegram::Bot::Exceptions::ResponseError => e
      puts "Bot not connecting properly. Presenting: #{e}"
    end
  end

  private

  def start_bot
    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          @category.random_joke
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, Welcome to chuckjoke. This bot will show you a Chuck Norris joke based on the category you choose. Use /start to start the bot, /stop to stop the bot, You can choose beetwing these categories: /dev, /history, /political, /celebrity, /animal, /science /random")
        when '/dev'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('dev'), date: message.date)
        when '/history'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('history'), date: message.date)
        when '/political'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('political'), date: message.date)
        when '/celebrity'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('celebrity'), date: message.date)
        when '/animal'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('animal'), date: message.date)
        when '/science'
          bot.api.send_message(chat_id: message.chat.id, text: @category.joke('science'), date: message.date)
        when '/random'
          bot.api.send_message(chat_id: message.chat.id, text: @category.random_joke.to_s, date: message.date)
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        else
          bot.api.send_message(chat_id: message.chat.id, text: "Wrong entry, #{message.from.first_name}, please choose one of these options:/start, /dev, /history, /political, /celebrity, /animal, /science, /random, /stop")
        end
      end
    end
  end
end

# rubocop: enable Metrics/MethodLength,Metrics/CyclomaticComplexity,Metrics/AbcSize,Layout/LineLength
