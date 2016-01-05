ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: "Panel de Control" do

     columns do
       column do
         panel "Ultimos Pagos" do
		   table do
		     Payment.take(5).map do |payment|
               tr do
                 td link_to(payment.created_at, admin_payment_path(payment))
                 td "$"+payment.amount.to_s
			   end
             end
           end
         end
       end

       column do
         panel "Usuarios con deuda" do
		   table do
			 patient = Patient.first
			 total = 0
			 Payment.all.each do |p|
				 total += p.amount
			 end
			 tr do
				 td link_to(patient.name, admin_patient_path(patient))
				 td "$"+(144000-total).to_s
			 end
		   end
         end
       end
     end
  end # content
end
