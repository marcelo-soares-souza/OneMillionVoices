# frozen_string_literal: true

account_admin = Account.new(name: "Admin Agroecology Map", email: "admin@agroecologymap.org", password: "agroecology", admin: "t")
account_admin.password_confirmation = "agroecology"
account_admin.skip_confirmation!
account_admin.save!

account_agroecologia = Account.new(name: "Agroecology Map", email: "contact@agroecologymap.org", password: "agroecology", admin: "f")
account_agroecologia.password_confirmation = "agroecology"
account_agroecologia.skip_confirmation!
account_agroecologia.save!
