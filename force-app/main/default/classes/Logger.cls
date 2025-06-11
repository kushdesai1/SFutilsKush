public class Logger {
    public static Boolean enableLogging;
	    
    public static Boolean isLoggingEnabled() {
        return enableLogging;
    }

    public static void setLoggingEnabled(Boolean isEnabled) {
        enableLogging = isEnabled;
    }

    public static void log(Object value) {
        if (enableLogging) {
            try {
                System.debug(JSON.serializePretty(value)); // For complex objects
            } catch (Exception e) {
                System.debug(String.valueOf(value)); // Fallback for non-serializable objects
            }
        }
    }

    public static void log(SObject record) {
        if (enableLogging) {
            System.debug(
                'SObject Type: ' + record.getSObjectType() + 
                '\nId: ' + record.Id + 
                '\nFields: ' + JSON.serializePretty(record.getPopulatedFieldsAsMap())
            );
        }
    }

    public static void log(String message, Object value) {
        if (enableLogging) {
            log(message + ': ' + JSON.serializePretty(value));
        }
    }
}