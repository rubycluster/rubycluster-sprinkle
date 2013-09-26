DEPLOY_TO="vagrant" DEPLOY_RECIPE="init" sprinkle -v -c -s policies/base_init.rb &&
DEPLOY_TO="vagrant" DEPLOY_RECIPE="sudo" sprinkle -v -c -s policies/base_sudo.rb &&
DEPLOY_TO="vagrant" DEPLOY_RECIPE="user" sprinkle -v -c -s policies/base_user.rb &&
echo "Complete"
