// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WithdrawHelper {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function withdrawETH(address payable oldContract) external {
        require(msg.sender == owner, "Not the contract owner");
        (bool success, bytes memory returnData) = oldContract.call{value: 0}(abi.encodeWithSignature("withdrawETH()"));
        require(success, string(abi.encodePacked("Withdraw failed: ", returnData)));
    }

    function withdrawAllETH() external {
        require(msg.sender == owner, "Not the contract owner");
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {}
}
