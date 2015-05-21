set :user, "vagrant"
server "192.168.50.4", :app, :web, :db, :primary => true
set :deploy_to, "/home/vagrant/shrtnr"
