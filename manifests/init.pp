class puppet (
	$server=''
) {
	include repos::puppetlabs
	
	case "$::operatingsystem" {
		'CentOS': {
			$puppet_package='puppet-agent'
		}
		default: {
			$puppet_package='puppet'
		}
	}
	package {$puppet_package: 
		ensure => 'latest'
	} ->
	ini_setting {"puppet_logdir":
		ensure=>'present',
		path=>'/etc/puppetlabs/puppet/puppet.conf',
		section=>'main',
		setting=>'logdir',
		value=>'/var/log/puppet'
	} ->
	file {'/var/log/puppet/':
		ensure => 'directory',
		#owner => 'puppet',
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
	if $server!='' {
		ini_setting {"puppet_server":
			require=>Package[$puppet_package],
			ensure=>'present',
			path=>'/etc/puppetlabs/puppet/puppet.conf',
			section=>'agent',
			setting=>'server',
			value=>$server
		}
	}
}
