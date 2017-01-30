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
    trap_response = TrapHandler.new(message).perform
    respond_with :message, text: trap_response
  end

  def start(ta = nil, *)
    # do_smth_with(data)

    # There are `chat` & `from` shortcut methods.
    # For callback queries `chat` if taken from `message` when it's available.
    response = from ? "Hello #{from['username']}!" : 'Hi there!'
    # There is `respond_with` helper to set `chat_id` from received message:
    respond_with :message, text: response
    # `reply_with` also sets `reply_to_message_id`:
  end
end
