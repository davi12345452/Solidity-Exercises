pragma solidity ^0.4.19;



contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    /* Mapping: estrutura para guardar dados, do estilo chave, valor
    facilitando a busca de tal dado. */

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    /* msg.sender: é uma variável que se refere ao address de quem chama a função */

    function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender; //Atribui chave = i, valor = endereço de quem chamou o contrato
        ownerZombieCount[msg.sender]++; //Atribui chave = address, valor = contador
        NewZombie(id, _name, _dna);
    }
 

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

    /* Require: faz a função lançar um erro, caso uma condição não seja atendida.
    Por isso, vamo lancar um erro caso o usuário ja tenha criado um zombie. Fare-
    mos isso com base na carteira, usando o mapping ownerZombieCount, que armaze-
    nou o address mais um contador, toda vez que função _createZombie foi chama-
    da. */

    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender] == 0); //Se o sender ja tiver mintado um nft, ele não poderá criar outro.
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

