class Patient < ActiveRecord::Base
	has_and_belongs_to_many :groups
	has_many :payments
	has_many :attendances
	def owed
		monthly = 0
		self.groups.each do |g|
			monthly += g.cost
		end
		monthly*((Time.now-created_at.to_time)/(60*60*24*7*30)).ceil
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
		if status
			return stats[status]
		else
			return nil
		end
	end
end
