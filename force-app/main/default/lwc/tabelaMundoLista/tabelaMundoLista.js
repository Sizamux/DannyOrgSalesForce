import { LightningElement , api, track} from 'lwc';
import removerMundoListCls from '@salesforce/apex/mundoController.deleteMundos';

export default class TabelaMundoLista extends LightningElement {
    //Lista TO
    @api mundoListExternal;
    @track mundoList = []
    //esconder Colunas
    @api selectAllRecieved;
    @api mostrarTabelaRecieved;
    @api showCorRecieved;
    @api showQtdLuaRecieved;
    @track checkBoxValue;
    
    connectedCallback(){
        console.log("Call Callback In Child"); 
        this.mundoListExternal.forEach(item => {
            let itemClonado = {...item};
            this.mundoList.push(itemClonado);
            console.log("item = "+ item.id);
        });
    }
    deletarMundo(event){
        let id = event.target.value;
        removerMundoListCls({id})
        .then(result => {
           
        })
        .catch(error => {

        });
    }

}