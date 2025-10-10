public interface ITriggerHandler {
void afterInsert(SObject so);
void bulkafter();
void afterUpdate(SObject so);

}