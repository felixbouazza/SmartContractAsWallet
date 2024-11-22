// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.26;

contract Wallet {

    address private owner;

    constructor() {
        owner = msg.sender;
    }

    error OnlyOwnerError();

    error BalanceInsufficientAmountError();

    modifier onlyOwner() {
        if(msg.sender != owner)
            revert OnlyOwnerError();
        _;
    }

    function withdraw(uint amount, address _to) public onlyOwner {
        if (amount > address(this).balance) {
            revert BalanceInsufficientAmountError();
        }
        payable(_to).transfer(amount);
    }

    function withdrawAll(address _to) public onlyOwner {
        withdraw(address(this).balance, _to);
    }

    function withdrawAllToOwner() public onlyOwner {
        withdrawAll(owner);
    }

    receive() external payable {}

}