include_recipe "ssl_terminator::service"

directory "/etc/stunnel" do
  action :create
  recursive true
end

template "/etc/init.d/stunnel" do
  source "stunnel.init.erb"
  mode 0755
end

template "/etc/stunnel/stunnel.conf" do
  source "stunnel.conf.erb"
  mode 0644
  notifies :restart, resources(:service => "stunnel")
end

template "/etc/stunnel/stunnel.pem" do
  source "stunnel.pem.erb"
  mode 0600
  notifies :restart, resources(:service => "stunnel")
end

template "/etc/stunnel/stunnel.crt" do
  source "stunnel.crt.erb"
  mode 0600
  notifies :restart, resources(:service => "stunnel")
end

service "stunnel" do
  action :start
end