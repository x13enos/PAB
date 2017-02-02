class TrapHandler
  attr_accessor :message

  def initialize(message)
    self.message = message
  end

  def perform
    if message
      try_to_get_random_trap
    else
      return_info_about_traps
    end
  end

  private

  def try_to_get_random_trap
    if message_is_a_level?
      random_traps = find_random_number_of_traps
      attributes = prepare_trap_attributes_for_locale(random_traps)
      build_traps_response(attributes)
    else
      return_error_and_ask_use_level
    end
  end

  def message_is_a_level?
    message.to_i.between?(1, 20)
  end

  def find_random_number_of_traps
    Trap.get_random_traps(message.to_i, 1)
  end

  def prepare_trap_attributes_for_locale(traps)
    traps.map{|t| trap_attribute(t)}
  end

  def trap_attribute(t)
    {
      :name => t.name,
      :challenge_rating => t.challenge_rating,
      :experience => t.experience,
      :type_of_system => I18n.t("bot.traps.type_of_system.#{t.type_of_system}"),
      :reset => t.reset,
      :trigger => t.trigger,
      :effect => t.effect,
      :perception => t.perception,
      :disable_devise => t.disable_devise
    }
  end

  def build_traps_response(array_of_attributes)
    array_of_attributes.each_with_object(''){ |a, string|  string <<  I18n.t('bot.traps.random', a) }
  end

  def return_info_about_traps
    I18n.t("bot.traps.info")
  end

  def return_error_and_ask_use_level
    I18n.t("bot.traps.please_use_correct_number")
  end
end
