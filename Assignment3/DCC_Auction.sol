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
        
        items.push("iphone 7");
        items.push("Galaxy S9");
        items.push("iphone 8");
        items.push("Galaxy Note 9");
        items.push("iphone X");
        items.push("LG G7");
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
    
    function bid(bytes32 itemName, uint tokens) public
    {
        uint idx = getItemIndex(itemName);
        require(idx != uint(-1));
        
        require(tokens <= buyers[msg.sender].tokens);
        
        buyers[msg.sender].tokens -= tokens;
        myBid[msg.sender][itemName] += tokens;
        if (myBid[msg.sender][itemName] > highestPrice[itemName])
            highestPrice[itemName] = myBid[msg.sender][itemName];
    }
    
    function getItemIndex(bytes32 itemName) view public returns (uint)
    {
        for (uint i = 0; i < items.length; i++)
            if (items[i] == itemName)
                return i;
        return uint(-1);
    }
    
    function getItems() view public returns (bytes32[])
    {
        return items;
    }
    
    function getTokenPrice() view public returns (uint)
    {
        return tokenPrice;
    }
    
    function getTokenBought() view public returns (uint)
    {
        return buyers[msg.sender].tokens;
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
}