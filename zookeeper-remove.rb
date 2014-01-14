#
# standalone-script
#

###
### Pre-reqs
###

group "zk" do
  action :remove
end

user "zk" do
  action :remove
end

###
### Zookeeper
###

package "zookeeper" do
  action :remove
end

service "zookeeper" do
  action [ :disable, :stop ]
end

# vim:ft=ruby:

