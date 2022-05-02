//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// When contract A executes delegatecall to contract B, B's code is executed
// with contract A's storage, msg.sender and msg.value.

// NOTE: Deploy this contract first
contract B {
    // NOTE: storage layout must be the same as contract A
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}


contract A {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _b, uint _num) external payable {
      // A's storage is set, B is not modified even though b's function is called.
      //  _b.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));

      (bool success, bytes memory data) = _b.delegatecall(
          abi.encodeWithSelector(B.setVars.selector, _num));
    }
}