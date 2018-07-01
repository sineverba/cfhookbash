
case ${1} in

        "www.example.com")
        #move certificate to private

        cp /home/sineverba/dehydrated/certs/domain/cert.pem /var/www/domain/private/cert.pem
        cp /home/sineverba/dehydrated/certs/domain/privkey.pem /var/www/domain/private/privkey.pem
        cp /home/sineverba/dehydrated/certs/domain/fullchain.pem /var/www/domain/private/fullchain.pem

        #restart nginx
        service nginx restart

        #exchange certificate for domoticz
        rm /home/sineverba/domoticz/server_cert.pem
        cat /var/www/domain/private/privkey.pem >> /home/sineverba/domoticz/server_cert.pem
        cat /var/www/domain/private/fullchain.pem >> /home/sineverba/domoticz/server_cert.pem
        cp /home/sineverba/domoticz/server_cert.pem /home/sineverba/domoticz/letsencrypt_server_cert.pem

        #restart domoticz
        /etc/init.d/domoticz.sh restart

	#restart mysensors
	service mysgw restart

        ;;

esac

