public with sharing class DemoLWCController {
    public DemoLWCController() {

    }

    @AuraEnabled
    public static Boolean savePerson(String name, Integer age) {
        try {
            if (String.isBlank(name)) {
                throw new AuraHandledException('Name cannot be blank');
            }
            if (age == null || age <= 0) {
                throw new AuraHandledException('Age must be a positive number');
            }

            // Create the Person record
            Person__c newPerson = new Person__c();
            newPerson.Name = name;
            newPerson.Age__c = age; // Assuming `Age__c` is a custom field in Person__c object.
            insert newPerson;

            return true;
        } catch (AuraHandledException e) {
            throw new AuraHandledException(e.getMessage());
        } catch (Exception e) {
            // Return generic error if not handled explicitly
            throw new AuraHandledException('An unexpected error occurred: ' + e.getMessage());
        }
    }
}