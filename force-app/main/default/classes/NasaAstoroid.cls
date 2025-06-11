public with sharing class NasaAstoroid {
	public static Map<String, List<NasaNeoFeedWrapper.NeoObject>> near_earth_objects;
	public static list<NasaNeoFeedWrapper.NeoObject> closelist;
	public static NasaNeoFeedWrapper amzData;
	public NasaNeoFeedWrapper.CloseApproachData closedata;
	public static map<decimal, List<NasaNeoFeedWrapper.CloseApproachData>> finalmap = new map<decimal, List<NasaNeoFeedWrapper.CloseApproachData>>(); 
	public static string api_key= 'c5miOVYaAWrDmFYfK7X6Hpos3TRWDNa6fRDpgvJJ';// will take form cstm metadataaa
	
    @AuraEnabled
    public static NasaNeoFeedWrapper getdata(string startdate, string enddate){
        string endpoint = 'https://api.nasa.gov/neo/rest/v1/feed?start_date='+startdate+'&end_date='+enddate+'&api_key=' + api_key;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
		req.setTimeout(40000);
        try{

		date test = system.today();
		String cleanDate = test.year() + '-0' + test.month() + '-' + test.day();
		system.debug(cleandate);
		
            Http http = new Http();
            HTTPResponse res = http.send(req);
            amzData = (NasaNeoFeedWrapper) JSON.deserialize(res.getBody(), NasaNeoFeedWrapper.class);
			near_earth_objects = amzdata.near_earth_objects;
			closelist = near_earth_objects.get(cleandate);

            for(NasaNeoFeedWrapper.NeoObject nobject: closelist)
				{
				system.debug('nobject.estimated_diameter ' + nobject.estimated_diameter);
				system.debug('NeoObject.close_approach_data ' + nobject.close_approach_data); //WIP
				//system.debug(nobject.estimated_diameter.estimated_diameter_max);

				}
			
			
			//system.debug('near_earth_objects: '+near_earth_objects);
			//system.debug('closelist: '+closelist);           
            //list<product> amzproductList = amzData.Data.products;
            //System.debug(' amzproductList '+amzproductList);
            return amzData;
        }
        catch(exception e){
		return null;
		}
    }
}