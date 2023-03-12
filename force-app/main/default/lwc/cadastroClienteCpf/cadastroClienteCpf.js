import { LightningElement } from 'lwc';

export default class CadastroClienteCpf extends LightningElement {

    onSon(event){
        const setcpfEvent = new CustomEvent("setcpf",{
            detail:event.target.dataset.cpf,
            
        })
        this.dispatchEvent(setcpfEvent);
    }

    
}