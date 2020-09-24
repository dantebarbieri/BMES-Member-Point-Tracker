class AccomplishmentsMember < ApplicationRecord
	belongs_to :member
	belongs_to :accomplishment
end
