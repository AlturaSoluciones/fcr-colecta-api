server "colecta.alturasoluciones.com", user: "fcr", roles: %w{app db web}
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp