pragma solidity ^0.4.19;

/* Como solidity está em constante tranformações, é fundamental dizer qual versão
estamos usando, isso para evitar futuros problemas, caso a linguagem mude muito a
sintaxe.*/

contract ZombieFactory {

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
     */

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    } 

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}