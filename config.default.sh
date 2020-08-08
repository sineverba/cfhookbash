global_api_key="YOUR_GLOBAL_KEY"
email="admin@example.com"

case ${1} in
	"example.com")
		zones="zoneidhere01"
	;;

	*".example.com")
		zones="zoneidhere01"
	;;
	
	"example.net")
		zones="zoneidhere02"
	;;

	*".example.net")
		zones="zoneidhere02"
	;;
esac
