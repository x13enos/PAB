class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def message(message)
    message == self.payload # true
    respond_with :message, text: "Choose your option", reply_markup: {
        keyboard: [["One", "Two"]],
        resize_keyboard: true,
        one_time_keyboard: true,
        selective: true,
      }
    # store_message(message['text'])
  end

  def traps(message=nil)
    set_locale(:ru)
    trap_response = TrapHandler.new(message).perform
    respond_with :message, text: trap_response
  end

  def start(ta = nil, *)
    response = from ? "Hello #{from['username']}!" : 'Hi there!'
    respond_with :message, text: response
  end

  private

  def set_locale(locale)
    I18n.locale = locale
  end
end
