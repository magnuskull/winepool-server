RSpec.describe Share do
  describe "attributes" do
    it { is_expected.to have_attribute :amount }
  end

  describe "validations" do
    it { should validate_numericality_of(:amount) }
  end
end
