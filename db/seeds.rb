# frozen_string_literal: true

usuario_admin = Usuario.new(nome: "Admin", email: "admin@agroecologymap.org", password: "agroecology", admin: "t")
usuario_admin.password_confirmation = "agroecology"
usuario_admin.skip_confirmation!
usuario_admin.save!

usuario_agroecologia = Usuario.new(nome: "Agroecology Map", email: "contact@agroecologymap.org", password: "agroecology", admin: "f")
usuario_agroecologia.password_confirmation = "agroecology"
usuario_agroecologia.skip_confirmation!
usuario_agroecologia.save!
