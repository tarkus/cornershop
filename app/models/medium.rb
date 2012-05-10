class Medium < ActiveRecord::Base
	has_many :loan_histories
  attr_accessible :availability, :cast, :language, :location, :producer, :year, :title, :media_type
end
