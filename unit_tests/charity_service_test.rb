
require 'rspec'
require_relative '../application/charity_service'
require_relative '../application/charity'
require_relative '../application/charity_repository'

RSpec.describe CharityService do
  let(:repository) { instance_double(CharityRepository) } # Mock repository
  let(:service) { CharityService.new(repository) }
  let(:charity1) { Charity.new('Red Cross', 'contact@redcross.org') }
  let(:charity2) { Charity.new('UNICEF', 'info@unicef.org') }

  describe '#view_charities' do
    it 'prints message when no charities exist' do
      allow(repository).to receive(:all).and_return([])

      expect { service.view_charities }.to output("No charities available.\n").to_stdout
    end

    it 'prints all charities when available' do
      allow(repository).to receive(:all).and_return([charity1, charity2])

      expected_output = <<~OUTPUT
        ID: #{charity1.id}, Name: #{charity1.name}, Email: #{charity1.email}
        ID: #{charity2.id}, Name: #{charity2.name}, Email: #{charity2.email}
      OUTPUT

      expect { service.view_charities }.to output(expected_output).to_stdout
    end
  end

  describe '#create_charity' do
    it 'creates a new charity with user input' do
      allow(service).to receive(:gets).and_return('Red Cross', 'contact@redcross.org')
      allow(repository).to receive(:add)

      expect { service.create_charity }.to output(/Charity added successfully./).to_stdout
      expect(repository).to have_received(:add).once
    end
  end

  describe '#edit_charity' do
    it 'updates a charity when found' do
      allow(service).to receive(:gets).and_return(charity1.id.to_s, 'New Name', 'new_email@example.com')
      allow(repository).to receive(:find_by_id).with(charity1.id).and_return(charity1)

      expect { service.edit_charity }.to output(/Charity updated successfully./).to_stdout
      expect(charity1.name).to eq('New Name')
      expect(charity1.email).to eq('new_email@example.com')
    end

    it 'prints an error when charity is not found' do
      allow(service).to receive(:gets).and_return('999') # ID that doesn't exist
      allow(repository).to receive(:find_by_id).with(999).and_return(nil)

      expect { service.edit_charity }.to output(/Charity not found./).to_stdout
    end
  end

  describe '#delete_charity' do
    it 'deletes a charity based on user input' do
      allow(service).to receive(:gets).and_return(charity1.id.to_s)
      allow(repository).to receive(:delete).with(charity1.id)

      expect { service.delete_charity }.to output(/Charity deleted successfully./).to_stdout
      expect(repository).to have_received(:delete).with(charity1.id)
    end
  end
end
