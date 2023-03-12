import { LightningElement, track } from 'lwc';
export default class HelloLwc extends LightningElement {
    @track titulo = 'Ola mundo';
    @track ativo = true;
    @track mundoList = ['mundo1','mundo2','mundo3'];
    
}