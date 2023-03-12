public with sharing class Estacionamento {
    public List<Carro> lstCarro = new List<Carro>();


    public void adicionarCarros(String marca, String cor, Integer anoFab, String placa) {
        Carro novoCarro = new Carro(anoFab); 
        novoCarro.cor=cor;
        novoCarro.marca=marca;
        novoCarro.placa=placa;

        lstCarro.add(novoCarro);
    }

    public void listarCarro() { 
        for(Carro carro : lstCarro){
            system.debug(carro);
        }
    }


    public void listarCarro(String placa) {
        Integer contador =0;
        for(Carro carro : lstCarro){
            if(carro.placa == placa){
                lstCarro.remove(contador);
            }
            contador++;
        } 
    }

}