class User < ActiveRecord::Base
	has_many :loan_histories
  attr_accessible :name, :overdue_count, :phone, :position, :rental_count, :surname, :team
end
