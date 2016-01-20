ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  menu label: "Inicio", priority: 1
  content title: "Panel de Control" do

     columns do
       column do
         panel "Ultimos Pagos" do
		   table do
		     Payment.take(5).map do |payment|
               tr do
                 td link_to(payment.created_at.to_date.to_s+" "+payment.patient.name, admin_payment_path(payment))
                 td number_to_currency payment.amount, separator: ",", delimiter: ".", precision: 0
			   end
             end
           end
         end
         panel "Estadisticas de  Pacientes" do
		   table do
		     tr do
				td "Numero de pacientes registrados 2016"
				td Patient.where("created_at > ?",Date.today.at_beginning_of_year).all.count
		   end
		     tr do
				td "Numero de pacientes registrados este mes"
				td Patient.where("created_at > ?",Date.today.at_beginning_of_month).all.count
		   end
		     tr do
				td "Numero de pacientes pagadores este mes"
				td Patient.where("created_at > ?",Date.today.at_beginning_of_month).select{|p| !p.payments.empty?}.count
		 end
		     tr do
				td "Numero de pacientes deuda este mes"
				td Patient.where("created_at > ?",Date.today.at_beginning_of_month).select{|p| p.balance < 0}.count
		 end
		     tr do
				td "Numero de pacientes asistentes este mes"
				td Patient.where("created_at > ?",Date.today.at_beginning_of_month).select{|p| !p.attendances.empty?}.count
		 end
			end
		 end

       end

       column do
         panel "Usuarios con deuda" do
		   table do
			 Patient.all.each do |patient|
				 if patient.balance < 0
					 tr do
						 td link_to patient.name, admin_patient_path(patient)
						 td number_to_currency (patient.balance.abs), separator: ",", delimiter: ".", precision: 0
					 end
				 end
			 end
		   end
         end
       end
     end
  end # content
end
