#!/bin/bash
if [[ -n "$USERNAME_FILE" ]] && [[ -n "$PASSWORD_FILE" ]]
then
  USERNAME=$(cat "$USERNAME_FILE")
  PASSWORD=$(cat "$PASSWORD_FILE")
fi

if grep -q 'dav_ext_lock' /etc/nginx/nginx.conf; then
    echo found
else
    sed -i '/http {/a\dav_ext_lock_zone zone=webdav:10m;'  /etc/nginx/nginx.conf
fi

if [[ -n "$USERNAME" ]] && [[ -n "$PASSWORD" ]]
then
	echo  -n "$USERNAME:" >> /etc/nginx/htpasswd 
	openssl passwd -apr1 "$PASSWORD" >> /etc/nginx/htpasswd
	#htpasswd -bc /etc/nginx/htpasswd "$USERNAME" "$PASSWORD"
	echo Done.
else
    echo Using no auth.
	sed -i 's%auth_basic "Restricted";% %g' /etc/nginx/conf.d/default.conf
	sed -i 's%auth_basic_user_file /etc/nginx/htpasswd;% %g' /etc/nginx/conf.d/default.conf
fi
