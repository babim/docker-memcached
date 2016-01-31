#!/bin/bash

#create admin account to memcached using SASL
if [ ! -f /.memcached_admin_created ]; then
	PASS=admin
#	_word=$( [ ${MEMCACHED_PASS} ] && echo "preset" || echo "random" )

#	echo "=> Creating an admin user with a ${_word} password in Memcached"
	echo mech_list: plain > /usr/lib/sasl2/memcached.conf
	echo $PASS | saslpasswd2 -a memcached -c admin -p
	echo "=> Done"
	touch /.memcached_admin_created

	echo "========================================================================"
	echo "You can now connect to this Memcached server using:"
	echo ""
	echo "    USERNAME:admin      PASSWORD:$PASS"
	echo ""
	echo "Please remember to change the above password as soon as possible!"
	echo "========================================================================"
fi

set -e

# first check if we're passing flags, if so
# prepend with memcached
if [ "${1:0:1}" = '-' ]; then
	set -- memcached "$@"
fi

exec "$@"
