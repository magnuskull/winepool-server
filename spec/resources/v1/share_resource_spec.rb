module V1
  RSpec.describe ShareResource do

    let :creatable_fields do
      [:amount, :user, :wine].sort
    end

    subject do
      described_class.new Share.new, {}
    end

    it "has the expected createable fields" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields
    end

    it "has the expected updatable fields" do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields
    end

    it "has the expected fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq (creatable_fields + [:id, :created_at, :updated_at]).sort
    end

  end
end
