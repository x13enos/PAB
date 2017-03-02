class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def message(message)
    message == self.payload # true
    respond_with :message, text: "Choose your option"
    # reply_markup: {
    #     keyboard: [["One", "Two"]],
    #     resize_keyboard: true,
    #     one_time_keyboard: true,
    #     selective: true,
    #   }
    # store_message(message['text'])
  end

  def traps(message=nil)
    set_locale(:ru)
    trap_response = TrapHandler.new(message).perform
    respond_with :message, text: trap_response
  end

  def creatures(message=nil)
    set_locale(:ru)
    creature_response = CreatureHandler.new(message).perform
    respond_with :message, text: creature_response
      # reply_markup: {
        # inline_keyboard: [["Атака/Защита", "Показатели", "Экология"]],
        # inline_keyboard: [
        #   [
        #     {text: 'Creature', :callback_data => 'alert'},
        #     {text: '333333333', :callback_data => 'alert'},
        #   ],
        # ],
      # }

  end

  def start(ta = nil, *)
    response = from ? "Hello #{from['username']}!" : 'Hi there!'
    respond_with :message, text: response
  end

  def callback_query(data)
    if data == 'alert'
      answer_callback_query 'OLOLO', show_alert: true
    else
      answer_callback_query "Not OLOLO"
    end
  end

  private

  def set_locale(locale)
    I18n.locale = locale
  end
end
