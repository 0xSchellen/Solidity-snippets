// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.8.16;

// original post: https://twitter.com/saxenism/status/1565332923339145217
//                https://twitter.com/pcaversaccio/status/1565626904023113730

contract ConstructorFunctionCall {

    uint public testvar;
    bytes public testBytes;
    bool public testBool;
    uint public testVar2;

    constructor() {
        testvar = square(4);
        (testBool, testBytes) = address(this).call(abi.encodeWithSignature("square(uint256", 4));
        // testBool: true  / testBytes: 0x / testVar = 16
        }

    function square(uint256 a) public pure returns(uint256) {
        return a*a;
    }
}