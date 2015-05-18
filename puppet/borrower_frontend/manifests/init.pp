# Install and configure the Charges Borrower Frontend
class borrower_frontend ($port = '9000', $host = '0.0.0.0') {
  include ::standard_env

  vcsrepo { '/opt/borrower-frontend':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/LandRegistry/charges-borrower-frontend',
    revision => 'puppet-module',
    owner    => 'vagrant',
    group    => 'vagrant',
  }
  file { '/opt/borrower-frontend/sbin/run.sh':
    ensure => 'file',
    mode   => '0755',
    owner  => 'vagrant',
    group  => 'vagrant',
    source => "puppet:///modules/${module_name}/run.sh"
  }
  file { '/etc/init.d/borrower_frontend':
    ensure => 'file',
    mode   => '0755',
    owner  => 'vagrant',
    group  => 'vagrant',
    source => "puppet:///modules/${module_name}/borrower_frontend.initd",
  }
  file { '/etc/systemd/system/borrower_frontend.service':
    ensure  => 'file',
    mode    => '0755',
    owner   => 'vagrant',
    group   => 'vagrant',
    content => template("${module_name}/borrower_frontend_service.erb"),
    notify  => [Exec['systemctl-daemon-reload'], Service['borrower_frontend']],
  }
  service { 'borrower_frontend':
    ensure   => 'running',
    enable   => true,
    provider => 'systemd',
    require  => [
      Vcsrepo['/opt/borrower-frontend'],
      File['/opt/borrower_frontend/sbin/run.sh'],
      File['/etc/init.d/borrower_frontend'],
      File['/etc/systemd/system/borrower_frontend.service']
    ],
  }
}
