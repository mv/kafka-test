#
# standalone-script
#

###
### Pre-reqs
###

group "zk" do
  action    :create
  gid       1018
end

user "zk" do
  action    :create
  comment   "Zookeeper"
  uid       1018
  gid       1018
  home      "/home/zk"
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

package "ntp" do
  action :install
end

###
### Zookeeper
###

package "zookeeper" do
  action    :install
end

file "/etc/zookeeper/zoo.cfg" do
  action      :create
  owner       "root"
  group       "root"
  mode        "0644"
end

file "/etc/zookeeper/log4j.properties" do
  action      :create
  owner       "root"
  group       "root"
  mode        "0644"
end

directory "/var/lib/zookeeper" do
  action      :create
  owner       "zk"
  group       "zk"
  mode        0755
  recursive   true
end

directory "/var/log/zookeeper" do
  action      :create
  owner       "zk"
  group       "zk"
  mode        0755
  recursive   true
end

service "zookeeper" do
  action      [ :enable, :start ]
  supports    :start => true, :stop => true, :status => true, :restart => true
  subscribes  :reload, "template[/etc/zookeeper/zoo.cfg]", :immediately
end

# vim:ft=ruby:

