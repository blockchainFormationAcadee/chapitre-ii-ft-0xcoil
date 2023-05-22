// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;


contract Payable{
    address payable public owner;

//Créez un constructeur avec comme attribut payable.
//Dans le constructor le msg.sender doit aussi être payable puisque qu'il provient d'un contrat payable.
    constructor ()payable {
        owner= payable(msg.sender);
    }
// Envoyez des ethers dès que vous créez votre smart contract.

    function deposit() external payable{}

// Obtenir la balance dans le contrat. 

    function getBalance() external view returns(uint){
        return address(this).balance;
    }
}