def init(from_file)

  require_config(from_file)
  init_deployment
  require_all(from_file)

end

def relative_require_from(from_file, required_files_names)

  this_file = File.expand_path(from_file)
  this_dir = File.dirname(this_file)
  required_files = required_files_names.map do |name|
    File.realdirpath( File.join(this_dir, name) )
  end
  required_files.each { |lib| require lib }

end

def relative_require_all_from(from_file)
  this_file = File.expand_path(from_file)
  this_dir = File.dirname(this_file)
  files_mask = File.join(this_dir, '*', '*.rb')
  required_files = Dir[files_mask]
  required_files.each { |lib| require_relative lib }
end

def require_all(from_file)

  relative_require_from(from_file, %w[
    ../packages/all
  ])

end

def require_config(from_file)

  relative_require_from(from_file, %w[
    ../config/config
    ../config/sprinkle_package_patch
  ])

end

def relative_eval_from(from_file, required_files_names)

  this_file = File.expand_path(from_file)
  this_dir = File.dirname(this_file)
  required_files = required_files_names.map do |name|
    File.realdirpath( File.join(this_dir, name) )
  end
  required_files.each { |lib| instance_eval(File.read(lib)) }

end

def init_deployment(recipe_name = nil)

  recipe_name ||= (ENV['DEPLOY_RECIPE'] || 'deploy')
  recipe_path = ['recipes', recipe_name].join('/')

  deployment do

    delivery :capistrano do
      recipes recipe_path
    end

    source do
      prefix   '/usr/local'           # where all source packages will be configured to install
      archives '/usr/local/sources'   # where all source packages will be downloaded to
      builds   '/usr/local/build'     # where all source packages will be built
    end

  end

end

def forward_variables
  Sprinkle::Settings.set_variables = self.variables
end

def transfer_text(local_file, remote_file, options = {})

  data = File.read(File.join(File.dirname(__FILE__), '..', local_file))

  push_text data, remote_file, options do
    pre :install, "truncate --size=0 --no-create #{remote_file}"
  end

end

def transfer_dotfile(local_file, remote_file, options = {})

  transfer_text ['dotfiles', local_file].join('/'), remote_file

  verify do
    has_file remote_file
  end

end

def transfer_dotfiles(pairs, options = {})

  pairs.each do |local_file, remote_file, pair_options|
    transfer_dotfile local_file, remote_file, options.merge(pair_options || {})
  end

end

def requires_each(packages = [])

  packages.reject{ |i| i.include?('#') }.map(&:to_sym).each do |package|
    requires package
  end

end

def push_password_to_cmd(password, command)
  cmd = [ "echo -e '#{password}'", " | ", command ].join
end

def ssh_port_should_be_changed?
  initial_port = Sprinkle::Settings.fetch(:initial_port)
  target_port = Sprinkle::Settings.fetch(:target_port)
  target_port.present? && (initial_port.present? && target_port != initial_port || target_port != 22)
  # false
end
