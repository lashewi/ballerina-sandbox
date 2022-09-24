import ims/billionairehub;

# Client ID and Client Secret to connect to the billionaire API
configurable string clientId = "V5bhO97JalSWqUMcItOuKzhf1pca";
configurable string clientSecret = "eeXDwSQOfX_WZ2PMaD2rvOjyCTga";

billionairehub:Client cl = check new ({auth: {clientId, clientSecret}});

public function getTopXBillionaires(string[] countries, int x) returns string[]|error {
    
    billionairehub:Billionaire[] response = [];
    foreach var country in countries {
        billionairehub:Billionaire[] countryData = check getBillionaires(country);
        response.push(...countryData);
    }

   return from var e in response
                        order by e.netWorth descending
                        limit x
                        select e.name;

}

function getBillionaires(string country) returns billionairehub:Billionaire[]|error{
    return check cl->getBillionaires(country);
}

