// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// pragma solidity ^0.6.0;

contract SafeMathTester {
    uint8 public bigNumber = 255;

    // In older versions if a datatype has reached its max limit of holding a value like int8 with max val 255, then adding to 255 will start calculating back from 0, if we reach 255 again and add 1 to it, then it will go back to 0 and adding more to it will rotate in a loop
    // But now in the newer versions library SafeMath checks for this kind of case and adding 1 to 255 whose data type is int8, will result in an error and the value will remain 255 rather than reverting back to 0
    function add() public {
        // bigNumber = bigNumber + 1;
        // using unchecked keyword will make the previous behaviour of reverting back to 0 on reaching the cap value take effect again
        unchecked {bigNumber = bigNumber + 1;}
    }
}