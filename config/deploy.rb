require 'capistrano/ext/multistage'

set :application, "shrtnr"
set :scm, :git
set :repository,  "https://github.com/benwoody/shrtnr.git"
set :scm_passphrase, ""

set :ssh_options, {:forward_agent => true, keys: ['~/.vagrant.d/insecure_private_key']}
set :default_run_options, {:pty => true}
set :stages, ["vagrant"]
set :default_stage, "vagrant"
set :normalize_asset_timestamps, false
