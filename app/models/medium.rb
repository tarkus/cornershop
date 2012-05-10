class Medium < ActiveRecord::Base
  attr_accessible :availability, :cast, :description, :language, :location, :producer, :release_year, :title, :type
end
