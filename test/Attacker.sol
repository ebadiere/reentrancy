// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Lottery.sol";
import "./FixedOracle.sol";
import {console} from "forge-std/console.sol";

// interface ILottery {
//     function registerTeam(address _walletAddress, string calldata _teamName, string calldata _password) external payable;
// }

contract Attacker {

    Lottery lottery;
    FixedOracle fixedOracle;

    constructor() public {
        fixedOracle = new FixedOracle(1);
        lottery = new Lottery(address(fixedOracle));
        console.log("Attacker deployed!");
        console.log("Attacker initial balance: ");
        console.log(address(this).balance);
    }

    function attack() public {
        console.log("Before register");
        lottery.registerTeam{value: 1_000_000_000}(address(this), "teamA", "password");
        console.log(address(this));
    }

    fallback() external payable{
        console.log("fallback");
        console.log(msg.value);
        console.log(address(this).balance);
        // lottery.payoutWinningTeam(address(this));
        console.log("Ran payout again");
        console.log("Balance after fallback payout");
        console.log(address(this).balance);
    }
}