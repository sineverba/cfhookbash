# Instead of api_token, you can also use your global API key. For example:
#     global_api_key="YOUR_GLOBAL_KEY"
#     zones="YOUR_ZONES"
#     email="admin@example.com"
#
# If you wish to delegate the DNS challenges to another domain, you can set the suffix variable. For example:
#    suffix=".dns-01.example.org"
# And then add the appropriate CNAME records to delegate the challenges:
#    _acme-challenge.www.example.com CNAME _acme-challenge.www.example.com.dns-01.example.org
#    _acme-challenge.www.example.net CNAME _acme-challenge.www.example.net.dns-01.example.org
# In this case, the zone ID must refer to the delegated domain, and the API token must have edit
# permissions (only) for that domain.

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
