class CreatureHandler
  attr_accessor :message

  def initialize(message)
    self.message = message
  end

  def perform
    if message
      try_to_find_creature
    else
      return_info_about_creatures
    end
  end

  private

  def try_to_find_creature
    creature = Creature.active.find_by(:name => message)
    if creature
      return_main_info(creature)
    else
      return_error_and_ask_use_name_of_creature
    end
  end

  def return_main_info(creature)
    attributes = prepare_creature_attributes_for_locale(creature)
    build_creature_response(attributes)
  end


  def prepare_creature_attributes_for_locale(c)
    {
      :name => c.name,
      :challenge_rating => get_challenge_rating(c.challenge_rating),
      :experience => c.experience,
      :race => c.race,
      :class => c.class_name,
      :alignment => c.alignment,
      :size  => get_size_name(c.size),
      :type => c.type_name,
      :subtypes => c.subtypes.join(', '),
      :init => c.init,
      :sense => c.sense,
      :perception => c.perception
    }
  end

  def get_challenge_rating(c)
    c >= 1 ? c.to_i : c
  end

  def get_size_name(size)
    size_name = Creature::SIZE_TABLE.key(size).downcase
    I18n.t("app.creatures.sizes.#{size_name}")
  end

  def build_creature_response(a)
    r = ""
    r << I18n.t('bot.creatures.response.main_section.name_challenge_rating_xp', a)
    r << I18n.t('bot.creatures.response.main_section.class', a) if a[:class].present?
    r << I18n.t('bot.creatures.response.main_section.race', a) if a[:race].present?
    r << I18n.t('bot.creatures.response.main_section.alignment_size', a)
    if a[:subtypes].present?
      r << I18n.t('bot.creatures.response.main_section.type_subtypes', a)
    else
      r << I18n.t('bot.creatures.response.main_section.type', a)
    end
    r << I18n.t('bot.creatures.response.main_section.init_perception_sense', a)
    r
  end

  def return_info_about_creatures
    I18n.t("bot.creatures.info")
  end

  def return_error_and_ask_use_name_of_creature
    I18n.t("bot.creatures.please_use_correct_name")
  end
end
