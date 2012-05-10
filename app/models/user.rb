class User < ActiveRecord::Base
  attr_accessible :name, :overdue_count, :phone, :position, :rental_count, :surname, :team
end
