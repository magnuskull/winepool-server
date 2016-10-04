RSpec.describe Share do
  describe "attributes" do
    it { is_expected.to have_attribute :amount }
  end

  describe "relationships" do
    it { is_expected.to belong_to :wine }

    it { is_expected.to belong_to :user }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :wine}

    it { is_expected.to validate_presence_of :user}

    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(1) }

    it "should validate amount not exceeding available bottles" do
      first_share = FactoryGirl.create(:share)
      subject = FactoryGirl.build(:share, wine: first_share.wine, amount: 10)
      subject.valid?
      expect(subject.errors[:amount]).to include "not enough bottles available"
    end
  end
end
