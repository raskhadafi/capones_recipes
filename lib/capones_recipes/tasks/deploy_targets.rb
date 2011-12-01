Capistrano::Configuration.instance.load do
  # Load configuration
  config_path = File.expand_path('~/.capones.yml')

  if File.exist?(config_path)
    # Parse config file
    config = YAML.load_file(config_path)

    # States
    deploy_target_path = File.expand_path(config['deploy_target_repository']['path'])

    # Add stages
    set :stage_dir, File.join(deploy_target_path, application, 'stages')
    load_paths << ""
  end
end
