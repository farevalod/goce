ActiveAdmin.register Doctor do

menu label: "Terapeuta"
index title: "Terapeutas"
permit_params :name, :email, :profession
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
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
		  doctor.name
	  end
	  row :email
	  row "Profesion" do
		  doctor.profession
	  end
	  row :grupos do
		  doctor.groups.map{|g| link_to(g.name, admin_group_path(g))}.join(", ").html_safe
	  end
	end
	panel "Sesiones" do
		table do
			doctor.sessions.each do |session|
				tr do
				 td link_to(session.created_at.to_date.to_s+" en grupo "+session.group.name, admin_session_path(session))
				end
			end
		end
	  end
    active_admin_comments
  end

  form :title => "Nuevo Terapeuta" do |f|
	f.inputs do
	  f.input :name, label: "Nombre", :input_html => { :style => "width:160px" }
	  f.input :email, :input_html => { :style => "width:160px" }
	  f.input :profession, label: "Profesion", :input_html => { :style => "width:160px" }
	end
	f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

end
