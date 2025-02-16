# frozen_string_literal: true

class CharityRepository
  def initialize
    @charities = []
  end

  def add(charity)
    @charities << charity
  end

  def all
    @charities
  end

  def find_by_id(id)
    @charities.find { |charity| charity.id == id }
  end

  def delete(id)
    @charities.reject! { |charity| charity.id == id }
  end
end
