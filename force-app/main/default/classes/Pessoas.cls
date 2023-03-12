public with sharing class Pessoas {
    public List<Pessoa> lstPessoas = new List<Pessoa>();
    public Pessoas() {
        for(Integer i=0;i<10;i++){
            Pessoa pessoa = new Pessoa('Joao '+i, date.parse('4/05/'+(2000+i)));
            lstPessoas.add(pessoa);
        }
    }
    public void lstPessoaToString(){
        for (Pessoa pessoa: lstPessoas){
            system.debug(pessoa);
        }
    }
    public Pessoa maisVelho(){
        Pessoa maisVelho = lstPessoas[0];
        for (Pessoa pessoa : lstPessoas) {
            if(maisVelho.dataDeNascimento < pessoa.dataDeNascimento){
                maisVelho = pessoa;
            }
        }
        return maisVelho;
    }
    public Pessoa maisNovo(){
        Pessoa maisNovo = lstPessoas[0];
        for (Pessoa pessoa : lstPessoas) {
            if(maisNovo.dataDeNascimento > pessoa.dataDeNascimento){
                maisNovo = pessoa;
            }
        }
        return maisNovo;
    }

}