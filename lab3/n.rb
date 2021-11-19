require 'rubygems'
require 'telegram/bot'

token = '2138176999:AAEmcWQAlRSvypGTTobKF4fCspHnV3uQ5gE'

Telegram::Bot::Client.run(token) do |bot|
bot.listen do |message|
  case message
  when Telegram::Bot::Types::CallbackQuery
    # Here you can handle your callbacks from inline buttons
    if message.data == 'touch'
      bot.api.send_message(chat_id: message.from.id, text: "Don't touch me!")
	elsif message.data == 'game'
      bot.api.send_message(chat_id: message.from.id, text: "I knew you're cool!")
	  kb1 = [
		Telegram::Bot::Types::KeyboardButton.new(text: 'Give me your phone number', request_contact: true),
		Telegram::Bot::Types::KeyboardButton.new(text: 'Show me your location', request_location: true)
      ]
    markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb1)
	bot.api.send_message(chat_id: message.from.id, text: "Now answer the question!", reply_markup: markup)
	Telegram::Bot::Types::KeyboardButton.new(remove_keyboard: true)
    end
  when Telegram::Bot::Types::Message
    kb = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Go to Google', url: 'https://google.com'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Touch me', callback_data: 'touch'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Send info about bot to friend', switch_inline_query: 'Hey! It is a great and interesting bot. Have a look!'),
	  Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Game', callback_data: 'game')
    ]
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
    bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup)
  end
end
end