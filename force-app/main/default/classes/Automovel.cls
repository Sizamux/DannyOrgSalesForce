public abstract class Automovel {
    public Integer anoFabricacao  {get; set;}
    public String marca  {get; set;}
    public String cor  {get; set;}
    public String placa  {get; set;}

    public Integer obterIdadeUso(){
        return Datetime.now().year() - anoFabricacao;
    }

    public String obterIdadeUsoToString(){
        return ('idade de uso:' + obterIdadeUso());
    }
}