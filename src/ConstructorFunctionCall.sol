// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.8.16;

// original post: https://twitter.com/saxenism/status/1565332923339145217
//                https://twitter.com/pcaversaccio/status/1565626904023113730

// https://gists.rawgit.com/ajsantander/23c032ec7a722890feed94d93dff574a/raw/a453b28077e9669d5b51f2dc6d93b539a76834b8/BasicToken.svg
// https://blog.openzeppelin.com/deconstructing-a-solidity-contract-part-ii-creation-vs-runtime-6b9d60ecb44c/

contract ConstructorFunctionCall {
    uint256 public testvar;
    bytes public testBytes;
    bool public testBool;
    uint256 public testVar2;

    constructor() {
        testvar = square(4);
        (testBool, testBytes) = address(this).call(abi.encodeWithSignature("square(uint256", 4));
        // testBool: true  / testBytes: 0x / testVar = 16
    }

    function square(uint256 a) public pure returns (uint256) {
        return a * a;
    }
}

// address(this) is actually known and available to be used in the constructor code.
// You’re getting testBool as true because any call to an address with no code will always return true.
// That’s why, like in safeTransfer, if true is returned you also need to check if the codesize > 0

// Any call to an address with no code will always return true.
// And in the constructor of a contract, that contract’s code is still empty.
