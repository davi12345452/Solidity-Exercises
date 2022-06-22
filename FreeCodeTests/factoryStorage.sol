// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

import "./simpleStorage.sol";

//STORAGE FACTORY

contract SecondContract {
    // If I use the command "is" after "FirstContract", like this:
    // "contract SecondContract is FirstContract{", I will import
    // everything that FirstContract contains  

    FirstContract[] public SimpleStorageArray;

    //First we gonna create a new function that import the contract created in teste.sol
    function create_simple_storage() public {
        FirstContract SimpleStorage = new FirstContract(); //Imports the contract FirstContract with name SimpleStorage
        SimpleStorageArray.push(SimpleStorage);
    }

    //Now, we gonna import Store and Retornar functions from FirstContract using a new function
    function FirstStore(uint256 _SimpleStorageIndex, uint256 _SimpleStorageNumber) public {
        FirstContract(address(SimpleStorageArray[_SimpleStorageIndex])).store(_SimpleStorageNumber);
    }

    //This function will return the favorite number using the index 
    function FirstGet(uint256 _SimpleStorageIndex) public view returns(uint256) {
        return FirstContract(address(SimpleStorageArray[_SimpleStorageIndex])).retornar();
        
    }
}

/*
Portugueses comments:
Se eu usar o seguinte comando na definição dos contratos: contract SecondContract is FirstContract{
todas as variáveis e funçoes definidas no primeiros serão importadas para dentro da segunda classe,
ou seja, eu não precisaria ficar usando o FirsContract() quando quisesse chamar uma função definida
no seu arquivo, bastaria apenas chamar normalmente a função, como se ele estivesse definida ali a 
cima
*/
