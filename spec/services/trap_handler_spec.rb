require 'rails_helper'

RSpec.describe TrapHandler do

  describe ".initialize" do
    it 'should assign message to the instance variable' do
      handler = TrapHandler.new(1)
      expect(handler.message).to eq(1)
    end
  end

  describe ".perform" do
    context "when message is empty" do
      let(:handler) { TrapHandler.new(nil) }
      let(:trap_response) { double }

      it 'should return info about command' do
        allow(I18n).to receive(:t).with("bot.traps.info") { trap_response }
        expect(handler.perform).to eq(trap_response)
      end
    end

    context "when message is present" do
      context "when message is correct challenge rating" do
        let(:handler) { TrapHandler.new(1) }
        let!(:trap1)    { create(:trap, :name => 'Arrow')  }
        let!(:traps)    { [trap1] }
        let(:trap_response) { "Example response" }
        let(:trap_attributes) do
          {
            :name => trap1.name,
            :challenge_rating => trap1.challenge_rating,
            :experience => trap1.experience,
            :type_of_system => 'magical',
            :reset => trap1.reset,
            :trigger => trap1.trigger,
            :effect => trap1.effect,
            :perception => trap1.perception,
            :disable_devise => trap1.disable_devise
          }
        end


        it 'should return string with trap info' do
          allow(I18n).to receive(:t).with('bot.traps.type_of_system.magical') { 'magical' }
          allow(I18n).to receive(:t).with('bot.traps.random', trap_attributes) { trap_response }
          allow(handler).to receive(:prepare_trap_attributes_for_locale) { [trap_attributes] }
          expect(handler.perform).to eq(trap_response)
        end

        it 'should build array of traps attributes' do
          allow(I18n).to receive(:t).with('bot.traps.type_of_system.magical') { 'magical' }
          allow(I18n).to receive(:t).with('bot.traps.random', trap_attributes) { trap_response }
          allow(Trap).to receive(:get_random_traps) { traps }
          expect(handler.send(:prepare_trap_attributes_for_locale, traps)).to eq([trap_attributes])
        end
      end

      context "when message is incorrect challenge rating" do
        let(:handler) { TrapHandler.new('21') }
        let(:trap_response) { "error" }

        it 'should return string where system asks to use correct number' do
          allow(I18n).to receive(:t).with("bot.traps.please_use_correct_number") { trap_response }
          expect(handler.perform).to eq(trap_response)
        end
      end
    end
  end
end

