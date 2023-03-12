// JAVASCRIPT

import { LightningElement, track } from 'lwc';
import salvarMundoCls from '@salesforce/apex/mundoController.setMundos';
import buscarMundoListCls from '@salesforce/apex/mundoController.getMundos';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class CriarMundo extends NavigationMixin(
    LightningElement
) {

    @track mundo = {
        nome:'',
        cor:'',
        distanciaSol: 0,
        posssuiAgua: false, 
        qtdLua: 0,
        tamanho:0,
        selecionado: false, 
    } 

    idRegistro;
    recordPageUrl; 

    mundoList = [];
    @track mostrarTabela = false; 
    @track mostrarTamanho = false; 
    @track mostrarCor = false;


    connectedCallback(){
        this.buscarMundo();
        console.log("tamenhoF = "+ this.mundoList.length);
    }
    
    
    handleInput(event){
        let idComponente = event.currentTarget.dataset.teste;
        
        if(idComponente == 'nome'){
            this.mundo.nome = event.target.value; 
        } else if(idComponente == 'cor'){
            this.mundo.cor = event.target.value; 
        } else if(idComponente == 'pAgua'){
            this.mundo.pAgua = event.target.checked; 
        } else if(idComponente == 'quantLuas'){
            this.mundo.quantLuas = event.target.value; 
        } else if(idComponente == 'tamanho'){
            this.mundo.tamanho = event.target.value; 
        } else if(idComponente == 'mostrarTamanho'){
            if(event.target.checked){
                this.mostrarTamanho = true; 
            } else {
                this.mostrarTamanho = false; 
            }
        } else if(idComponente == 'mostrarCor'){
            if(event.target.checked){
                this.mostrarCor = true; 
            } else {
                this.mostrarCor = false; 
            } 
        } else if(idComponente == 'quantLuas'){
            let componente = this.template.querySelector('c-criar-mundo-table');
            if(event.target.checked){
                componente.mostrarDistanciaSolFunction(true);
            } else {
                componente.mostrarDistanciaSolFunction(false);
            } 
        } else if(idComponente == 'selecionarTudo'){
            let componente = this.template.querySelector('c-criar-mundo-table');
            if(event.target.checked){
                componente.selecionarTudo(true);
            } else {
                componente.selecionarTudo(false);
            } 
        }
    }

    salvarMundo(){
        salvarMundoCls({mundoTO: this.mundo})
        .then(result => {
            this.showToast('success', 'Sucesso', result.Name + 'criado com sucesso !', 'dismissable');
            this.idRegistro = result.Id; 
            this.goToRecordPage();
        })
        .catch(error => {
            this.showToast('error', 'Erro', 'Deu ruim...', 'dismissable');
            console.error('Vish, aconteceu um erro: ' + error)
        });
    }

    buscarMundo(){
        console.log("Call Callback In Father");
        buscarMundoListCls({})
        .then(result => {
            this.mundoList = result;
            console.log("Callback In Father Atribuição  = "+ this.mundoList.length);
            if(this.mundoList.length > 0 ){
                this.mostrarTabela = true; 
            }
        })
        .catch(error => {
            this.showToast('error', 'Erro', 'Deu ruim...', 'dismissable');
            console.error('Vish, aconteceu um erro: ' + error)
        });
    }

    showToast(type, title, message, mode) {
        const event = new ShowToastEvent({
            variant: type,
            title: title,
            message: message,
            mode: mode
        });
        this.dispatchEvent(event);
    }

    goToRecordPage() {
        // Generate a URL to a User record page
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.idRegistro,
                //objectApiName: 'Case', // objectApiName is optional
                actionName: 'view'
            }
        });
    }  

    receberItemSelecionado(event){
        alert(event.detail);
    }
}