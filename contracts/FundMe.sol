// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    // using constant keywords on variables which are not going to change is a good practice as it brings down the transaction cost to deploy the contract
    uint256 public constant MINIMUM_USD = 50 * 1e18; 

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // To make a function payable we use the keyword payable
    // Smart contracts can hold funds just like how wallets can

    // Similar to constant, immutable keyword also helps save gas, when we know that the value isn't ever going to be mutated
    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {

        // Want to be able to set a minimum fund amount in USD
        // 1. How do we send ETH to this contract?

        // msg.value; // To access the value someone is sending in the txn
        // require(getConversionRate(msg.value) >= MINIMUM_USD, "Didn't send enough ether"); // This is the method for calling getConversionRate fn if it was written in this file
        // Now that we have imported a library containing functions that we need, we can do
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough ether");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    
    function withdraw() public onlyOwner {

        for(uint256 i=0; i<funders.length; i++){
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }

        // reset the array
        funders = new address[](0);

        // actually withdrawing the funds using one of the following three types:

        // 1. transfer
        // payable(msg.sender).transfer(address(this).balance); // msg.sender is of type address, to transfer funds, we need a payable address, so we typecast the msg.sender in a payable keyword

        // 2. send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // 3. call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");

    }

    // modifiers can be used in front of functions or variables to do something 
    // here all the functions with the onlyOwner modifier will first run the require line, and then the rest of the code of the function 
    modifier onlyOwner{
        // require(msg.sender == i_owner, "Unauthorized access!");
        if(msg.sender != i_owner) { revert NotOwner(); }
        // _ indicates to run the rest of the code in the function
        _;
    }

    // What happens if someone sends this contract ETH without calling the fund funciton

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}

        
// uint256 public number;
// number = 5;
// Some Code With require Keyword
// 1e18 == 1*10**18 == 1000000000000000000
// number = 7;
// number = 7*9*number;
// What is reverting?
// It undos any action before the error, and sends the remaining gas back
// What it means is that let say 1000 gwei is required for all the lines of computation in this fund fn, i.e. a total of 4000 gwei.
// 1000 gwei gas is spent on changing the number to 5;
// 1000 gwei is spent to check the code with the keyword requrie.
// But as soon as this line fails the validation, the gas for ONLY THE NEXT two computations are returned to the user.
// And any changes in the fund fn are REVERTED BACK, i.e. number becomes 0 again as it was before calling the fund fn.
// BUT GAS WAS SPENT FOR THE FIRST TWO COMUTATIONS AND WILL NOT BE RETURNED