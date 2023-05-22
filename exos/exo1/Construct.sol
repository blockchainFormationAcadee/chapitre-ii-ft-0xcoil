// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;


contract Constructor {
    uint public myUint;

    constructor(uint _myUint) {
        myUint = _myUint;
    }
}