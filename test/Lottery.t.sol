// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import "../src/Lottery.sol";
import "../src/Oracle.sol";
import "../src/Drainer.sol";
import "./FixedOracle.sol";

import {Utils} from "./utils/Utils.sol";

contract LotteryTest is Test{
    Utils internal utils;
    address payable[] internal teams;

    address internal teamA;
    address internal teamB;
    address internal teamC;

    address public owner;

    Lottery lottery;
    Oracle oracle;

    Drainer drainer;

    function setUp() public {
        owner = msg.sender;
        console.log("Setup and owner");
        console.log(address(owner));
        console.log("Owner balance:");
        console.log(address(owner).balance);

        setUpTeams();

        oracle = new Oracle(1);
        FixedOracle fixedOracle = new FixedOracle(1);
        lottery = new Lottery(address(fixedOracle));
        lottery.initialiseLottery(1);
        drainer = new Drainer(lottery, oracle);
        registeredTeams();


    } 

    function setUpTeams() internal {
        utils = new Utils();
        teams = utils.createUsers(3);
        teamA = teams[0];
        vm.label(teamA, "teamA");
        teamB = teams[1];
        vm.label(teamB, "teamB");
        teamC = teams[2];
        vm.label(teamC, "teamC");        

    }   

    function registeredTeams() internal {
        lottery.registerTeam{value: 1_000_000_000}(address(drainer), "teamA", "password");
        console.log(address(drainer));
        lottery.registerTeam{value: 1_000_000_000}(address(teamB), "teamB", "password");
        lottery.registerTeam{value: 1_000_000_000}(address(teamC), "teamC", "password");     
    }

    function testReEntrancy() public{

        drainer.drain();
        console.log("Drainer balance: ");
        console.log(address(drainer).balance);


    }

}