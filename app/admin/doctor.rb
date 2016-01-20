ActiveAdmin.register Doctor do

permit_params :name
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


end
