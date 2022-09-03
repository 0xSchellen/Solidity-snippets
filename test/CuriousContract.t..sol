// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/CuriousContract.sol";

contract CuriousContractTest is Test {
    CuriousContract public curiousContract;

    function setUp() public {
        curiousContract = new CuriousContract();
    }

    function testDouble() public {
        assertEq(double(3), 6);
    }

    function testCuriousContractFunctionF() public {
        uint256 result = curiousContract.f(7);
        assertEq(result, 14);
    }
}
