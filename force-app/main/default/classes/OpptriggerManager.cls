public class OpptriggerManager {

	    public static void createAndExecuteHandler(Type t) {
        
        if((!Test.isRunningTest())){
          		Object ox = t.newInstance();
                opphandler handler = (opphandler)ox;
				handler.bulkAfter(); 
      
        }
    
        }
    }