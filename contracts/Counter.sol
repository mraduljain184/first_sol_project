// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Counter {
    uint256 public value;

    event Incremented(address indexed by, uint256 newValue);
    event Decremented(address indexed by, uint256 newValue);
    event Reset(address indexed by, uint256 newValue);

    constructor(uint256 _initial) {
        value = _initial;
    }

    function increment(uint256 amount) external {
        value += amount;
        emit Incremented(msg.sender, value);
    }

    function decrement(uint256 amount) external {
        require(amount <= value, "Underflow");
        value -= amount;
        emit Decremented(msg.sender, value);
    }

    function reset() external {
        value = 0;
        emit Reset(msg.sender, value);
    }
}