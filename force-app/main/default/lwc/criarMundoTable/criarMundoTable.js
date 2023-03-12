import { LightningElement, api, track } from 'lwc';

export default class CriarMundoTable extends LightningElement {
    @api mundoListExternal;
    @track mundoList = [];  
    @api mostrarTamanho;
    @api mostrarCor; 

    @track mostrarDistanciaSol = false; 

    connectedCallback(){
        console.log("Call Callback In Child");
  
        this.mundoListExternal.forEach(item => {
            let itemClonado = {...item};
            this.mundoList.push(itemClonado);
            console.log("item = "+ item.id);
        });
    }

    @api mostrarDistanciaSolFunction(boolean){
        if(boolean){
            this.mostrarDistanciaSol = true;
        } else {
            this.mostrarDistanciaSol = false;
        }
    } 

    @api selecionarTudo(boolean){
        if(boolean){
            this.mundoList.forEach(item => {
                item.possuiAgua = true; 
            });
        } else {
            this.mundoList.forEach(item => {
                item.possuiAgua = false; 
            });
        }
    }

    selecionarMundo(event){
        if(event.target.checked){
            const selecionarMundoEvent = new CustomEvent("selecionarmundo",{
                detail:event.target.dataset.nome
            })
            this.dispatchEvent(selecionarMundoEvent);
        }
    }
}