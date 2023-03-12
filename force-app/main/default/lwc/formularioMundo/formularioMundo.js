import { LightningElement, track} from 'lwc';
//import getMundos from '@salesforce/apex/mundoController.getMundos';
import setMundosCls from '@salesforce/apex/mundoController.setMundos';
import setMundosv2Cls from '@salesforce/apex/mundoController.setMundosV2';

export default class FormularioMundo extends LightningElement {
    //variaveis
    @track nome;
    @track cor;
    @track pAgua;
    @track quantLuas;
    @track tamanho;
    get options() {
        return [
            { label: 'Sim', value: 'Sim' },
            { label: 'Não', value: 'Não' },
        ];
    }
    @track mundoTo = {
        nome: '',
        cor: '',
        pAgua: 0,
        quantLuas: '',
        tamanho: 0,
    }

    onEscreveNome(event) {
        this.mundoTo.nome = event.target.value;
        this.nome = event.target.value;
    }
    onEscreveCor(event) {
        this.mundoTo.cor = event.target.value;
        this.cor = event.target.value;
    }
    onEscrevePAgua(event) {
        this.mundoTo.pAgua = event.target.value;
        this.pAgua = event.target.value;
    }
    onEscreveQuantLuas(event) {
        this.mundoTo.quantLuas = event.target.value;
        this.quantLuas = event.target.value;
    }
    onEscreveTamanho(event) {
        this.mundoTo.tamanho = event.target.value;
        this.tamanho = event.target.value;
    }

    onHandler(event){
        let idComponente = event.target.dataset.id;
        if (idComponente == 'nome') {
            this.mundoTo.nome = event.target.value;
        }
        if (idComponente == 'cor') {
            this.mundoTo.cor = event.target.value;
        }
        if (idComponente == 'pAgua') {
            this.mundoTo.pAgua = event.target.value;
        }
        if (idComponente == 'quantLuas') {
            this.mundoTo.quantLuas = event.target.value;
        }
        if (idComponente == 'tamanho') {
            this.mundoTo.tamanho = event.target.value;
        }
    }

    insertMundo(){
        setMundosCls({mundoTo: this.mundoTo})
                .then(result => {
                    alert('success');

                })
                .catch(error => {
                    alert('Falhou');
                });
    }

    insertMundoV2(){
        setMundosv2Cls({nome: this.nome,
            cor: this.cor,
            pAgua: this.pAgua,
            quantLuas: this.quantLuas,
            tamanho: this.tamanho})
                .then(result => {
                    alert('success');

                })
                .catch(error => {
                    alert('Falhou');
                });
    }
}