class Group < ActiveRecord::Base
	has_and_belongs_to_many :patients
	has_many :sessions
	belongs_to :doctor
	def day_s
		days = ["Lunes","Martes","Miercoles","Jueves","Viernes"]
		days[day.to_i-1]
	end
end
