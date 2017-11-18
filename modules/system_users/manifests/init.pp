class add_lab_users {

	user { 'labuser':
  		ensure   => present,
  		password => "labuser",
	}
}
