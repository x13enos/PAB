require 'rails_helper'

RSpec.describe Trap, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:challenge_rating) }
  it { should validate_presence_of(:experience) }
  it { should validate_presence_of(:type_of_system) }
  it { should validate_presence_of(:reset) }
  it { should validate_presence_of(:trigger) }
  it { should validate_presence_of(:perception) }
  it { should validate_presence_of(:disable_devise) }
  it { should validate_presence_of(:effect) }

  it { should validate_inclusion_of(:type_of_system).in_array(Trap::TYPES_OF_SYSTEM) }

  it { should validate_numericality_of(:challenge_rating).is_greater_than(0)  }
  it { should validate_numericality_of(:experience).is_greater_than(0)  }

  describe "constant TYPES_OF_SYSTEM" do
    it 'should return array of types' do
      expect(Trap::TYPES_OF_SYSTEM).to eq(['mechanical', "magical"])
    end
  end
end

