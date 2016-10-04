RSpec.describe Wine do
  describe "attributes" do
    it { is_expected.to have_attribute :name }
    it { is_expected.to have_attribute :description }
    it { is_expected.to have_attribute :bottles }
    it { is_expected.to have_attribute :price }
  end

  describe "relationships" do
    it { is_expected.to have_many :shares }

    it { is_expected.to have_many(:users).through(:shares) }

    it { is_expected.to belong_to :suggester }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }

    it { should validate_numericality_of(:bottles) }

    it { should validate_numericality_of(:price).allow_nil }

    it { is_expected.to validate_presence_of :suggester }

    it "is fulfilled or not" do
      subject = FactoryGirl.create(:wine, bottles: 6)
      first_share = FactoryGirl.create(:share, wine: subject, amount: 3)
      expect(subject.is_fulfilled?).to be_falsey
      second_share = FactoryGirl.create(:share, wine: subject, amount: 3)
      expect(subject.is_fulfilled?).to be_truthy
    end

    it "validates that the suggester has not changed" do
      subject = FactoryGirl.create(:wine)
      subject.suggester = User.new
      subject.valid?
      expect(subject.errors[:suggester]).to include "cannot be changed"
    end
  end
end
