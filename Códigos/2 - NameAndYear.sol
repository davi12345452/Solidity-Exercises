// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/*Esse contrato recebe uma string e um number, que seriam nome e idade respectivamente, salva-os
  dentro de um array e um mapping público, estando disponível para consulta.*/

contract SegundoNameAndYears {

    struct NameAndYears {
        string name;
        uint32 year;
    }

   NameAndYears[] public arrayNameAndYears;
   mapping(string => uint32) public viewYearsByName;

    function setNameAndYears(string memory _name, uint32 _years) public {
       arrayNameAndYears.push(NameAndYears(_name, _years));
       viewYearsByName[_name] = _years;
    }

}