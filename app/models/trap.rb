class Trap < ApplicationRecord
  TYPES_OF_SYSTEM = ['mechanical', 'magical']
  paginates_per 20

  validates :name, :challenge_rating, :experience, :type_of_system, :reset, :trigger, :perception,
            :disable_devise, :effect, :presence => true

  validates :type_of_system, :inclusion => TYPES_OF_SYSTEM

  validates :challenge_rating, :experience, :numericality => { :greater_than => 0 }

end
