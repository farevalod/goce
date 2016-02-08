ActiveAdmin.register Group do
  menu label: "Grupos"
  index title: "Grupos"

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :address, :day, :time, :doctor_id
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
  show do
    attributes_table do
      row "Nombre" do
		  group.name
	  end
	  row "Direccion" do
		  group.address
	  end
	  row "Dia" do
		  group.day_s
	  end
	  row "Hora" do
		  group.time.to_s.split[1][0,5]
	  end
	  row "Terapeuta" do
		  link_to group.doctor.name, admin_doctor_path(group.doctor)
	  end
	end
	panel "Pacientes" do
		table do
			group.patients.each do |patient|
				tr do
				 td link_to(patient.name, admin_patient_path(patient))
				end
			end
		end
	  end
	panel "Sesiones" do
		table do
			group.sessions.each do |session|
				tr do
				 td link_to(session.created_at.to_date.to_s+" con "+session.doctors.map{|d| d.name}.join(" y "), admin_session_path(session))
				end
			end
		end
	  end
    active_admin_comments
  end
  form :title => "Nuevo Grupo" do |f|
	f.inputs do
	  f.input :doctor, label: "Terapeuta"
	  f.input :name, label: "Nombre", :input_html => { :style => "width:160px" }
	  f.input :address, label: "Direccion", :input_html => { :style => "width:380px" }
	  f.input :day, label: "Dia", as: :select, collection: [["Lunes",1],["Martes",2],["Miercoles",3],["Jueves",4],["Viernes",5]]
	  f.input :time, label: "Hora"
	end
	f.actions         # adds the 'Submit' and 'Cancel' buttons
  end


end
