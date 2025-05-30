import { LightningElement, track } from 'lwc';
import verifyRecaptcha from '@salesforce/apex/RecaptchaController.createCase';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
 
export default class ContactSupportFormReCaptcha extends LightningElement {
    @track email = '';
    @track subject = '';
    @track description = '';
    @track isLoading = false;
    @track feedbackMessage = '';
 
    handleInputChange(event) {
        const field = event.target.name;
        if (field === 'email') {
            this.email = event.target.value;
        } else if (field === 'subject') {
            this.subject = event.target.value;
        } else if (field === 'description') {
            this.description = event.target.value;
        }
    }
 
    connectedCallback() {
        document.addEventListener("grecaptchaVerified", (e) => {
            this.isLoading = true;
            const caseRecord = {
                sobjectType: 'Case',
                SuppliedEmail: this.email,
                Subject: this.subject,
                Description: this.description,
                RecordTypeId: '012Ts000001iUmcIAE'
            };
            //console.log(e.detail.response);
            // In connectedCallback():
      verifyRecaptcha({
          caseRecord: caseRecord,
          recaptchaResponse: e.detail.response
      })
      .then((result) => {
          this.isLoading = false;
          document.dispatchEvent(new Event("grecaptchaReset"));
 
          if (result) { // Case ID is returned
              this.showNotification('Success', 'Ticket created successfully.', 'success');
          } else {
              this.showNotification('Error', 'Failed to create ticket.', 'error');
          }
      })
      .catch((error) => {
          this.isLoading = false;
          this.showNotification('Error on controller', error.body.message, 'error');
      });
 
        });
    }
    renderedCallback() {
        const divElement = this.template.querySelector('div.recaptchaInvisible');
        const payload = { element: divElement, badge: 'bottomright' };
        document.dispatchEvent(new CustomEvent("grecaptchaRender", { detail: payload }));
    }
 
    handleSubmit(event) {
        event.preventDefault();
        document.dispatchEvent(new Event("grecaptchaExecute"));
       
    }
 
    showNotification(title, message, variant) {
        const evt = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(evt);
    }
}