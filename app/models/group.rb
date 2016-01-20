class Group < ActiveRecord::Base
	has_many :patients
	has_many :sessions
	belongs_to :doctor
end
