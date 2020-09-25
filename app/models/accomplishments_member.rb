class AccomplishmentsMember < ApplicationRecord
	belongs_to :member
	belongs_to :accomplishment
	belongs_to :semester
end
