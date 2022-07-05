pragma solidity ^0.4.19;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  uint levelUpFee = 0.001 ether; //Taxa para aumentar o level pagando

  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }

  /* Função que tranfere o dinheiro do address do contrato para o address
  do criador do contrato, somente o owner pode chamar */

  function withdraw() external onlyOwner {
    owner.transfer(this.balance);
  }

  /* Função que permite somente o owner a alterar o fee do contrato */

  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

  /* Nessa função levelUp, a entrada é o id do zombie, sendo que é payable,
   * assim, se o executor da função mandar o fee para msg, no caso o address
   * do contrato, a função aumenta o level do zombie. Depois precisamos fa-
   * zer uma função que envie os ethers do contrato para um endereço.
   */

  function levelUp(uint _zombieId) external payable {
    require(msg.value == levelUpFee);
    zombies[_zombieId].level++;
  }

  function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) ownerOf(_zombieId) {
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) ownerOf(_zombieId) {
    zombies[_zombieId].dna = _newDna;
  }

  function getZombiesByOwner(address _owner) external view returns(uint[]) {
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < zombies.length; i++) {
      if (zombieToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}
