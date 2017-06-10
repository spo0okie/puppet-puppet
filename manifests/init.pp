include stdlib
class puppet {
	case $::operatingsystem {
		Debian: {
			include repos::puppetlabs
			package {'puppet': ensure => latest }
		}
		CentOS: {
			include repos::puppetlabs
			package {'puppet': ensure => latest }
		}
		OpenSuSE: {
			package {'ruby2.1-rubygem-puppet': ensure => latest }
		}
	} ->
	file {'/var/log/puppet/':
		ensure => 'directory',
		owner => 'puppet',
		mode => '0750'
	} ->
	file {'/etc/rsyslog.d/puppet.conf':
		source => 'puppet:///modules/puppet/rsyslog.d/puppet.conf',
		mode => '0644',
		notify => Service['rsyslog']
	} ->
	service {'puppet':
		enable => true,
		ensure => running,
	} 
}


