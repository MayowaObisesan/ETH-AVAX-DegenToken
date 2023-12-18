// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20("Degen", "DGN"), Ownable {
    struct Item {
        uint256 amount;
        address owner;
    }

    uint256 id;
    mapping(uint256 => Item) public items;

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function redeem(uint256 _id) public {
        require(_id < id, "Item does not exist");
        Item storage _item = items[_id];

        require(
            _item.owner == address(this),
            "You have redeemed this item already"
        );

        _burn(msg.sender, _item.amount);
        _item.owner = msg.sender;
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function createItem(uint256 amount) public onlyOwner {
        items[id] = Item({amount: amount, owner: address(this)});
        id++;
    }
}
