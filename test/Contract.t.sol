// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/MakeAddress.sol";

contract ContractTest is Test {
    MakeAddress private makeAddress; 


    function setUp() public {
        makeAddress = new MakeAddress();
    }

    function testMakeAddress() public {
        address result = makeAddress.mkaddr("Alice");
        console.log(result);
        assertEq(result, address(0x344e427a3088657Fda629b5F4a647822d329cd6A));
                               //0x344e427a3088657fda629b5f4a647822d329cd6a
    }
}
