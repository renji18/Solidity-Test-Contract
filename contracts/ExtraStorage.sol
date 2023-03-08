// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

// We can inherit all the behaviour of a contract to another contract
// this is called inheritance
contract ExtraStorage is SimpleStorage {
    // virtual override

    // If we are creating a contract which is an extension to an inherited contract then we add new functions or features to that contract
    // we can also MODIFY a function created in the parent contract from the new contract
    // BUT only functions marked as virtual in the parent contract can be overwritten using the override keyword in the new contract
    
    function store(uint256 _favNum) public override {
        favouriteNumber = _favNum + 5;
    }
}