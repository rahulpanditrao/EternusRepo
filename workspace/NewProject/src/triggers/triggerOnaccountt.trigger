trigger triggerOnaccountt on Account (after delete, after insert, after undelete, after update, before delete, before insert, before update) {

    if(trigger.isBefore && trigger.isUpdate)
 {
  System.debug('This trigger is to be executed before update(new):'+trigger.new);
  System.debug('This trigger is to be executed before update(newmap):'+trigger.newmap);
  System.debug('This trigger is to be executed before update(old):'+trigger.old);
  System.debug('This trigger is to be executed before update(oldmap):'+trigger.oldmap);
 }
 
 if(trigger.isAfter && trigger.isUpdate)
 {
  System.debug('This trigger is to be executed after update(new):'+trigger.new);
  System.debug('This trigger is to be executed after update(newmap):'+trigger.newmap);
  System.debug('This trigger is to be executed after update(old):'+trigger.old);
  System.debug('This trigger is to be executed after update(oldmap):'+trigger.oldmap);
 }
 
 if(trigger.isBefore && trigger.isInsert)
 {
  System.debug('This trigger is to be executed before insert(new):'+trigger.new);
  System.debug('This trigger is to be executed before insert(newmap):'+trigger.newmap);
 }
 if(trigger.isAfter && trigger.isInsert)
 {
  System.debug('This trigger is to be executed after insert(new):'+trigger.new);
  System.debug('This trigger is to be executed after insert(newmap):'+trigger.newmap);
 }
 
 if(trigger.isBefore && trigger.isDelete)
 {
  System.debug('This trigger is to be executed before delete(old):'+trigger.old);
  System.debug('This trigger is to be executed before delete(oldmap):'+trigger.oldmap);
 }
 
 if(trigger.isAfter && trigger.isDelete)
 {
  System.debug('This trigger is to be executed after delete(old):'+trigger.old);
  System.debug('This trigger is to be executed after delete(oldmap):'+trigger.oldmap);
 }
 
 if(trigger.isAfter && trigger.isUndelete)
 {
  System.debug('This trigger is to be executed after Undelete(new):'+trigger.new);
  System.debug('This trigger is to be executed after Undelete(newmap):'+trigger.newmap);
 }

    }