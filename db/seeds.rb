# frozen_string_literal: true

password = ENV.fetch("ADMIN_PASSWORD") { "agroecology" }

account_admin = Account.new(name: "One Million Voices Administrator", email: "admin@agroecologymap.org", password: password, admin: "t")
account_admin.password_confirmation = password
account_admin.skip_confirmation!
account_admin.save!

account_agroecologia = Account.new(name: "One Million Voices", email: "contact@agroecologymap.org", password: password, admin: "f")
account_agroecologia.password_confirmation = password
account_agroecologia.skip_confirmation!
account_agroecologia.save!
