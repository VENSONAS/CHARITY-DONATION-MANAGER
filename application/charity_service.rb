# frozen_string_literal: true

class CharityService
  def initialize(repository)
    @repository = repository
  end

  def view_charities
    charities = @repository.all
    if charities.empty?
      puts "No charities available."
    else
      charities.each { |charity| puts "ID: #{charity.id}, Name: #{charity.name}, Email: #{charity.email}" }
    end
  end

  def create_charity
    print "Enter new charity name: "
    name = gets.chomp
    print "Enter new charity email: "
    email = gets.chomp

    charity = Charity.new(name, email)
    @repository.add(charity)
    puts "Charity added successfully."
  end

  def edit_charity
    print "Enter charity ID to edit: "
    id = gets.chomp.to_i
    charity = @repository.find_by_id(id)
    return puts "Charity not found." unless charity

    print "Enter new name: "
    charity.name = gets.chomp
    print "Enter new email: "
    charity.set_email(gets.chomp)
    puts "Charity updated successfully."
  end

  def delete_charity
    print "Enter charity ID to delete: "
    id = gets.chomp.to_i
    @repository.delete(id)
    puts "Charity deleted successfully."
  end
end
