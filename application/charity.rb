# frozen_string_literal: true

class Charity
  @@next_id = 1
  attr_accessor :id, :name, :email, :donations

  def initialize(name, email)
    @id = @@next_id
    @@next_id += 1
    @name = name
    @donations = []
    set_email(email)
  end

  def set_email(email)
    raise "Invalid email format" unless email.match?(/^[^@]+@[^@]+\.[^@]+$/)
    @email = email
  end
end
