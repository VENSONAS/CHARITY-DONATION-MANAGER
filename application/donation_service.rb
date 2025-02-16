# frozen_string_literal: true

class DonationService
  def initialize(repository)
    @repository = repository
  end

  def create_donation
    print "Enter charity ID to donate to: "
    id = gets.chomp.to_i
    charity = @repository.find_by_id(id)
    return puts "Charity not found." unless charity

    print "Enter donor name: "
    donor = gets.chomp
    print "Enter donation amount: "
    amount = gets.chomp.to_f

    donation = Donation.new(donor, amount, id)
    charity.donations << donation
    puts "Donation added successfully."
  end
end

