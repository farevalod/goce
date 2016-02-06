class Payment < ActiveRecord::Base
  belongs_to :patient
  def mes_s
	  meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Junio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
	  meses[mes-1]
  end
  def self.months
	 ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Junio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"].zip(1..12)
  end
end
