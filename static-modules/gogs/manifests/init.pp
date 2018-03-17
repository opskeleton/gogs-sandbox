# Setting up gogs -> https://gogs.io/
class gogs(
  $version = '0.11.34',
  $user    = 're-ops'
){
  $url = "https://github.com/gogits/gogs/releases/download/v${version}/linux_amd64.tar.gz"

  file{'/usr/share/gogs':
    ensure => directory,
  }

  -> archive { $version:
    ensure        => present,
    url           => $url,
    digest_string => '9926f7d51c78a392fb0066866a4cdf69',
    target        => '/usr/share/gogs/',
    timeout       => 6000
  }

  package{'git':
    ensure  => present
  }

  package{'sqlite3':
    ensure  => present
  }

  systemd::unit_file { 'gogs.service':
    content => template('gogs/gogs.service.erb'),
  } ~> service {'gogs':
      ensure => 'running',
  }

}
