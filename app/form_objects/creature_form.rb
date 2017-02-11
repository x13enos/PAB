class CreatureForm < Reform::Form
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

  validates :name, :challenge_rating, :experience, :alignment, :init, :perception, :type_name, :presence => true
  validates :challenge_rating, :experience, :numericality => { :greater_than => 0 }

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
