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

  describe ".get_random_traps" do
    let!(:trap1) { create(:trap, :challenge_rating => 1) }
    let!(:trap2) { create(:trap, :challenge_rating => 1) }
    let!(:trap3) { create(:trap, :challenge_rating => 2) }

    it 'should return two trap' do
      expect(Trap.get_random_traps(1, 2).map(&:id)).to include(trap1.id, trap2.id)
    end

    it 'should return only one trap' do
      expect(Trap.get_random_traps(1, 1).size).to eq(1)
    end

    it 'should return only traps with current challenge rating' do
      expect(Trap.get_random_traps(1, 2).map(&:challenge_rating)).to eq([1,1])
    end
  end
end
