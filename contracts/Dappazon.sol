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
        uint256 stock;
    }

    struct Order {
        uint256 time;
        Item item;
     }

    modifier onlyOwner {
        require(msg.sender == owner, "sender must be the same as owner");
        _;
    }

    mapping (uint256 => Item) public items;
    mapping (address => uint256) public orderCount;
    mapping (address => mapping (uint256 => Order)) public orders;

    event List(string name, uint256 cost, uint256 stock);
    event Buy(address buyer, uint256 orderId, uint256 itemId);

    constructor() {
        owner = msg.sender;
    }

    //list of products
    function list(
        uint _id,
        string memory _name,
        string memory _category,
        string memory _image,
        uint256 _cost,
        uint256 _rating,
        uint256 _stock
    ) public onlyOwner {
        
        //create Item struct    
        Item memory item = Item(_id, _name, _category, _image, _cost, _rating, _stock);

        //save Item struct to the blockchain
        items[_id] = item;

        //emit event 
        emit List(_name, _cost, _stock);
    }

    function buy (uint256 _id) public payable {
        // fetch items saved 
        Item memory item = items[_id];

        // make sure the we don't buy at low price
        require(msg.value > item.cost, "You don't have enough founds to buy this item");

        //make sure the we have the item in our stock
        require (item.stock > 0, "We dont have the item in our stock");

        // create order
        Order memory order = Order(block.timestamp, item);

        // save order to the blockchain
        orderCount[msg.sender] ++;
        orders[msg.sender][orderCount[msg.sender]] = order;

        // substract sold item from the stock
        
        items[_id].stock = item.stock - 1;

        // emit event
        emit Buy(msg.sender, orderCount[msg.sender], item.id);
     }
     
      // withdraw from the blockchain

      function withdraw() public onlyOwner {
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success);
     }
}
