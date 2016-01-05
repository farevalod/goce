class Patient < ActiveRecord::Base
	belongs_to :group
	has_many :payments
end
