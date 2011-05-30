package "wget"
package "libcurl4-openssl-dev"

include_recipe "ssl_terminator::configure"

directory "#{node[:ssl_terminator][:src_dir]}" do
  action :create
  recursive true
end

execute "download stunnel" do
  cwd node[:ssl_terminator][:src_dir]
  command "wget #{node[:ssl_terminator][:stunnel][:url]} -O stunnel.tar.gz"
  not_if do
    File.exists?("#{node[:ssl_terminator][:src_dir]}/stunnel.tar.gz")
  end
end

execute "download stunnel patch" do
  cwd node[:ssl_terminator][:src_dir]
  command "wget #{node[:ssl_terminator][:stunnel][:patch]} -O stunnel.patch"
  not_if do
    File.exists?("#{node[:ssl_terminator][:src_dir]}/stunnel.patch")
  end
end


execute "unpack stunnel" do
  cwd node[:ssl_terminator][:src_dir]
  command "tar -xvzf stunnel.tar.gz && mv stunnel-#{node[:ssl_terminator][:stunnel][:version]} stunnel"
  not_if do
    File.directory?("#{node[:ssl_terminator][:src_dir]}/stunnel")
  end
end

execute "patch stunnel" do
  cwd "#{node[:ssl_terminator][:src_dir]}/stunnel"
  command "patch -p1 < ../stunnel.patch && touch ../patched.done"
  not_if do
    File.exists?("#{node[:ssl_terminator][:src_dir]}/patched.done")
  end
end

execute "install stunnel" do
  cwd "#{node[:ssl_terminator][:src_dir]}/stunnel"
  command "./configure --prefix=#{node[:ssl_terminator][:stunnel][:prefix]} --sysconfdir=#{node[:ssl_terminator][:stunnel][:sysconfdir]} && make && make install"
end