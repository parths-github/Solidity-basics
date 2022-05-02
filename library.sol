// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;


/* Libraries are similar to contracts, but you can't declare any state variable and you can't send ether.

A library is automatically embedded into the contract if all library functions are internal.
Generally all functions in library are internal.
Otherwise the library must be deployed and then linked before the contract is deployed. */


library Math {
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
        // else z = 0 (default value)
    }
}

contract xyz {
    // Embedding all of functionalit of library Math to uint
    using Math for uint;
    function sqroot(uint x) public pure returns (uint) {
        // Here Library will take data itself as first argument
        return x.sqrt();
    }
}