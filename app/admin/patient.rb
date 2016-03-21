ActiveAdmin.register Patient do

	menu label: "Pacientes"
	filter :groups
	filter :name, label: "Nombre"
	filter :rut, label: "RUT"
	filter :email
	filter :dob, label: "Fecha de nacimiento"
	filter :status
	filter :cirugia
	filter :medicamentos
	index title: "Pacientes" do
		column "Nombre" do |a|
			link_to(a.name, admin_patient_path(a))
		end
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
	permit_params :name, :email, :dob, :group_id, :initial_weight, :created_at, :status, :rut, :height, :cirugia, :medicamentos, :url_foto_antes, :url_foto_despues, group_ids: []
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
			f.input :groups, as: :select2_multiple
			f.input :name, label: "Nombre", :input_html => { :style => "width:300px" }
			f.input :email, :input_html => { :style => "width:200px" }
			f.input :rut, :input_html => { :style => "width:100px" }
			f.input :phone, label: "Telefono", :input_html => { :style => "width:100px" }
			f.input :address, label: "Comuna", :input_html => { :style => "width:100px" }
			f.input :status, label: "Estado", :as => :select, :collection => [["Lista de espera",0], ["Paciente",1], ["Retirado",2], ["Graduado",3], ["Monitor",4]]
			f.input :initial_weight, label: "Peso Inicial", :input_html => { :style => "width:100px" }
			f.input :target, label: "Peso Objetivo", :input_html => { :style => "width:100px" }
			f.input :height, label: "Altura (en cm)", :input_html => { :style => "width:100px" }
			f.input :dob, as: :datepicker, label: "Fecha de nacimiento", :input_html => { :style => "width:100px" }
			f.input :medicamentos, :input_html => { :style => "width:200px" }
			f.input :created_at, as: :datepicker, label: "Fecha de incorporacion", :input_html => { :style => "width:100px" }
			f.input :url_foto_antes, :input_html => { :style => "width:200px" }
			f.input :url_foto_despues, :input_html => { :style => "width:200px" }
			f.input :cirugia, label: "Cirugia Bariatrica"
		end
		f.actions         # adds the 'Submit' and 'Cancel' buttons
	end


	show do
		columns do
			column do
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
					row "Telefono" do
						patient.phone
					end
					row "Comuna" do
						patient.address
					end
					row "Grupos" do
						patient.groups.map{|g| link_to(g.name, admin_group_path(g))}.join(", ").html_safe
					end
					row "Cirugia Bariatrica" do
						if patient.cirugia
							"Si"
						else
							"No"
						end
					end
					row :medicamentos
					row "Estado" do
						patient.status_s
					end
					row "Peso Inicial" do
						if patient.height
							patient.initial_weight.to_s+" Kg (IMC: "+(patient.initial_weight/((patient.height/100.0)*(patient.height/100.0))).to_s(:rounded, precision: 2)+")"
						else
							patient.initial_weight.to_s+" Kg"
						end
					end
					row "Peso Objetivo" do
						if patient.height
							patient.target.to_s+" Kg (IMC: "+(patient.target/((patient.height/100.0)*(patient.height/100.0))).to_s(:rounded, precision: 2)+")"
						else
							patient.target.to_s+" Kg"
						end
					end
					if !patient.attendances.empty?
						row "Peso Actual" do
							last_attendance = patient.attendances.where("justificacion = ?",false).last
							if last_attendance
								last_attendance.weight.to_s+" Kg (IMC: "+(last_attendance.weight/((patient.height/100.0)*(patient.height/100.0))).to_s(:rounded, precision: 2)+")"
							else
								"No hay registro de pesos"
							end
						end
					end
					row "Fecha de incorporacion" do
						patient.created_at.to_date
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
			end
			column do
				attributes_table do
					row "Foto Antes" do
						image_tag(patient.url_foto_antes)
					end
					row "Foto Despues" do
						image_tag(patient.url_foto_despues)
					end
				end
			end
		end
		panel "Evolucion de peso" do
			table do
				patient.attendances.each do |attendance|
					if not attendance.justificacion
						tr do
							td link_to(attendance.session.name, admin_attendance_path(attendance))
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
					else
						tr do
							td link_to(attendance.session.name, admin_attendance_path(attendance))
							td "Inasistencia justificada"
						end
					end
				end
			end
		end

		panel "Pagos" do
			table do
				patient.payments.each do |payment|
					tr do
						td link_to(payment.created_at.to_date, admin_payment_path(payment))
						td number_to_currency payment.amount, separator: ",", delimiter: ".", precision: 0
					end
				end
			end
		end
		active_admin_comments
	end
end
