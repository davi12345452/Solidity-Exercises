pragma solidity ^0.4.19;

/* Como solidity está em constante tranformações, é fundamental dizer qual versão
estamos usando, isso para evitar futuros problemas, caso a linguagem mude muito a
sintaxe.*/

/*
 Funcionamento deste contrato: o contrato zombie factory possui 3 funções:
 1 - _createZombie: cria objetos do tipo Zombie e armazena-os dentro de um
array chamado zombies
2 - _generateRandomDna: usa comandos random e hash para tranformar uma string
em um número hexadecimal aleatório
3 - _createRandomZombie: cria uma DNA usando o nome do zombie junto da função 2,
assim, ele cria uma zombie com nome e este dna

Há ainda um event, que está dentro da função 1, o qual dispara uma mensagem ao front-
end toda vez que um zombie é adicionado no array. 
 */

contract ZombieFactory {

    /* Eventos são maneiras de avisar ao frontend que algo aconteceu na
    blockchain. Nesse caso, o frontend é avisado quando um Zombie é criado */

    event NewZombie(uint zombieId, string name, uint dna);

    /*
     A declaração de variáveis de estado em solidity pressupõe a
     sua gravação na blockchain. Assim, se executarmos esse código
     dentro da Ethereum, as variáveis ficarão lá armazenadas
     */

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    /*
    Struct são estruturas de dados que possuem mais de uma proprieda
    de. 
     */

    struct Zombie {
        string name;
        uint dna;
    }

    /* Arrays: podem ser fixos ou não, basta definir com tamanho ou
     * nada na declaração. [x] -> tamanho x, [] -> tamanho indefini-
     * do, ou seja, pode aumentar ao longo do contrato. Vale destacar
     * que arrays com tamanho indefinido podem servir de banco de da-
     * dos dentro da blockchain. 

     * Public: permite que outros contrates leiam estes dados do array
     */

    Zombie[] public zombies; //Array público de variáveis de estrutura Zombie

    /* é convenção iniciar os parâmetros com _ antes. */

    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    } 

    /* array.push(x) -> adiciona x ao final do array */

    /* As funções por padrão são públicas em solidity, isso pode ser
    problemático porem. Por isso, recomenda-se que as funções sejam
    setadas como privadas sempre, colocando pública somente quando qui-
    sermos e assim evitar ataques. Outra CONVENÇÃO é usar _ antes do
    nome de funções privadas */

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    /* return: é preciso declarar se a função vai retornar algo e o
     tipo de dado que será. */

    /* pure: funções puras são funções que não mexem com mais nada a
     * não ser os próprios parâmetros, ou seja, nada externo à função
     * view: são funções que não alteram nada, apenas há a visualiza-
     * ção.
     */

    /* keccak256(string) -> função hash que recebe uma string e
    cria um número hexadecimal de 256 bits aleatório. O keccak256
    é uma versão do SHA3, 
     */

    /* Convertendo tipos: convertendo o tipo da variável
    uint b = 10, para converter para uint16, uint16() b_16 = uint16(b)*/

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}