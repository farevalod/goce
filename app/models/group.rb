class Group < ActiveRecord::Base
	has_many :patients
	belongs_to :doctor
end
