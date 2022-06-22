// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;
//SIMPLE STORAGE
/*
Esse comando fará com que o programa utilize todas versões do
solidity entre 0.6.0 e 0.9.0. Caso queiramos utilizar uma 
versão específica, basta colocar: pragma solidity ^[version]
Como Solidity está em constante construção, é normal por agora
a constante troca de versões;
*/

contract FirstContract {
/*
contract é a definição do smart contract, funciona como uma
classe em linguagens orientadas a objeto
*/
    uint256 favorite_number; //Começa com valor 0, já que em um array seria o posição 0
    bool favorite_bool; //Começa com valor 1, já que em um array seria o posição 1

    struct People { //Structs são usados para definir tipos, assim como int, string....
        uint256 favorite_number;
        string name;
    }

    mapping(string => uint256) public nameToFavoriteNumber; //Dicionário, key = string, value = uint256

    People[] public people; //Dentro dos [] podemos definir o tamanho do array. Quando está vazio, podemos adicionar infinitamente

    function store(uint256 _favorite_number) public{
        favorite_number = _favorite_number;
    }
    /*
    O que essa função está fazendo, nada mais é que pegando a variável do contrato e atribuindo
    o valor passado à função à ela. Por exemplo, se chamássemos store(23), favorite_number seria
    igual a 23
    */
    function retornar() public view returns(uint256){
        return favorite_number;
    }

    /*
    Existe a função view e pure. A primeira, possibilita apenas a visualização de dados na blockchain,
    enquanto a segunda permite operações matemáticas, porém sem retornar nada que mude a blockchain.
    */

    function add_person(string memory _name, uint256 _favorite_number) public {
        people.push(People(_favorite_number, _name)); // Comando push add variável ao array
        nameToFavoriteNumber[_name] = _favorite_number; 
    }
}

