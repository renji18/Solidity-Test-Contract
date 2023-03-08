// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importing a contract
import "./SimpleStorage.sol";

contract StorageFactory {
    // We create an array of the SimpleStorage contract itself
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        // a variable simpleStorage of data type SimpleStorage is alloted an address using the new keyword and calling the SimpleStorage() constructor
        SimpleStorage simpleStorage = new SimpleStorage();
        // then the simpleStorage variable with the address to the created SimpleStorage contract is stored in the simpleStorageArray
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // Address
        // ABI -- Application Binary Interface

        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        // simpleStorage.store(_simpleStorageNumber);

        // then we access a particular SimpleStorage contract stored in the simpleStorageArray using the _simpleStorageIndex

        // then we can call all the functions of the SimpleStorage contract
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        // return simpleStorage.retrieve();
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}