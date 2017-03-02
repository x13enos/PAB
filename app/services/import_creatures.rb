require 'csv'

class ImportCreatures
  attr_accessor :file

  def initialize
    I18n.locale = :ru
    self.file = File.read("./lib/support/bestiary.csv")
  end

  def parse
    select_data_and_keep
  end

  private

  def csv
    CSV.parse(file, :headers => true)
  end

  def select_data_and_keep
    csv.each_with_index do |row, index|
      if Creature::LIST_OF_CREATURES.include?(row[0].downcase)
        creature_params = build_params_hash(row)
        create_creature(creature_params)
      end
    end
  end

  def create_creature(creature_params)
    form = CreatureForm.new(Creature.new)
    if form.validate(creature_params)
      form.save
    else
      puts form.errors
    end
  end

  def build_params_hash(row)
    {
      :name => get_name(row),
      :challenge_rating => get_challenge_rating(row),
      :experience => calculate_experience(row),
      :alignment => get_alignment(row),
      :type_name => get_type(row),
      :size => Creature::SIZE_TABLE[row[9]],
      :reach => Creature::REACH_TABLE[row[9]],
      :class_name => got_full_name_of_class([row[4..5], row[6..7]]),
      :race => row[3],
      :subtypes => get_all_subtypes(row[11..16]),
      :perception => find_perception(row[36]),
      :init => 1
    }
  end

  def get_name(data)
    I18n.t("app.creatures.names.#{data[0].downcase}")
  end

  def get_challenge_rating(data)
    data[1]
  end

  def calculate_experience(data)
    data[2].remove(',')
  end

  def get_alignment(data)
    I18n.t("app.creatures.names.#{data[8]}")
  end

  def get_type(data)
    I18n.t("app.creatures.types.#{data[10]}")
  end

  def got_full_name_of_class(data)
    data.map{|class_and_lvl| class_and_lvl.join(' ')}.delete_if(&:blank?).join(", ")
  end

  def get_all_subtypes(data)
    data.delete_if(&:blank?).map{|s| I18n.t("app.creatures.subtypes.#{s}")}
  end

  def find_perception(data)
    match = data.match(/(?<=Perception \+)\d+/)
    match ? match.to_s : 0
  end
end
