public with sharing class NasaAstoroid {
	public static Map<String, List<NasaNeoFeedWrapper.NeoObject>> near_earth_objects;
	public static list<NasaNeoFeedWrapper.NeoObject> closelist;
	public static NasaNeoFeedWrapper amzData;
	public NasaNeoFeedWrapper.CloseApproachData closedata;
	public static map<decimal, List<NasaNeoFeedWrapper.CloseApproachData>> finalmap = new map<decimal, List<NasaNeoFeedWrapper.CloseApproachData>>(); 
	public static string api_key= 'c5miOVYaAWrDmFYfK7X6Hpos3TRWDNa6fRDpgvJJ';// will take form cstm metadataaa
	public static list<Finalwrapper> finallist = new list<Finalwrapper>();
	
    @AuraEnabled
    public static list<Finalwrapper> getdata(string startdate, string enddate){
        string endpoint = 'https://api.nasa.gov/neo/rest/v1/feed?start_date='+startdate+'&end_date='+enddate+'&api_key=' + api_key;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
		req.setTimeout(40000);

		date test = system.today();
		String cleanDate = test.year() + '-0' + test.month() + '-' + test.day();
		system.debug(cleandate);

        try{
            Http http = new Http();
            HTTPResponse res = http.send(req);
            amzData = (NasaNeoFeedWrapper) JSON.deserialize(res.getBody(), NasaNeoFeedWrapper.class);
			near_earth_objects = amzdata.near_earth_objects;
			closelist = near_earth_objects.get(cleandate);
			system.debug(closelist.size());
            for(NasaNeoFeedWrapper.NeoObject nobject: closelist)
				{
				Finalwrapper toadd = new Finalwrapper();
				toadd.estimateddiameter = nobject.estimated_diameter.kilometers.estimated_diameter_max; 				
				for (NasaNeoFeedWrapper.CloseApproachData cad : nobject.close_approach_data) {
							toadd.fulldate = cad.close_approach_date_full;
							toadd.rvelo = cad.relative_velocity.kilometers_per_hour;
							toadd.orbitingBody = cad.orbiting_body;
                        }
				system.debug(toadd);
				finallist.add(toadd);
				}
			system.debug(finallist);
            return finallist;
        }
        catch(exception e){
		system.debug('Exceptiom msg: ' + e);
		return null;
		}
    }
    public class Finalwrapper{
        public decimal estimateddiameter;
        public string fulldate;
        public string rvelo;
        public string orbitingBody;
} 
}