# frozen_string_literal: true

class Donation
  @@next_id = 1
  attr_reader :id, :donor_name, :amount, :charity_id, :date_time

  def initialize(donor_name, amount, charity_id)
    raise "Invalid donation amount" unless amount.to_f > 0

    @id = @@next_id
    @@next_id += 1
    @donor_name = donor_name
    @amount = amount.to_f
    @charity_id = charity_id
    @date_time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
  end
end
