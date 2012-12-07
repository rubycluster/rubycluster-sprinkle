DEPLOY_TO="vps_init" sprinkle -s policies/init_remote.rb
DEPLOY_TO="vps_sudo" sprinkle -s policies/base_sudo.rb
DEPLOY_TO="vps_user" sprinkle -s policies/base_user.rb
