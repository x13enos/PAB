require 'rails_helper'

RSpec.describe CreatureForm do

  context "Validations" do
    context "presence" do
      let(:creature) do
        build(:creature, { :name => nil,
          :challenge_rating => nil,
          :experience => nil,
          :alignment => nil,
          :type_name => nil,
          :init => nil,
          :perception => nil
        })
      end
      let(:form) { CreatureForm.new(creature) }

      before do
        form.valid?
      end

      it 'should validate name' do
        expect(form.errors[:name]).to eq(["can't be blank"])
      end

      it 'should validate challenge_rating' do
        expect(form.errors[:challenge_rating]).to include("can't be blank")
      end

      it 'should validate experience' do
        expect(form.errors[:experience]).to include("can't be blank")
      end

      it 'should validate alignment' do
        expect(form.errors[:alignment]).to eq(["can't be blank"])
      end

      it 'should validate type_name' do
        expect(form.errors[:type_name]).to eq(["can't be blank"])
      end

      it 'should validate init' do
        expect(form.errors[:init]).to eq(["can't be blank"])
      end

      it 'should validate perception' do
        expect(form.errors[:perception]).to eq(["can't be blank"])
      end
    end

    context "validate_numericality_of" do
      let(:creature) do
        build(:creature, {
          :challenge_rating => -1,
          :experience => -1,
        })
      end
      let(:form) { CreatureForm.new(creature) }

      before do
        form.valid?
      end

      it 'should validate challenge_rating' do
        expect(form.errors[:challenge_rating]).to eq(["must be greater than 0"])
      end

      it 'should validate experience' do
        expect(form.errors[:experience]).to eq(["must be greater than 0"])
      end
    end

    context "uniqueness" do
      let(:creature) do
        build(:creature, {
          :challenge_rating => -1,
          :experience => -1,
          :name => "gnoll"
        })
      end
      let(:form) { CreatureForm.new(creature) }

      before do
        create(:creature, :name => 'gnoll')
        form.valid?
      end

      it 'should validate name' do
        expect(form.errors[:name]).to eq(["has already been taken"])
      end
    end
  end

  describe ".initialize" do
    let(:creature) { build(:creature) }

    it 'should build subtype for form' do
      expect_any_instance_of(CreatureForm).to receive(:build_subtype)
      CreatureForm.new(creature)
    end
  end

  describe "#manually_save" do
    let(:creature) { build(:creature, :subtypes => ['', 'first', '', 'second']) }
    let(:form) { CreatureForm.new(creature) }

    it 'should remove blank subtypes' do
      form.manually_save
      expect(form.subtypes).to eq(['first', 'second'])
    end

    it 'should save attributes' do
      expect(form).to receive(:save)
      form.manually_save
    end
  end

  describe "#build_subtype" do
    let(:form) { CreatureForm.new(build(:creature)) }

    it 'should add the blank subtype' do
      form.subtypes = ['first']
      form.build_subtype
      expect(form.subtypes).to eq(['first', ''])
    end

    it 'should not add the blank subtype' do
      form.subtypes = ['first', '', '']
      form.build_subtype
      expect(form.subtypes).to eq(['first', '', ''])
    end
  end
end
