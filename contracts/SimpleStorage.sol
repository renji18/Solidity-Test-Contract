// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    // Various examples of dataTypes

    // bool hasFavouriteNumber=true;
    // uint256 favouriteNumber=5;
    // string favouriteNumberInText="Five";
    // int256 favouriteInt=-5;
    // address myAddress=0x458bbA8b84C7b8e7420355BDd2C98F17F2BDD073;
    // bytes32 favouriteBytes = "cat";

    // Default Initialization
    // Default visibility is internal
    uint256 public favouriteNumber;

    // Scope of testVar is inside only the func store
    // so It can't be used inside somethin func

    // function something() public {
    //     testVar = 6;
    // }

    // view and pure defined funcs are denoted by blue color because they don't cost gas.
    function retrieve() public view returns (uint256) {
        return favouriteNumber;
    }

    // view and pure funcs disallow modification of state

    // function add() public pure returns(uint256){
    //     return (1+1);
    // }

    // If a gas calling function calls a view or pure function - only then will it cost gas

    function store(uint256 _favouriteNumber) public {
        favouriteNumber = _favouriteNumber;
        // uint256 testVar = 5;

        // Calling the view function retrieve inside this gas consuming function will now consume gas even when retireve is called
        // retrieve();
    }

    struct People {
        uint256 favNum;
        string name;
    }
    // Example of struct data type to initialize a public 'person'
    // People public person = People({favNum: 2, name: "Aadarsh"});

    // Dynamic array creation
    People[] public people;

    // calldata, memory, storage
    // calldata and memory means that the data exist only temporarily during the transaction that a particular funciton is called
    // storage exist outside of a function

    // calldata -> temoprary, can't be modified
    // memory -> temoprary, can be modified
    // storage -> permanent, can be modified

    // structs, mappings and arrays need to be given memory or calldata keyword when adding them to as parameters in a function
    // and string is secretly an array
    function addPerson(string memory _name, uint256 _favNum) public {
        people.push(People(_favNum, _name));
        // People memory newPerson = People({favNum:_favouriteNumber, name:_name});
        // People memory newPerson = People(_favouriteNumber, _name);
        // people.push(newPerson);
        nameToFavNum[_name] = _favNum;
    }

    // Fixed size
    // People[4] public people;

    mapping(string => uint256) public nameToFavNum;
}