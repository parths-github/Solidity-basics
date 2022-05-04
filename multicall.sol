// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract  testMulticall{
    function test1 (uint _i) external view returns(uint, uint) {
        return (_i, block.timestamp);
    }
    function test2 (uint _i) external view returns(uint, uint) {
        return (_i, block.timestamp);
    }
    
    // To call the above 2 function together from another contract or from this contrcat itself we need
    // data of those 2 function
    function getData1(uint _i) external pure returns(bytes memory) {
        // return abi.encodeWithSignature("_name(uint)", _i);
        return abi.encodeWithSelector(this.test1.selector, _i);
    }

    function getData2(uint _i) external pure returns(bytes memory) {
        // return abi.encodeWithSignature("_name(uint)", _i);
        return abi.encodeWithSelector(this.test2.selector, _i);
    }

    function multiCall(address[] calldata _address, bytes[] calldata data)
        external
        view
        returns(bytes[] memory)
        {
            // Make sure that both parameter are same in length(if there are 2 addresses than there must be 2 data)
            // Here address are addresses of contract whose functions we are gonna call, it can either be same contract or other contract
            require(_address.length == data.length, "Invalid number of arguments");
            
            // Creating bytes array in memeory to return with yhe length of data in input
            bytes[] memory results = new bytes[](data.length);

            // If current function make some txn than we have to use call, but if it's just view then we can use staticcall
            for (uint i; i < data.length; i++) {
                (bool success, bytes memory result) = _address[i].staticcall(data[i]);
                require(success, "call failed");
                results[i] = result;
            }

            return results;
        }
}