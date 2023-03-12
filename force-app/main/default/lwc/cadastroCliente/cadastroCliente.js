import { LightningElement, track} from 'lwc';
import inserirClienteCls from '@salesforce/apex/ClienteController.inserirCliente';

export default class cadastroCliente extends LightningElement {
    @track cliente = {
        nome: '',
        cnpj: '',
        cpf: '',
        recordType: ''
    }
    @track cliPjBool = false;
    @track cliPfBool = false;

    get options() {
        return [
            { label: 'Pessoa Juridica', value: 'Pj' },
            { label: 'Pessoa Fisica', value: 'Pf' },
        ];
    }


    onHandler(event){
        let idComponente = event.target.dataset.id;
        console.log('In cpf');
        console.log(event.target.dataset);
        console.log(event.target.value);
        console.log('In Handdle');
        if (idComponente == 'nome') {
            this.cliente.nome = event.target.value; 
        }
        if (idComponente == 'cnpj') {
            this.cliente.cnpj = event.target.value;
        }
        if (idComponente == 'cpf') {
            let cliente =  this.template.querySelector('c-cadastro-cliente-cpf');
            this.cliente.cpf = cliente.cpf ;
        }
        if (idComponente == 'recordType') {
            this.cliente.recordType = event.target.value;
            if(event.target.value == 'Pj'){
                this.cliPjBool = true;
                this.cliPfBool = false;
            }else if(event.target.value == 'Pf'){
                this.cliPjBool = false;
                this.cliPfBool = true;
            }
        }
    }
    inserirCliente(){
        inserirClienteCls({clienteTo: this.cliente})
        .then(result => {
            alert('success');
        })
        .catch(error => {
            alert('Falhou');
        });
    }

}