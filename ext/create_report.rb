require 'json'

agent_metrics = JSON.parse(`curl -s -X GET http://localhost:8080/pdb/query/v4/facts/puppet_agent_data`)

catalog_total = 0
report_total = 0


#{"certname":"ip-172-31-5-29.eu-central-1.compute.internal","name":"puppet_agent_data","value":{"report_size":999931,"catalog_size":1059552}
agent_metrics.each do |agent|
  catalog_total = catalog_total + agent['value']['catalog_size']
  report_total = report_total + agent['value']['report_size']
end

puts "Catalog total (bytes): #{catalog_total.to_s}"
puts "Report total (bytes): #{report_total.to_s}"

catalog_average = catalog_total / agent_metrics.count
report_average = report_total / agent_metrics.count

puts "catalog average: #{catalog_average}"
puts "report average: #{report_average}"

# todo - output lib dir size, as everyone will have to download that atleast once at first boot
# 
