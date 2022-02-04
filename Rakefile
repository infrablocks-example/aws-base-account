# frozen_string_literal: true

require 'confidante'
require 'rake_terraform'
require 'rake_gpg'
require 'paint'
require 'json'

configuration = Confidante.configuration

RakeTerraform.define_installation_tasks(
  path: File.join(Dir.pwd, 'vendor', 'terraform'),
  version: '0.15.4'
)

namespace :secrets do
  desc 'Check if secrets are readable'
  task :check do
    if File.exist?('config/secrets')
      puts 'Checking if secrets are accessible.'
      unless File.read('config/secrets/.unlocked').strip == 'true'
        raise Paint['Cannot access secrets.', :red]
      end

      puts 'Secrets accessible. Continuing.'
    end
  end

  desc 'Unlock secrets'
  task :unlock do
    if File.exist?('config/secrets')
      puts 'Unlocking secrets.'
      sh('git crypt unlock')
    end
  end
end

namespace :gpg_keys do
  namespace :admin do
    RakeGPG.define_generate_key_task(
      prerequisites: ['secrets:check'],
      owner_name: 'Atomic AWS Admins',
      owner_email: 'admin.aws@go-atomic.io',
      name_prefix: 'admin.gpg',
      output_directory: 'config/secrets/gpg',
      armor: false
    )
  end
end

namespace :bootstrap do
  RakeTerraform.define_command_tasks(
    configuration_name: 'bootstrap infrastructure',
    argument_names: %i[
      deployment_group
      deployment_type
      deployment_label
    ]
  ) do |t, args|
    configuration = configuration
                      .for_scope(args.to_h.merge(role: 'bootstrap'))

    deployment_identifier = configuration.deployment_identifier
    vars = configuration.vars

    t.source_directory = 'infra/bootstrap'
    t.work_directory = 'build'

    t.state_file =
      File.join(
        Dir.pwd, "state/bootstrap/#{deployment_identifier}.tfstate"
      )
    t.vars = vars
  end
end

namespace :common do
  RakeTerraform.define_command_tasks(
    configuration_name: 'common',
    argument_names: %i[
      deployment_group
      deployment_type
      deployment_label
    ]
  ) do |t, args|
    configuration = configuration
                      .for_scope(args.to_h.merge(role: 'common'))

    t.source_directory = 'infra/common'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end
