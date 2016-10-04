RSpec.describe User do
  describe "attributes" do
    it { is_expected.to have_attribute :name }
    it { is_expected.to have_attribute :email_address }
    it { is_expected.to have_attribute :mobile_phone_number }
  end

  describe "relationships" do
    it { is_expected.to have_many :shares }
    it { is_expected.to have_many(:wines).through(:shares) }
    it { is_expected.to have_many(:suggestions) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email_address) }
    it "should validate that email_address is unique" do
      original = FactoryGirl.create(:user, email_address: "user.name@email.com")
      duplicate = FactoryGirl.build(:user, email_address: original.email_address.upcase)      
      duplicate.valid?
      expect(duplicate.errors[:email_address]).to include "has already been taken"
    end
    it "should validate that mobile_phone_number is unique" do
      original = FactoryGirl.create(:user, mobile_phone_number: "1234")
      duplicate = FactoryGirl.build(:user, mobile_phone_number: original.mobile_phone_number)
      duplicate.valid?
      expect(duplicate.errors[:mobile_phone_number]).to include "has already been taken"
    end
  end
end
