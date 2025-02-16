
require 'rspec'
require_relative '../application//charity_repository'
require_relative '../application/charity'

RSpec.describe CharityRepository do
  let(:repository) { CharityRepository.new }
  let(:charity1) { Charity.new('Red Cross', 'contact@redcross.org') }
  let(:charity2) { Charity.new('UNICEF', 'info@unicef.org') }

  describe '#initialize' do
    it 'starts with an empty charities list' do
      expect(repository.all).to eq([])
    end
  end

  describe '#add' do
    it 'adds a charity to the repository' do
      repository.add(charity1)

      expect(repository.all).to include(charity1)
      expect(repository.all.size).to eq(1)
    end
  end

  describe '#all' do
    it 'returns all added charities' do
      repository.add(charity1)
      repository.add(charity2)

      expect(repository.all).to contain_exactly(charity1, charity2)
    end
  end

  describe '#find_by_id' do
    it 'finds a charity by ID' do
      repository.add(charity1)
      repository.add(charity2)

      expect(repository.find_by_id(charity1.id)).to eq(charity1)
      expect(repository.find_by_id(charity2.id)).to eq(charity2)
    end

    it 'returns nil if ID is not found' do
      expect(repository.find_by_id(999)).to be_nil
    end
  end

  describe '#delete' do
    it 'removes a charity by ID' do
      repository.add(charity1)
      repository.add(charity2)

      repository.delete(charity1.id)

      expect(repository.all).not_to include(charity1)
      expect(repository.all).to include(charity2)
      expect(repository.all.size).to eq(1)
    end

    it 'does nothing if ID is not found' do
      repository.add(charity1)

      expect { repository.delete(999) }.not_to change { repository.all.size }
    end
  end
end
