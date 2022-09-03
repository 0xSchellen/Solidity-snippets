// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MakeAddress {
    function mkaddr(string memory name) public pure returns (address addr) {
        addr = address(uint160(uint256(keccak256(bytes(name)))));
    }
}
