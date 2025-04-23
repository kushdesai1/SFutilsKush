import { LightningElement, wire, api, track } from 'lwc';
 
export default class MergeFieldPicker extends LightningElement {
  @track result;
  @track amount;
  @track amountarray;
getresult(){
let input1 = this.template.querySelector("[data-id = 'myInput']").value;
let amount1 = this.template.querySelector("[data-id = 'Myamount']").value;
let random = Math.floor(Math.random() * 3);
let randomarray = ['Scisor', 'papper', 'Stone'];
if(input1 == 'Stone'){
  if(random == 0){
    this.result = 'You won';
    this.amount = amount1*2;
    alert('computer\'s choice ' + randomarray[random] +' so you won '+ this.amount);
  }
  else if(random == 1){
    this.result = 'You lost';
    this.amount = amount1*0;
    alert('computer\'s choice ' + randomarray[random] +' so you Lost '+ this.amount);
  }
  else if(random == 2){
    this.result = 'You tied';
    this.amount = amount1;
    alert('computer\'s choice ' + randomarray[random] +' so you Tied '+ this.amount);
  }
}
if(input1 == 'Scisor'){
  if(random == 1){
    this.result = 'You won';
    this.amount = amount1*2;
    alert('computer\'s choice ' + randomarray[random] +' so you won '+ this.amount);
  }
  else if(random == 0){
    this.result = 'You tied';
    this.amount = amount1;
    alert('computer\'s choice ' + randomarray[random] +' so you Tied '+ this.amount);
  }
  else if(random == 2){
    this.result = 'You lost';
    this.amount = amount1*0;
    alert('computer\'s choice ' + randomarray[random] +' so you Lost '+ this.amount);
  }
}
if(input1 == 'Papper'){
  if(random == 1){
    this.result = 'You tied';
    this.amount = amount1;
    alert('computer\'s choice ' + randomarray[random] +' so you Tied '+ this.amount);
  }
  else if(random == 0){
    this.result = 'You lost';
    this.amount = amount1*0;
    alert('computer\'s choice ' + randomarray[random] +' so you Lost '+ this.amount);
  }
  else if(random == 2){
    this.result = 'You Won';
    this.amount = amount1*2;
    alert('computer\'s choice ' + randomarray[random] +' so you won '+ this.amount);
  }
}
 
}
}