/* Herança: funciona da mesma maneira que js, filho herda do pai, podendo passar as funções do pai 
 * poderíamos usar o mesmo arquivo de antes, porém vamos importar o contrato. O import funciona pare
 * cido com JS
 */
 
pragma solidity ^0.4.19;

import "./zombieFactory.sol";

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kittyContract = KittyInterface(ckAddress);

/* Storage: variáveis guardadas na blockchain = HD
 * Memory: variáveis temporárias = Memória RAM
 * Normalmente não precisamos declarar isso, pois variáveis fora de funções são storage
 * e as dentro de funções, memory, isso por padrão. Porém haverá situações que será pre-
 * ciso declarar que tipo de variável é.
 */
    function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {
        require(msg.sender == zombieToOwner[_zombieId]); //Verifica se o sender é o dono do zombie
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus; //Limita o tamanho do DNA a 16 digitos, os 16 últimos
        uint newDna = (myZombie.dna + _targetDna) / 2; //Novo dna é a media do atacante e do atacado
        _createZombie("NoName", newDna); //Chama o create zombie com o novo dna
        if (keccak256(_species) == keccak256("kitty")) {
        newDna = newDna - newDna % 100 + 99;
        }
        //Gera ERRO, _createZombie é private, só pode ser chamado pelo próprio contrato.
    }

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        // E modifique a função aqui:
        feedAndMultiply(_zombieId, kittyDna, "kitty");
  }


/* External: funções externas só podem ser executadas fora do contrato onde foram definidas
 * Internal: funções internas podem ser executadas no própria contrato e nos que foram herda
 * dados, basicamente o que diferencia ela da função private
 */

}