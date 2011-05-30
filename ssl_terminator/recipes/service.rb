service "stunnel" do
  action :nothing
  supports :status => false, :restart => false, :reload => false
  start_command "/etc/init.d/stunnel start ; echo 0"
  stop_command "/etc/init.d/stunnel stop ; echo 0"
end