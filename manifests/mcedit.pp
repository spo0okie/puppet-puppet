class puppet::mcedit {
	file {"/usr/share/mc/syntax/puppet.syntax":
		ensure	=> file,
		source	=> 'puppet:///modules/puppet/mcedit/puppet.syntax',
		mode	=> '0644',
	} ->
		file_line { "mcedit_puppet_syntax_mask":
		path => '/etc/mc/Syntax',
		#тут у нас судя по man mcedit (https://www.systutorials.com/docs/linux/man/1-mcedit/) должно быть
		#вторым параметром экранированный regexp конфига астериска
		#допустим он выглядит так: *.pp, тогда:
		line => 'file ..\*\\.(pp)$ Puppet\sManifest',
		after => 'include syntax.syntax\n'
	} ->
	file_line { "mcedit_puppet_syntax_include":
		path => '/etc/mc/Syntax',
		line => 'include puppet.syntax',
		after => '^file.*Puppet'
	}
}
