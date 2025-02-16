# frozen_string_literal: true

require_relative 'application/charity_repository'
require_relative 'application/charity_service'
require_relative 'application/donation_service'
require_relative 'application/csv_importer'
require_relative 'application/charity'
require_relative 'application/donation'

class Main
  def initialize
    @charity_repo = CharityRepository.new
    @charity_service = CharityService.new(@charity_repo)
    @donation_service = DonationService.new(@charity_repo)
    @csv_importer = CsvImporter.new(@charity_repo)
  end

  def run
    loop do
      puts "\nEnter option: "
      puts "1: View all charities"
      puts "2: Add a new charity"
      puts "3: Edit an existing charity's details"
      puts "4: Delete a charity"
      puts "5: Add a donation"
      puts "6: Upload charity file"
      puts "0: END PROGRAM"
      print "Enter your option: "
      choice = gets.chomp.to_i

      case choice
      when 1 then @charity_service.view_charities
      when 2 then @charity_service.create_charity
      when 3 then @charity_service.edit_charity
      when 4 then @charity_service.delete_charity
      when 5 then @donation_service.create_donation
      when 6 then @csv_importer.upload_charities
      when 0
        puts "Exiting program..."
        break
      else
        puts "Wrong option, try again."
      end
    end
  end
end

Main.new.run

