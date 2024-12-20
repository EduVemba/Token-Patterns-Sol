// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


 contract MyToken {
    string public name; // Name of the token
    string public symbol; // Symbol of the token 
    uint8 public decimals;
    uint256 public totalSupply;

    // The savings of each address
    mapping (address => uint256) public balanceOf;

    // Returns the remaining number of tokens that the spender is allowed to spend
    mapping(address => mapping(address => uint256)) public allowance;
    
    /*
    *Events
    */

    // Transfer When a token goes from one address to another
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Aproval when a aprove function set an approval
    event Approval(address indexed owner, address indexed spender, uint256 value);


    constructor(string memory _name, string memory _symbol,uint8 _decimals, uint256 _initialSupply){
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * (10 ** uint256(decimals)); // add decimals to inicial supply
        balanceOf[msg.sender] = totalSupply; // credit the initial value to the contract creator
    }


 }