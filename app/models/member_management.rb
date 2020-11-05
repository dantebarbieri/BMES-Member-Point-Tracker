class MemberManagement < ApplicationRecord
  belongs_to :member
  def self.to_csv
   attributes = %w{name email year points}

   CSV.generate(headers: true) do |csv|
     csv << attributes

     all.each do |user|
       csv << attributes.map{ |attr| user.send(attr) } << user.total_points
     end
   end
 end
end
