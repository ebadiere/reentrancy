pragma solidity >=0.6.0;
/// @title Oracle for Lottery Game
/// @author Sparx - https://github.com/letsgitcracking
/// @notice WARNING - NEVER USE IN PRODUCTION - FOR EDUCATIONAL PURPOSES ONLY!
import {console} from "forge-std/console.sol";

contract FixedOracle {
    // Hide seed value!!
    uint8 private seed;
    address owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(uint8 _seed){
        owner = msg.sender;
        seed = _seed;
    }

    function getRandomNumber() external view returns (uint256) {
        console.log("Returning fixed value");
        return uint256(1);
    }

    function changeSeed(uint8 _seed) external onlyOwner {
        seed = _seed;
    }
}