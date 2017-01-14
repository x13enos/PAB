describe User do
  describe "#set_default_role" do
    let(:admin) { build(:user, :role => :admin) }
    let(:user) { build(:user) }

    it 'should return existing role' do
      expect(admin.role).to eq("admin")
    end

    it 'should return set user role' do
      expect(user.role).to eq("user")
    end
  end
end
