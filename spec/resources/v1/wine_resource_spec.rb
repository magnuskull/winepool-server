module V1
  RSpec.describe WineResource do

    let :creatable_fields do
      [:name, :description, :bottles, :price, :suggester].sort
    end

    subject do
      described_class.new Wine.new, {}
    end

    it "has the expected creatable fields" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields
    end

    it "has the expected updatable fields" do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields
    end

    it "has the expected fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq (creatable_fields + [:id, :created_at, :updated_at, :shares, :fulfilled]).sort
    end

  end
end
