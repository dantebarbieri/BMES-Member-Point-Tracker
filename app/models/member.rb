class Member < ApplicationRecord
	has_many :accomplishments_members
	has_many :accomplishments, :through => :accomplishments_members
	has_and_belongs_to_many :events
end
