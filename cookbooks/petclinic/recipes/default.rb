#
# Cookbook:: petclinic
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
tomcat_install "petclinicserver" do 
  version '8.0.36'
end

tomcat_service "petclinicserver" do
  action [:enable, :start]
  env_vars [{'CATALINA_BASE' =>
'/opt/tomcat_petclinicserver_8_0_36/'},{'CATALINA_PID' =>
'$CATALINA_BASE/bin/tomcat.pid'},{'JAVA_OPTS' =>
'-Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true'}]
end
remote_file '/opt/tomcat_petclinicserver_8_0_36/webapps/petclinic.war' do
  source
'http://localhost:8081/libs-snapshot-local/org/springframework/samples/spring-petclinic/2.1.1.BUILD-SNAPSHOT.war'
#'http://your.artifactory.server:8081/path/to/petclinic/pettclinic-1.0.0-SNAPS
#HOT.war'
  owner 'tomcat_petclinicserver'
  group 'tomcat_petclinicserver'
end
directory '/home/tomcat_petclinicserver' do
  owner 'tomcat_petclinicserver'
  group 'tomcat_petclinicserver'
  mode 0755
end
