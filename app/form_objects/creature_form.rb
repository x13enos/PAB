class CreatureForm < Reform::Form
  # Main params
  property :name
  property :challenge_rating
  property :experience
  property :alignment
  property :init
  property :perception
  property :type_name
  property :class_name
  property :size
  property :reach
  property :sense
  property :subtypes
  property :race
  # Defence params
  property :armor_class
  property :armor_class_touch
  property :armor_class_flat_footed
  property :armor_class_description
  property :hit_points
  property :hit_dice
  property :regeneration
  property :fortitude
  property :reflex
  property :will
  property :defensive_abilities
  property :damage_reduction
  property :immune
  property :resist
  property :spell_resistance

  validates_uniqueness_of :name, case_sensitive: false
  validates :name, :challenge_rating, :experience, :alignment, :init, :perception, :type_name,
            :armor_class, :armor_class_touch, :armor_class_flat_footed, :hit_points,
            :hit_dice, :fortitude, :reflex, :will, :presence => true
  validates :challenge_rating, :experience, :hit_points, :armor_class, :numericality => { :greater_than => 0 }

  def initialize(object)
    super
    build_subtype
  end

  def manually_save # The method for saving creature via admin interface
    remove_blank_subtypes
    save
  end

  def build_subtype # Adding new subtype
    last_subtype = subtypes.last
    subtypes << "" if last_subtype.nil? || !last_subtype.empty?
  end

  private

  def remove_blank_subtypes
    subtypes.reject!(&:blank?)
  end
end
