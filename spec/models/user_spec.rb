RSpec.describe User do
  describe "attributes" do
    it { is_expected.to have_attribute :name }
  end

  describe "relationships" do
    it { is_expected.to have_many :shares }
    it { is_expected.to have_many(:wines).through(:shares) }
    it { is_expected.to have_many(:suggestions) }    
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
