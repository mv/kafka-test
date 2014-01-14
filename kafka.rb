#
# standalone-script
#

###
### Pre-reqs
###

group "kafka" do
  action    :create
  gid       1019
end

user "kafka" do
  action    :create
  comment   "Kafka"
  uid       1019
  gid       1019
  home      "/home/kafka"
  shell     "/sbin/nologin"
  supports  :manage_home => false
end

case node[:platform]
  when "ubuntu","debian"
    package "openjdk-7-jre" do
      action :install
    end

  when "centos"
    package "java-1.7.0-openjdk" do
      action :install
    end
end


###
### kafka
###

package "kafka" do
  action    :install
end

file "/etc/kafka/kafka.cfg" do
  action      :create
  owner       "root"
  group       "root"
  mode        "0644"
end

file "/etc/kafka/kafka-log.cfg" do
  action      :create
  owner       "root"
  group       "root"
  mode        "0644"
end

link "/opt/kafka/bin/kafka-console-consumer-log4j.properties" do
  to "/etc/kafka/kafka-log.cfg"
end

directory "/var/lib/kafka" do
  action      :create
  owner       "kafka"
  group       "kafka"
  mode        0755
  recursive   true
end

directory "/var/log/kafka" do
  action      :create
  owner       "kafka"
  group       "kafka"
  mode        0755
  recursive   true
end

service "kafka" do
  action      [ :enable, :start ]
  supports    :start => true, :stop => true, :status => true, :restart => true
  subscribes  :reload, "template[/etc/kafka/zoo.cfg]", :immediately
end

# vim:ft=ruby:


