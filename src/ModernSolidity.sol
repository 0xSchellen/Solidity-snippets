/ SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

// original post: https://twitter.com/saxenism/status/1565586609625792513

contract ModernSolidityFeatures {
    TestContract tcInstance = new TestContract();

    function conventionalFunctionSelector(string memory functionSignature) public view returns(bytes4) {
        return bytes4(keccak256(bytes(functionSignature)));
    }

    function modernFunctionSelector() public view returns(bytes4) {
        return tcInstance.square.selector;
    }


    function conventionalIsContract(address  addr) public view returns(bool) {
        uint256 sizeOfAddressCodeSelection;
        assembly {
            sizeOfAddressCodeSelection := extcodesize(addr)
        }
        return (sizeOfAddressCodeSelection > 0);
    }

    function modernIsContract(address  addr) public view returns(bool) {
        return (addr.code.length > 0 ? true : false);
    }

}


contract TestContract {
    uint256 public number;

    function square(uint256 a) public view returns(uint256) {
        return a*a;
    }

}










