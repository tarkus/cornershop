class LoanHistory < ActiveRecord::Base
	belongs_to :user
	belongs_to :medium
  attr_accessible :medium_id, :rent_effective, :rent_estimated, :rent_start, :user_id
end
