public class PTTriggerManager {

	    public static void createAndExecuteHandler(Type t) {
        
        if((!Test.isRunningTest())){
          		Object ox = t.newInstance();
                PtEventHandler handler = (PtEventHandler)ox;
				handler.bulkAfter(); 
      
        }
    
        }
}