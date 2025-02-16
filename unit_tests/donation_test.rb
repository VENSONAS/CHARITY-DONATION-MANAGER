
require 'rspec'
require_relative '../application/donation'

RSpec.describe Donation do
  before(:each) do
    Donation.class_variable_set(:@@next_id, 1)
  end

  describe '#initialize' do
    it 'creates a donation with valid attributes' do
      donation = Donation.new('John Doe', 100, 1)

      expect(donation.donor_name).to eq('John Doe')
      expect(donation.amount).to eq(100.0)
      expect(donation.charity_id).to eq(1)
      expect(donation.date_time).to match(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/)
    end

    it 'assigns a unique ID to each donation' do
      donation1 = Donation.new('Alice', 50, 1)
      donation2 = Donation.new('Bob', 75, 2)

      expect(donation1.id).to be < donation2.id
    end

    it 'raises an error for non-positive donation amounts' do
      expect { Donation.new('John Doe', 0, 1) }.to raise_error("Invalid donation amount")
      expect { Donation.new('Jane Doe', -10, 2) }.to raise_error("Invalid donation amount")
    end

    it 'stores the amount as a float' do
      donation = Donation.new('John Doe', '50.5', 1)

      expect(donation.amount).to be_a(Float)
      expect(donation.amount).to eq(50.5)
    end
  end
end
