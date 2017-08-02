Facter.add(:puppet_agent_data) do
  setcode do
    puppet_agent_data = {}

    puppet_agent_certname = Puppet.settings['certname']
    # something like ip-172-31-9-108.eu-central-1.compute.internal
    puppet_agent_vardir = Puppet.settings['vardir']
    # something like /opt/puppetlabs/puppet/cache

    puppet_catalog_path = "#{puppet_agent_vardir}/client_data/catalog/#{puppet_agent_certname}.json"
    puppet_last_report_path = "#{puppet_agent_vardir}/state/last_run_report.yaml"

    if File.file?(puppet_catalog_path)
      puppet_agent_data['catalog_size'] = File.size(puppet_catalog_path)
    end

    if File.file?(puppet_last_report_path)
      puppet_agent_data['report_size'] = File.size(puppet_last_report_path)
    end

    puppet_agent_data
  end
end
