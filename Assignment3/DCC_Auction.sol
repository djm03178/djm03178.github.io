pragma solidity ^0.4.24;

contract DCCAuction {
    struct buyer {
        address addr;
        uint tokens;
    }
    
    mapping (address => buyer) public buyers;
    mapping (bytes32 => uint) public highestPrice;
    mapping (address => mapping (bytes32 => uint)) public myBid;
    
    bytes32[] public items;
    uint public tokenPrice;
    
    constructor(uint _tokenPrice) public
    {
        tokenPrice = _tokenPrice;
    }
    
    function buy() payable public
    {
        uint tokensToBuy = msg.value / tokenPrice;
        buyers[msg.sender].addr = msg.sender;
        buyers[msg.sender].tokens += tokensToBuy;
    }
    
    function getHighestPrice() view public returns (uint, uint, uint, uint, uint, uint)
    {
        return (highestPrice["iphone 7"],
        highestPrice["Galaxy S9"],
        highestPrice["iphone 8"],
        highestPrice["Galaxy Note 9"],
        highestPrice["iphone X"],
        highestPrice["LG G7"]);
    }
    
    function getMyBid(address addr) view public returns (uint, uint, uint, uint, uint, uint)
    {
        return (myBid[addr]["iphone 7"],
        myBid[addr]["iphone 8"],
        myBid[addr]["iphone X"],
        myBid[addr]["Galaxy S9"],
        myBid[addr]["Galaxy Note 9"],
        myBid[addr]["LG G7"]);
    }
    
    function bid(bytes32 itemName, uint tokens) public
    {
        require(tokens <= buyers[msg.sender].tokens);
        
        buyers[msg.sender].tokens -= tokens;
        myBid[msg.sender][itemName] += tokens;
        if (myBid[msg.sender][itemName] > highestPrice[itemName])
            highestPrice[itemName] = myBid[msg.sender][itemName];
    }
    
    function getTokenPrice() view public returns (uint)
    {
        return tokenPrice;
    }
    
    function getTokenBought() view public returns (uint)
    {
        return buyers[msg.sender].tokens;
    }
}