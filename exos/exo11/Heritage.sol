// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.9;

contract BaseA {

    function getNb() public view virtual returns (uint256) {
        return 42;
    }

}

contract BaseB {

    function getNb() public view virtual returns (uint256) {
        return 22;
    }

}

contract BaseC is BaseA {

    function getNb() public view virtual override returns (uint256) {
        return super.getNb();
    }

}

contract Final is BaseB, BaseC{
    function getNb() public view override(BaseB, BaseC) returns (uint256){
        return super.getNb();
    }
}