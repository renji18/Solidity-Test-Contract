// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

    function getPrice() internal view returns(uint256) {
        // ABI
        // Address 0x143db3CEEfbdfe5631aDD3E50f7614B6ba708BA7
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x143db3CEEfbdfe5631aDD3E50f7614B6ba708BA7);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        //
        // ETH in terms of USD in 8 decimal places
        return uint256(answer * 1e10); // 1**10
        // 153155000000
    }

    // We can call interfaces that are outside of our smart contracts and call functions on them from our contract

    function getVersion() internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x143db3CEEfbdfe5631aDD3E50f7614B6ba708BA7);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        // ethAmount = 2000000000000000000
        uint256 ethPrice = getPrice();
        // ethPrice = 153155000000
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        // ethAmountInUsd = (153155000000 * 2) = 
        return ethAmountInUsd;
    }

}