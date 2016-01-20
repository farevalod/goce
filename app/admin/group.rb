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
		  group.day
	  end
	  row "Hora" do
		  group.time
	  end
	  row "Terapeuta" do
		  link_to group.doctor.name, admin_doctor_path(group.doctor)
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


end
