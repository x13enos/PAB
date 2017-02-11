require 'rails_helper'

RSpec.describe Creature, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:challenge_rating) }
  it { should validate_presence_of(:experience) }
  it { should validate_presence_of(:alignment) }
  it { should validate_presence_of(:type_name) }
  it { should validate_presence_of(:init) }
  it { should validate_presence_of(:perception) }

  it { should validate_numericality_of(:challenge_rating).is_greater_than(0)  }
  it { should validate_numericality_of(:experience).is_greater_than(0)  }

  describe "#remove_blank_subtypes" do
    let(:creature) { build(:creature) }

    it 'should remove all blank subtypes' do
      creature.subtypes = ['first', '', 'third']
      creature.save!
      expect(creature.reload.subtypes).to eq(['first', 'third'])
    end
  end
end
