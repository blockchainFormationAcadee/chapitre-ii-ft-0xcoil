// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;

//Créez un contrat Modifier.

contract Modifier {
    address public owner;

//Créez un constructeur pour stocker l'adresse de l'owner du contrat.

constructor(){
    owner = msg.sender;
}
//Créez un modifier isOwner qui permet de bloquer le code si jamais la personne qui appelle la fonction n'est pas l'owner du contract via un require.
modifier isOwner (){
    require(msg.sender == owner, "Not the owner of the contract");
    _;
}
//Appliquez ce modifier sur une fonction que vous créez.
function modifierTest() external isOwner{
    
}

}
