class Patient < ActiveRecord::Base
	belongs_to :group
	has_many :payments
	has_many :attendances
	def owed
		30000*((Time.now-created_at.to_time)/(60*60*24*7)).ceil
	end
	def balance
		total = 0
		payments.each do |p|
			total += p.amount
		end
		total - owed
	end
	def status_s
		stats = ["Lista de espera", "Paciente", "Retirado", "Graduado", "Monitor"]
		return stats[status]
	end
end
