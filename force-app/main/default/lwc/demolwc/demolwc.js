import { LightningElement } from 'lwc';
import savePerson from '@salesforce/apex/DemoLWCController.savePerson'; // Import Apex method
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Demolwc extends LightningElement {
    name = '';
    age = '';
    showSuccessMessage = false;
    showErrorMessage = false;
    errorMessage = '';

    // Handle name input change
    handleNameChange(event) {
        this.name = event.target.value;
    }

    // Handle age input change
    handleAgeChange(event) {
        this.age = event.target.value;
    }

    // Handle form submission
    handleSubmit() {
        if (this.name && this.age) {
            // Call Apex method
            savePerson({ name: this.name, age: parseInt(this.age, 10) })
                .then(() => {
                    this.showSuccessMessage = true;
                    this.showErrorMessage = false;
                })
                .catch(error => {
                    this.errorMessage = error.body.message;
                    this.showErrorMessage = true;
                    this.showSuccessMessage = false;
                });
        }
    }

    handleSuccess() {
        const evt = new ShowToastEvent({
            title: "Success",
            message: "Person saved successfully!",
            variant: "success",
        });
        this.dispatchEvent(evt);
    }

    handleError(error) {
        const evt = new ShowToastEvent({
            title: "Error",
            message: error.body.message,
            variant: "error",
        });
        this.dispatchEvent(evt);
    }
}
