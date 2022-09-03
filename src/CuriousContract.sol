// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

// original post : https://github.com/JoshuaTrujillo15/cursed-struct-token

struct CuriousStruct {
    function (uint256) pure returns (uint256) curiousFunction;
}

function double(uint256 a) pure returns (uint256) {
    return a * 2;
}

contract CuriousContract {
    function f(uint256 _a) public pure returns (uint256) {
        CuriousStruct memory cs = CuriousStruct({curiousFunction: double});

        return cs.curiousFunction(_a);
    }
}
