require 'rspec'
require_relative '../application/charity'

RSpec.describe Charity do
  describe '#initialize' do
    it 'assigns a unique ID to each new instance' do
      charity1 = Charity.new('Red Cross', 'contact@redcross.org')
      charity2 = Charity.new('UNICEF', 'info@unicef.org')

      expect(charity1.id).to be < charity2.id
    end

    it 'sets name and email correctly' do
      charity = Charity.new('Red Cross', 'contact@redcross.org')

      expect(charity.name).to eq('Red Cross')
      expect(charity.email).to eq('contact@redcross.org')
    end

    it 'initializes an empty donations array' do
      charity = Charity.new('Red Cross', 'contact@redcross.org')

      expect(charity.donations).to eq([])
    end
  end

  describe '#set_email' do
    it 'allows valid email addresses' do
      charity = Charity.new('Red Cross', 'contact@redcross.org')

      expect { charity.set_email('support@charity.com') }.not_to raise_error
      expect(charity.email).to eq('support@charity.com')
    end

    it 'raises an error for invalid email formats' do
      charity = Charity.new('Red Cross', 'contact@redcross.org')

      expect { charity.set_email('invalid-email') }.to raise_error("Invalid email format")
      expect { charity.set_email('missing@domain') }.to raise_error("Invalid email format")
    end
  end
end
