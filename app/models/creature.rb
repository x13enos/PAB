class Creature < ApplicationRecord
  paginates_per 20

  before_save :remove_blank_subtypes

  validates :name, :challenge_rating, :experience, :alignment, :init, :perception, :type_name, :presence => true
  validates :challenge_rating, :experience, :numericality => { :greater_than => 0 }

  def remove_blank_subtypes
    subtypes.reject!(&:blank?)
  end
end
