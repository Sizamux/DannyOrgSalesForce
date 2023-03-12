import { LightningElement , track} from 'lwc';

export default class FormularioRealm extends LightningElement {
    //variaveis
    @track nome;
    @track LeisAplicaveis;
    @track racas;
    @track temperatura;
    @track agua;
    get options() {
        return [
            { label: 'Quente', value: 'Quente' },
            { label: 'Regular', value: 'Regular' },
            { label: 'Frio', value: 'Frio' },
        ];
    }

    handleChange(event) {
        this.temperatura = event.detail.value;
    }

    //exe
    @track exibir=false;

    onExibirInfoClick(event) {
        this.clickedButtonLabel = event.target.label;
        this.exibir = true;
    }
    onLimparClick(event) {
        this.clickedButtonLabel = event.target.label;
        this.exibir = false;
    }
    onEscreveNome(event) {
        this.nome = event.target.value;
    }
    onEscreveLeisAplicaveis(event) {
        this.LeisAplicaveis = event.target.value;
    }
    onEscreveRacas(event) {
        this.racas = event.target.value;
    }
    onEscreveAgua(event) {
        this.agua = event.target.value;
    }

    //onHandler(event) {

    //}

}