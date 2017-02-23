require 'rails_helper'

RSpec.describe CreatureHandler do
  before do
    I18n.locale = :ru
  end

  describe ".initialize" do
    it 'should assign message to the instance variable' do
      handler = CreatureHandler.new(1)
      expect(handler.message).to eq(1)
    end
  end

  describe ".perform" do
    context "when message is empty" do
      let(:handler) { CreatureHandler.new(nil) }
      let(:creature_response) { double }

      it 'should return info about command' do
        allow(I18n).to receive(:t).with("bot.creatures.info") { creature_response }
        expect(handler.perform).to eq(creature_response)
      end
    end

    context "when message is present" do
      context "when system found the creature with passed name" do
        let(:handler) { CreatureHandler.new('Гоблин') }
        let(:creature_response) { "Example response" }


        context "creature's responses" do
          it "should return creature's info if all attributes passed" do
            create(:creature, :name => "Гоблин", :active => true, :size => 5)
            creature_response = "Гоблин\n\nКС 1,   XP 1\nКласс: name\nРаса: human\nНейтральный злой, Небольшой, Bard(first, second)\nИнициатива: 6; darkvision 60фт.; Внимание: 8"
            expect(handler.perform).to eq(creature_response)
          end

          it "should return creature's info w/o class" do
            create(:creature, :name => "Гоблин", :active => true, :size => 5, :class_name => "")
            creature_response = "Гоблин\n\nКС 1,   XP 1\nРаса: human\nНейтральный злой, Небольшой, Bard(first, second)\nИнициатива: 6; darkvision 60фт.; Внимание: 8"
            expect(handler.perform).to eq(creature_response)
          end

          it "should return creature's info w/o race" do
            create(:creature, :name => "Гоблин", :active => true, :size => 5, :race=> "")
            creature_response = "Гоблин\n\nКС 1,   XP 1\nКласс: name\nНейтральный злой, Небольшой, Bard(first, second)\nИнициатива: 6; darkvision 60фт.; Внимание: 8"
            expect(handler.perform).to eq(creature_response)
          end

          it "should return creature's info w/o subtypes" do
            create(:creature, :name => "Гоблин", :active => true, :size => 5, :subtypes => [])
            creature_response = "Гоблин\n\nКС 1,   XP 1\nКласс: name\nРаса: human\nНейтральный злой, Небольшой, Bard\nИнициатива: 6; darkvision 60фт.; Внимание: 8"
            expect(handler.perform).to eq(creature_response)
          end
        end
      end

      context "when system didn't find the creature" do
        let(:handler) { CreatureHandler.new('Габлин') }
        let(:creature_response) { "error" }

        it 'should return string where system asks to use name of creature' do
          allow(I18n).to receive(:t).with("bot.creatures.please_use_correct_name") { creature_response }
          expect(handler.perform).to eq(creature_response)
        end
      end
    end
  end
end
