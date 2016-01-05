class Patient < ActiveRecord::Base
	belongs_to :group
	has_many :payments
	has_many :attendances
	def owed
		30000*((Time.now-created_at.to_time)/(60*60*24*7)).ceil
	end
end
