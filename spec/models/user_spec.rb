RSpec.describe User do
  describe "attributes" do
    it { is_expected.to have_attribute :name }
  end

  describe "validatoins" do
    it { should validate_presence_of(:name) }
  end
end
