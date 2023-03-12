public abstract class Conta_Bancaria {
    public Integer agenciaDeConta{get;set;}
    public Integer numeroDeConta{get;set;}
    public Double saldo{get;set;}
    public String tipoDeConta{get;set;}

    public String saque(Integer valor){
        If(valor > saldo){
            return ('não foi possivel sacar');
        }else{
            this.saldo = saldo - valor;
            return ('Voce sacou = R$' + valor);
        }
    }
}