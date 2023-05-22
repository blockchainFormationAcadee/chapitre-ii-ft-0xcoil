// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;

contract Counter {
    uint public count;

    function increment() external {
        count += 1;
    }
}
//Une fonction increment.
//Une fonction reset.
//Une fonction setCount, prenant en paramètre le nouveau count.
//Une fonction getValue, retournant la valeur actuelle du count.
interface ICounter{

    function increment() external;
    function reset() external;
    function setValue(uint256 newCount) external view;
    function getvalue() external view returns (uint256);
}



