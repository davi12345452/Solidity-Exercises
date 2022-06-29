/* Herança: funciona da mesma maneira que js, filho herda do pai, podendo passar as funções do pai 
 * poderíamos usar o mesmo arquivo de antes, porém vamos importar o contrato. O import funciona pare
 * cido com JS
 */
 
pragma solidity ^0.4.19;

import "./zombieFactory.sol";

contract ZombieFeeding is ZombieFactory {

/* Storage: variáveis guardadas na blockchain = HD
 * Memory: variáveis temporárias = Memória RAM
 * Normalmente não precisamos declarar isso, pois variáveis fora de funções são storage
 * e as dentro de funções, memory, isso por padrão. Porém haverá situações que será pre-
 * ciso declarar que tipo de variável é.
 */
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]); //Verifica se o sender é o dono do zombie
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus; //Limita o tamanho do DNA a 16 digitos, os 16 últimos
        uint newDna = (myZombie.dna + _targetDna) / 2; //Novo dna é a media do atacante e do atacado
        _createZombie("NoName", newDna); //Chama o create zombie com o novo dna
        //Gera ERRO, _createZombie é private, só pode ser chamado pelo próprio contrato.
    }

}