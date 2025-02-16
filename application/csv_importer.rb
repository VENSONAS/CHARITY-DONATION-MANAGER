# frozen_string_literal: true

require 'csv'

class CsvImporter
  def initialize(repository)
    @repository = repository
  end

  def upload_charities
    print "Enter CSV filename (without extension): "
    filename = gets.chomp
    file_path = "data/#{filename}.csv"

    unless File.exist?(file_path)
      puts "File not found."
      return
    end

    CSV.foreach(file_path, headers: false) do |row|
      # Ensure row contains exactly two values
      next if row.nil? || row.length < 2

      name = row[0]&.strip
      email = row[1]&.strip

      # Skip empty or invalid entries
      if name.nil? || name.empty? || email.nil? || email.empty?
        puts "Skipping invalid row: #{row.inspect}"
        next
      end

      begin
        charity = Charity.new(name, email)
        @repository.add(charity)
      rescue => e
        puts "Error adding charity: #{e.message}"
      end
    end

    puts "Charities uploaded successfully."
  end
end
