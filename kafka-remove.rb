#
# standalone-script
#

###
### Pre-reqs
###

group "kafka" do
  action :remove
end

user "kafka" do
  action :remove
end

###
### kafka
###

package "kafka" do
  action :remove
end

service "kafka" do
  action [ :disable, :stop ]
end

link "/opt/kafka/bin/kafka-console-consumer-log4j.properties" do
  action :delete
end

# vim:ft=ruby:


