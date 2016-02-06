ActiveAdmin.register Patient do

menu label: "Paciente"
index title: "Paciente" do
	id_column
	column :name
	column :email
	column :rut
	column "Altura" do |a|
		a.height
	end
	column "Peso Inicial" do |a|
		a.initial_weight
	end
	column "Peso Objetivo" do |a|
		a.target
	end
	column "Estado" do |a|
		a.status_s
	end
	column "Fecha de Nacimiento" do |a|
		a.dob
	end
	column "Fecha de Incorporacion" do |a|
		a.created_at.to_date
	end
	actions
end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :email, :dob, :group_id, :initial_weight, :created_at, :status, :rut, :height, :cirugia, :medicamentos
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
form title: "Nuevo Paciente"do |f|
  f.semantic_errors # shows errors on :base
  f.inputs do
	f.input :group
	f.input :name, :input_html => { :style => "width:300px" }
	f.input :email, :input_html => { :style => "width:200px" }
	f.input :rut, :input_html => { :style => "width:100px" }
	f.input :status, label: "Estado", :as => :select, :collection => [["Lista de espera",0], ["Paciente",1], ["Retirado",2], ["Graduado",3], ["Monitor",4]]
	f.input :initial_weight, :input_html => { :style => "width:100px" }
	f.input :target, :input_html => { :style => "width:100px" }
	f.input :height, label: "Altura (en cm)", :input_html => { :style => "width:100px" }
	f.input :dob, as: :datepicker, label: "Fecha de nacimiento", :input_html => { :style => "width:100px" }
	f.input :medicamentos, :input_html => { :style => "width:100px" }
	f.input :created_at, as: :datepicker, label: "Fecha de incorporacion", :input_html => { :style => "width:100px" }
	f.input :cirugia, label: "Cirugia Bariatrica"
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
		  patient.height.to_s+" cm"
	  end
      row :rut
	  row "Grupo" do
		  patient.group
	  end
	  row :cirugia
	  row :medicamentos
      row "Estado" do
		  patient.status_s
	  end
      row "Peso Inicial" do
	    patient.initial_weight.to_s+" Kg (IMC: "+(patient.initial_weight/((patient.height/100.0)*(patient.height/100.0))).to_s(:rounded, precision: 2)+")"
	  end
      row "Peso Objetivo" do
	    patient.target.to_s+" Kg (IMC: "+(patient.target/((patient.height/100.0)*(patient.height/100.0))).to_s(:rounded, precision: 2)+")"
	  end
	  if !patient.attendances.empty?
		  row "Peso Actual" do
			patient.attendances.last.weight.to_s+" Kg (IMC: "+(patient.attendances.last.weight/((patient.height/100.0)*(patient.height/100.0))).to_s(:rounded, precision: 2)+")"
		  end
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
					 td link_to(attendance.created_at.to_date, admin_attendance_path(attendance))
					 td do 
						b attendance.weight
					 end
					 td do
						if attendance.patient.attendances.find_index(attendance) == 0
							if attendance.weight - attendance.patient.initial_weight > 0
								b style: "color:#3a3" do
									"+"+(attendance.weight - attendance.patient.initial_weight).to_s
								end
							else
								b style: "color:#a33" do
									(attendance.weight - attendance.patient.initial_weight).to_s
								end
							end
						else
							if attendance.weight - attendance.patient.attendances[attendance.patient.attendances.find_index(attendance)-1].weight > 0
								b style: "color:#3a3" do
									"+"+(attendance.weight - attendance.patient.attendances[attendance.patient.attendances.find_index(attendance)-1].weight).to_s
								end
							else
								b style: "color:#a33" do
									(attendance.weight - attendance.patient.attendances[attendance.patient.attendances.find_index(attendance)-1].weight).to_s
								end
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
