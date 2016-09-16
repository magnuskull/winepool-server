RSpec.describe Share do
  describe "attributes" do
    it { is_expected.to have_attribute :amount }
  end

  describe "relationships" do
    it { is_expected.to belong_to :wine }
    it { is_expected.to belong_to :user }
  end

  describe "validations" do
    it { should validate_numericality_of(:amount) }
  end
end
