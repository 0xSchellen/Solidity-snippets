// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

// janbro.eth @unsafe_call
// original post: https://twitter.com/unsafe_call/status/1565789603046588417/photo/1
// Can you spot the bug in this code?


contract WhiteList {

    // ...

    function WhiteListMint(
        bytes32[] calldata _merkleProof, 
        uint256 chosenAmount) 
            public 
        {
            require(_numberMinted(msg.sender)<1, "Already Claimed");
            require(isPaused == false, "turn on minting");
            require(choosenAmount > 0, "Number of Tokens can not be less than or equal to 0");
            require(totalSupply() + chosenAmount <= maxSupply - reserve, "All tokens have been minted");

            bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
            require(MerkleProof.verify(_merkleProof, rootHash, leaf), "Invalid Proof");

            _safeMint(msg.sender, choosenAmount);
        }
}


// janbro.eth @unsafe_call
// original post: https://twitter.com/unsafe_call/status/1565789603046588417/photo/1
// Can you spot the bug in this code?

// Bug description:
/*
You all have some great security intuition, let’s take a dive into the code to understand 
what the bug here is. For context, this code was part of Rug Pull Finder’s NFT sale

Rug Pull Finder investigates NFT projects to identify potential scams or fraudulent 
NFT sales that could hurt web3 communities. 
Recently they decided to launch a new NFT of their own, The Bad Guys NFT

RPF added users to a whitelist for minting by use of a Merkle Patricia Trie.
Merkle Patricia Tries are a fundamental data structure in Ethereum in which every leaf 
is labeled with the hash of it’s data, and every other node is labeled with the hash 
of its children’s labels

MerkleProof.verify alone won’t prevent people from reusing proofs to mint more than once, 
but the first require checks that the user hasn’t already minted tokens before.
 _numberMinted is incremented in the underlying call to _safeMint. 
 The bug here is actually with chosenAmount

chosenAmount is user controllable since it’s just a parameter to the mint function. 
The third require checks if it’s at least one, but doesn’t impose any upper limit. 
Since the NFTs are minted at the end of the function there are no restrictions on the 
number you can mint at once

Because of this, a user minted 400 of the 1221 max supply in a single transaction, 
just by being on the whitelist

If we take a look at MerkleProof.verify(…), wrapped by a require, we can see we pass 
in our _merkleProof, which is our path to the root node, the rootHash which is a global
variable set by the owner, and the leaf which is generated from the hash of msg.sender

MerkleProof.verify alone won’t prevent people from reusing proofs to mint more than once, 
but the first require checks that the user hasn’t already minted tokens before. 
_numberMinted is incremented in the underlying call to _safeMint. 
The bug here is actually with chosenAmount

chosenAmount is user controllable since it’s just a parameter to the mint function. 
The third require checks if it’s at least one, but doesn’t impose any upper limit. 
Since the NFTs are minted at the end of the function there are no restrictions on 
the number you can mint at once

Because of this, a user minted 400 of the 1221 max supply in a single transaction, 
just by being on the whitelist

RPF could have prevented this by having an upper limit on the chosenAmount users could supply. 
Alternatively, they could have included the chosenAmount in the data of the leaf node, 
and only allow proofs which used a specific chosenAmount granted when the MPT was made

*/