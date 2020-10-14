# Instead of api_token, you can also use your global API key. For example:
#     global_api_key="YOUR_GLOBAL_KEY"
#     zones="YOUR_ZONES"
#     email="admin@example.com"

case ${1} in
	"www.example.com")
		api_token="YOUR_API_TOKEN"
		zones="YOUR_ZONES"
	;;

	"www.example.net")
		api_token="ANOTHER_API_TOKEN"
		zones="ANOTHER_ZONE"
	;;
esac
