ActiveAdmin.register Patient do

menu label: "Paciente"
index title: "Paciente"
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :email, :dob, :group_id
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
      row :name
      row :email
      row :dob
      row :group
    end
		panel "Pagos" do
			table do
				patient.payments.each do |payment|
					tr do
					 td link_to(payment.created_at, admin_payment_path(payment))
					 td "$"+payment.amount.to_s
					end
				end
		  end
		end
    active_admin_comments
  end
end
