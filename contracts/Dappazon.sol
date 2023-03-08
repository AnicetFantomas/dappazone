// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {
    address public owner;

    struct Item {
        uint id;
        string name;
        string category;
        string image;
        uint256 cost;
        uint256 rating;
        uint256 stock
    }

    mapping (uint256 => Item) public items;

    constructor() {
        owner = msg.sender;
    }

    //list of products
    function list(
        uint _id,
        string memory name,
        string memory category,
        string memory image,
        uint256 _cost,
        uint256 _rating,
        uint256 _stock
    ) public {
        //create Item struct    
        Item memory item = Item(_id, name, category, image, _cost, _rating, _stock);

        //save Item struct to the blockchain
        items[_id] = item;
    }
}
