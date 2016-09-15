RSpec.describe Wine do
  describe "attributes" do
    it { is_expected.to have_attribute :name }
    it { is_expected.to have_attribute :description }
    it { is_expected.to have_attribute :bottles }
    it { is_expected.to have_attribute :price }
  end
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:bottles) }
    it { should validate_numericality_of(:price).allow_nil }
  end
end
