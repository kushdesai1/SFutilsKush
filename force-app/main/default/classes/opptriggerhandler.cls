public class opptriggerhandler extends opphandler {
    public override void bulkAfter() {

    }

    public override void afterInsert(SObject so) {
     
    }
    public override void afterUpdate(SObject so) {
     
    }

    public static map<id, string> getmaterialnumber(list<product2> products){
        map<id, string> matnumbers = new map<id, string>();
        for(product2 p : products){
            matnumbers.add(p.id, p.SAP_Material_Number__c);
        }
        return matnumbers;
    }

}