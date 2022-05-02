// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

// Contracts can be deleted from the blockchain by calling selfdestruct.

// selfdestruct sends all remaining Ether stored in the contract to a designated address.
// If designated address is of contract and even though contract doesn't have fallback function it will receive the ether



contract Kill {
    // We want this contract to ahve some ether so while selfdestrucying it can transfer it to designated address
    constructor() payable {}

    // After selfdestruction this function wont be callable
    function abc() external pure returns (uint) {
        return 123;
    }

    function kill() external {
        // Contract will be deleted and all of the ether of contract will be transfered to msg.sender
        selfdestruct(payable(msg.sender));
    }
}

contract Helper {

    // Before calling the kill function this will return 0, but after calling the kill function it will return 10 as we have deplyoed Kill contract with 10 wei
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function kill(Kill _kill) external {
        _kill.kill();
    }
}