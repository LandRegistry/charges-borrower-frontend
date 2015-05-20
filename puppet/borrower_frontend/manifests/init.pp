# Install and configure the Charges Borrower Frontend
class borrower_frontend (
    $port = '9000',
    $host = '0.0.0.0',
    $branch_or_revision = 'master'
) {
  require ::standard_env

  vcsrepo { '/opt/borrower-frontend':
    ensure   => latest,
    provider => git,
    source   => 'git://github.com/LandRegistry/charges-borrower-frontend',
    revision => $branch_or_revision,
    owner    => 'vagrant',
    group    => 'vagrant',
    notify   => Service['borrower_frontend'],
  }
  file { '/opt/borrower-frontend/bin/run.sh':
    ensure  => 'file',
    mode    => '0755',
    owner   => 'vagrant',
    group   => 'vagrant',
    source  => "puppet:///modules/${module_name}/run.sh",
    require => Vcsrepo['/opt/borrower-frontend'],
    notify  => Service['borrower_frontend'],
  }
  file { '/etc/nginx/conf.d/borrower_frontend.conf':
    ensure  => 'file',
    mode    => '0755',
    content => template("${module_name}/nginx.conf.erb"),
    owner   => 'vagrant',
    group   => 'vagrant',
    notify  => Service['nginx'],
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
      File['/opt/borrower-frontend/bin/run.sh'],
      File['/etc/init.d/borrower_frontend'],
      File['/etc/systemd/system/borrower_frontend.service']
    ],
  }
}
