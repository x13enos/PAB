require 'rails_helper'

RSpec.describe Creature, type: :model do

  describe ".active" do
    let!(:creature_1) { create(:creature, :active => false)  }
    let!(:creature_2) { create(:creature, :active => true)  }

    it 'should return all active creatures' do
      expect(Creature.active).to eq([creature_2])
    end
  end
end
