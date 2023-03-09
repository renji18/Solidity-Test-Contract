// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample {
    uint256 public result;
    
    // recieve and fallback are special functions that don't require the keyword funciton while declaration
    // receive is triggered whenever there is txn happening in the contract, but it doesn't take any data, doesn't store any data etc.
    receive() external payable {
        result = 1;
    }

    // similar to recieve, but it is called when a data is send along with the txn and there is no fucntion associated for handling that data
    fallback() external payable {
        result = 20;
    }
}

// Ether is sent to contract
//          is msg.data empty ?
//               /     \
//             yes      no
//              /        \
//          receive()?    fallback()
//            /    \
//          yes    no
//          /       \
//      receive()    fallback()