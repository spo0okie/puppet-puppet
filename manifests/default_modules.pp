include puppet

class puppet::default_modules {
	$module_stdlib = 'puppetlabs-stdlib'
	exec { 'puppet_module_stdlib':
		command => "puppet module install ${module_stdlib}",
		unless  => "puppet module list | grep ${module_stdlib}",
		path => '/bin:/sbin:/usr/bin:/usr/sbin'
	}
	$module_inifile = 'puppetlabs-inifile'
	exec { 'puppet_module_inifile':
		command => "puppet module install ${module_inifile}",
		unless  => "puppet module list | grep ${module_inifile}",
		path => '/bin:/sbin:/usr/bin:/usr/sbin'
	}
}
