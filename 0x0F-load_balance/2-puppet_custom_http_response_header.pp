# Puppet manifest to configure Nginx with custom HTTP response header
# The custom header X-Served-By contains the hostname of the server

# Update package repository
exec { 'update_apt':
  command => '/usr/bin/apt-get update',
  before  => Package['nginx'],
}

# Install Nginx package
package { 'nginx':
  ensure  => installed,
  require => Exec['update_apt'],
}

# Create the main index.html file with "Hello World!"
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
  require => Package['nginx'],
}

# Configure Nginx default site with custom header
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => "server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    # Add custom header with hostname
    add_header X-Served-By \$hostname;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
}",
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

# Test nginx configuration before restarting
exec { 'test_nginx_config':
  command     => '/usr/sbin/nginx -t',
  refreshonly => true,
  subscribe   => File['/etc/nginx/sites-available/default'],
  before      => Service['nginx'],
}