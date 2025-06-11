public with sharing class NasaAstoroid {
	public static Map<String, List<NasaNeoFeedWrapper.NeoObject>> near_earth_objects;
	public static NasaNeoFeedWrapper amzData;
	public static string api_key= 'c5miOVYaAWrDmFYfK7X6Hpos3TRWDNa6fRDpgvJJ';// will take form cstm metadataaa
	
    @AuraEnabled
    public static NasaNeoFeedWrapper getdata(string startdate, string enddate){
        string endpoint = 'https://api.nasa.gov/neo/rest/v1/feed?start_date='+startdate+'&end_date='+enddate+'&api_key=' + api_key;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
		req.setTimeout(40000);
        try{
            Http http = new Http();
            HTTPResponse res = http.send(req);
            system.debug('response'+res.getStatusCode());
            System.debug('res.getBody()'+res.getBody());
            amzData = (NasaNeoFeedWrapper) JSON.deserialize(res.getBody(), NasaNeoFeedWrapper.class);
			near_earth_objects = amzdata.near_earth_objects;
			system.debug(near_earth_objects);
            //list<product> amzproductList = amzData.Data.products;
            //System.debug(' amzproductList '+amzproductList);
            return amzData;
        }
        catch(exception e){
		return null;
		}
    }


}