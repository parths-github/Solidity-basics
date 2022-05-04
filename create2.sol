// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;


/* Contracts can be created by other contracts using the new keyword. 
*  Since 0.8.0, new keyword supports create2 feature by specifying salt options.*/

// Example of simple create

contract Account {
    address public bank;
    address public owner;

    constructor(address _owner) payable {
        bank = msg.sender;
        owner = _owner;
    }
}

// I want to deploy Account contract, so i am gonna create other contract which'll deploy it
contract AccountFactory {
    // Declare state variable just to keep track of account deployed
    Account[] public accounts; 
    function deploy(address _owner) external payable {
        // _owner passed into Account to initialize the constructor
        // new Account(_owner) will return an address
        // {value: 100} will tarnsfer 100 ether to new account balance
        Account account = new Account{value: 100}(_owner);
        accounts.push(account);
    }
}
