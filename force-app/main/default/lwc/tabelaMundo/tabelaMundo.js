import { LightningElement , track} from 'lwc';
import buscarMundoListCls from '@salesforce/apex/mundoController.getMundos';
import { NavigationMixin } from 'lightning/navigation';

export default class TabelaMundo extends NavigationMixin(
    LightningElement
) {
    mundoList = [];
    @track selectAll = false;
    @track showCor = true;
    @track showQtdLua= true;
    @track mostrarTabela= true;
    
    connectedCallback(){
        this.teste();
    }

    teste(){
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

    changeSAll(event){
        this.selectAll = event.target.checked;
        let component = this.template.querySelector('c-tabela-mundo-lista');
        component.selecionarTudo(this.selectAll);
    }

    changeSCor(event){
        this.showCor = event.target.checked;
    }

    schangeSQtdLua(event){
        this.showQtdLua = event.target.checked;
    }
}