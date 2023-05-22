// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;

// Copiez le contract de la tâche précédente dans les sources de cet exercice.

contract Payable{
    address public owner;
    event Transaction (address sender,uint value);

    constructor ()payable {
        owner= payable(msg.sender);
    }

function isOwner (address payable _to, uint _amount) public{}

// Créez une fonction sendTo qui va permettre d'envoyer tous les ethers du contrat à la personne qui l'appelle.
function sendTo() public payable {
    require(msg.sender == owner, "Only the owner can use this function");
    emit Transaction(msg.sender, msg.value);
     uint balance = address(this).balance;
        payable(msg.sender).transfer(balance);
}

function sendViaCall(address payable _owner) public payable{
    (bool sent,) = _owner.call{value:msg.value}("");
    require(sent, "Failed to send ethers");
}

//function destroySmartContract() public {
    //require(msg.sender == owner, "Only the contract owner can destroy the contract");
    //selfdestruct(payable(owner));
//}

}
