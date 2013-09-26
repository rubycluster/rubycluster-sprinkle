# Sprinkle script for building Server

## Requirements

* Ruby, Rubygems
* [option] Vagrant

# Installation

    git clone this.repository
    cd this.repository
    cp config/config.rb.example \
       config/config.rb
    vim config/config.rb
    # add you server credentials
    # copy your dotfiles to ./dotfiles
    gem install sprinkle

# Usage

## Sprinkle auto script

    ./bootstrap_vps.sh

## After running sprinkle auto script

### ssh into server

    ssh deployer@vps

### Install rvm ruby

    rvm install 1.9.3
    rvm --default use 1.9.3
    rvm gemset use global --create
    rvm rubygems latest
    gem install rake bundler thor thin foreman capistrano capistrano-ext capistrano_colors pry pry-doc

### Prepare apps folders

    mkdir ~/www/apps

### Install passenger with nginx

    gem install passenger
    rvmsudo passenger-install-nginx-module
    # enter > 1 enter > enter > enter
    sudo curl -L http://bit.ly/nginx-ubuntu-init-file -o /etc/init.d/nginx
    sudo chmod +x /etc/init.d/nginx
    sudo service nginx start

    sudo mkdir /opt/nginx/sites-available
    sudo mkdir /opt/nginx/sites-enabled

    sudo -E vim /opt/nginx/conf/nginx.conf

### Edit Nginx conf file

add after "http {":

    server_names_hash_bucket_size 64;

add before last closing "}":

    include /opt/nginx/sites-enabled/*;

## Prepare new project:

    cd /opt/nginx/sites-available
    sudo -E vim project-name

### Add configuration

    server {
      listen 80;
      server_name #{url};
      root /home/deployer/www/apps/#{app_name}/current/public;
      rails_env production;
      passenger_enabled on;
      passenger_min_instances 1;
    }

### Enable configuration

    cd /opt/nginx/sites-enabled
    sudo ln -s ../sites-available/project-name
    sudo service nginx reload

## Ready

    exit
    # deploy your apps via capistrano
