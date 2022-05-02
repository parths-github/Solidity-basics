// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;


// keccak256 computes the Keccak-256 hash of the input.
/* Creating a deterministic unique ID from a input
* Commit-Reveal scheme
* Compact cryptographic signature (by signing the hash instead of a larger input) */

/* abi.encode and abi.encodePacked both converts input to bytes32 but encodePacked output is compact.
   SO, chances of collisions in case of dynamic inputs. So if you have uint or address try to place it in bw 2 dynamic input */

contract HashFunction {
    function hash(
        string memory _text,
        uint _num,
        address _addr
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_text, _num, _addr));
    }

    // Example of hash collision
    // Hash collision can occur when you pass more than one dynamic data type
    // to abi.encodePacked. In such case, you should use abi.encode instead.
    function collision(string memory _text, string memory _anotherText)
        public
        pure
        returns (bytes32)
    {
        // encodePacked(AAA, BBB) -> AAABBB
        // encodePacked(AA, ABBB) -> AAABBB
        return keccak256(abi.encodePacked(_text, _anotherText));
  