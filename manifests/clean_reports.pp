class puppet::clean_reports {
	file { '/usr/local/bin/puppet-reports-stalker':
		source	=>	"puppet:///modules/puppet/puppet-reports-stalker",
		mode	=>	"755",
		owner	=>	"root",
		group	=>	"root",
	} ->
	cron { 'puppet clean reports':
		command	=>	"/usr/local/bin/puppet-reports-stalker",
		user	=>	"root",
		hour	=>	21,
		minute	=>	22,
		weekday	=>	'*',
	}
}