ActiveAdmin.register Patient do

menu label: "Paciente"
index title: "Paciente"
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :email, :dob, :group_id, :initial_weight, :created_at, :status, :rut, :height
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
form do |f|
  f.semantic_errors # shows errors on :base
  f.inputs do
	f.input :group
	f.input :name
	f.input :email
	f.input :status, label: "Estado", :as => :select, :collection => [["Lista de espera",0], ["Paciente",1], ["Retirado",2], ["Graduado",3], ["Monitor",4]]
	f.input :initial_weight
	f.input :dob, as: :datepicker, label: "Fecha de nacimiento"
	f.input :height, label: "Altura (en cm)"
	f.input :rut
	f.input :created_at, as: :datepicker, label: "Fecha de incorporacion"
  end
  f.actions         # adds the 'Submit' and 'Cancel' buttons
end


  show do
    attributes_table do
      row "Nombre" do
		  patient.name
	  end
      row :email
      row "Fecha de nacimiento" do
		  patient.dob
	  end
      row "Altura" do
		  patient.height
	  end
      row :rut
	  row "Grupo" do
		  patient.group
	  end
      row "Estado" do
		  patient.status_s
	  end
      row "Peso Inicial" do
	    patient.initial_weight.to_s+" Kg"
	  end
      row "Fecha de incorporacion" do
	    patient.created_at
	  end
	  if patient.balance < 0
		row "Total Deuda" do
		  number_to_currency patient.balance.abs, separator: ",", delimiter: ".", precision: 0
		end
	  else
		  row "Saldo a favor" do
			number_to_currency patient.balance.abs, separator: ",", delimiter: ".", precision: 0
		  end
	  end
    end
		panel "Evolucion de peso" do
			table do
				patient.attendances.each do |attendance|
					tr do
					 td link_to(attendance.created_at, admin_attendance_path(attendance))
					 td do 
						b attendance.weight
					 end
					 td do
						if attendance.weight - attendance.patient.attendances[attendance.patient.attendances.find_index(attendance)-1].weight > 0
							span style: "color:#3a3" do
								"+"+(attendance.weight - attendance.patient.attendances[attendance.patient.attendances.find_index(attendance)-1].weight).to_s
							end
						else
							span style: "color:#a33" do
							    (attendance.weight - attendance.patient.attendances[attendance.patient.attendances.find_index(attendance)-1].weight).to_s
							end
						end
					 end
					end
				end
			end
		  end

		panel "Pagos" do
			table do
				patient.payments.each do |payment|
					tr do
					 td link_to(payment.created_at, admin_payment_path(payment))
					 td number_to_currency payment.amount, separator: ",", delimiter: ".", precision: 0
					end
				end
		  end
		end
    active_admin_comments
  end
end
