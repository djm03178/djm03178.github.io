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
        highestPrice["iphone 8"],
        highestPrice["iphone X"],
        highestPrice["Galaxy S9"],
        highestPrice["Galaxy Note 9"],
        highestPrice["LG G7"]);
    }
    
    function getMyBid() view public returns (uint, uint, uint, uint, uint, uint)
    {
        return (myBid[msg.sender]["iphone 7"],
        myBid[msg.sender]["iphone 8"],
        myBid[msg.sender]["iphone X"],
        myBid[msg.sender]["Galaxy S9"],
        myBid[msg.sender]["Galaxy Note 9"],
        myBid[msg.sender]["LG G7"]);
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