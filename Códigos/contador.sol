// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/*Nesse contrato pegamos 2 funções, uma que insere um valor à variável
  contador, e outra que simplesmente retorna este valor. */

contract PrimeiroContador {

    uint contador;

    function setContador(uint _count) public {
        contador = _count;
    }

    function viewContador() public view returns(uint) {
        return contador;
    }

}