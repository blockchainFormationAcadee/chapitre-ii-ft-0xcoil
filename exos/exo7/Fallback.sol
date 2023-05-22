// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;

contract Fallback {
    uint public count;

    fallback() external {
        count += 1;
    }
}
