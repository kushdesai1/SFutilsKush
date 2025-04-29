public class describeee {
    public static void info(String objectName) {
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        //trying git
        if (objType == null) {
            System.debug('Invalid object name: ' + objectName);
            return;
        }

        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        
        
        Map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap();


        for (String fieldName : fieldMap.keySet()) {
            Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldName).getDescribe();
            
            System.debug('Field Name: ' + fieldName);
           // System.debug('  Label: ' + fieldDescribe.getLabel());
            System.debug('  Type: ' + fieldDescribe.getType());
           /* System.debug('  Length: ' + fieldDescribe.getLength());
            System.debug('  Precision: ' + fieldDescribe.getPrecision());
            System.debug('  Scale: ' + fieldDescribe.getScale());
            System.debug('  Is Required: ' + !fieldDescribe.isNillable());
            System.debug('  Is Auto Number: ' + fieldDescribe.isAutoNumber());
            System.debug('  Is Unique: ' + fieldDescribe.isUnique());
            System.debug('  Is Createable: ' + fieldDescribe.isCreateable());
            System.debug('  Is Updateable: ' + fieldDescribe.isUpdateable());
            System.debug('  Is Accessible: ' + fieldDescribe.isAccessible());
            System.debug('  Is External Id: ' + fieldDescribe.isExternalId());
            System.debug('  Is Name Field: ' + fieldDescribe.isNameField());
            System.debug('  Is Filterable: ' + fieldDescribe.isFilterable());
            System.debug('  Is Sortable: ' + fieldDescribe.isSortable());*/

            
            if (fieldDescribe.getType() == Schema.DisplayType.Picklist) {
                List<Schema.PicklistEntry> picklistValues = fieldDescribe.getPicklistValues();
                List<String> picklistLabels = new List<String>();
                for (Schema.PicklistEntry entry : picklistValues) {
                    picklistLabels.add(entry.getLabel());
                }
                System.debug('  Picklist Values: ' + picklistLabels);
            }
        }
    }
}