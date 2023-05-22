// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;

contract Random {
    //Créez une fonction getRandom qui retourne un uint256 et prend en paramètre une string.

  function getRandom(string memory text) public pure returns (uint256) {

//Implémentez cette fonction en plusieurs étapes :
//Chiffrez cette string via keccak.
//Faites une opération qui dépend du block pour avoir un nombre aléatoire.
//Retournez un nombre qui dérive de ces étapes.

      bytes32 hash = keccak256(abi.encode(text));
      uint256 value = uint256(hash);
      return value;

}
}