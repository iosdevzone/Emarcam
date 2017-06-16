all_tests:
	grep 'func test' EmarcamTests.swift | sed 's/()//' | awk '{ print "(\""$$2"\","$$2"),"; }' 
