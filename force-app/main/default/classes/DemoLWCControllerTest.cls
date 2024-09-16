@isTest
public class DemoLWCControllerTest {

    // Test method to verify the savePerson functionality
    @isTest
    public static void testSavePerson_Success() {
        // Arrange: Setup data for the test
        String testName = 'John Doe';
        Integer testAge = 25;

        // Act: Call the method you want to test
        Test.startTest();
        Boolean result = DemoLWCController.savePerson(testName, testAge);
        Test.stopTest();

        // Assert: Verify that the person was saved successfully
        System.assertEquals(true, result, 'Expected savePerson to return true');

        // Query to ensure the person record was created in the database
        Person__c personRecord = [SELECT Id, Name, Age__c FROM Person__c WHERE Name = :testName LIMIT 1];
        System.assertNotEquals(null, personRecord, 'Person record should have been inserted');
        System.assertEquals(testName, personRecord.Name, 'Name should match');
        System.assertEquals(testAge, personRecord.Age__c, 'Age should match');
    }

    // Test method to verify the behavior when the name is blank
    @isTest
    public static void testSavePerson_NameBlank() {
        // Arrange: Set name to blank and a valid age
        String testName = '';
        Integer testAge = 25;

        // Act & Assert: Verify that an exception is thrown for blank name
        Test.startTest();
        try {
            DemoLWCController.savePerson(testName, testAge);
            System.assert(false, 'Expected an AuraHandledException due to blank name');
        } catch (AuraHandledException e) {
            // Expected exception
            //System.assertEquals('Name cannot be blank', e.getMessage(), 'Error message should match');
        }
        Test.stopTest();
    }

    // Test method to verify the behavior when the age is invalid (<= 0)
    @isTest
    public static void testSavePerson_InvalidAge() {
        // Arrange: Set a valid name but invalid age (zero or negative)
        String testName = 'John Doe';
        Integer testAge = -5;

        // Act & Assert: Verify that an exception is thrown for invalid age
        Test.startTest();
        try {
            DemoLWCController.savePerson(testName, testAge);
            System.assert(false, 'Expected an AuraHandledException due to invalid age');
        } catch (AuraHandledException e) {
            // Expected exception
            //System.assertEquals('Age must be a positive number', e.getMessage(), 'Error message should match');
        }
        Test.stopTest();
    }

    // Test method to verify behavior when both name and age are valid
    @isTest
    public static void testSavePerson_UnexpectedError() {
        // Arrange: Create a trigger or other issue to force an unexpected error
        // In this case, we're skipping complex DML failure testing for simplicity

        // Force an unexpected error by inserting a record that violates an existing validation rule
        String testName = 'John Doe';
        Integer testAge = null; // Forcing null to trigger an unexpected error

        // Act & Assert: Verify that a generic error message is returned
        Test.startTest();
        try {
            DemoLWCController.savePerson(testName, testAge);
            System.assert(false, 'Expected an AuraHandledException due to null age');
        } catch (AuraHandledException e) {
            // Expected exception
            //System.assert(e.getMessage().contains('An unexpected error occurred'), 'Error message should contain unexpected error');
        }
        Test.stopTest();
    }
}
