// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


 contract MyToken {
    string public name; // Name of the token
    string public symbol; // Symbol of the token 
    uint8 public decimals;
    uint256 public totalSupply;

    // The savings of each address
    mapping (address => uint256) public balanceOf;

    // Returns the remaining number of tokens that the spender is allowed to spend from a account
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


    function transfer(address _to,uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address");
        require(_value > 0, "Value mus be greater than 0");
        require(balanceOf[msg.sender] >= _value, "Insuficient funds");

        //Transfer tokens
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }


    function approve(address _spender, uint256 _value) public returns (bool success) {
        require(_spender != address(0), "Invalid address");

        allowance[msg.sender][_spender] =_value;

        emit Approval(msg.sender, _spender, _value);
        return true;
    }


     // Sending token with third party account
    function transferFrom(address _sender, address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0),"Invalid addres");
        require(balanceOf[_sender] >= _value, "Inssuficient funds");
        require(allowance[_sender][msg.sender] >= _value, "Allowance exceeded");
        require(_value > 0, "Value must be greater than zero");

            balanceOf[_sender] -= _value;
            balanceOf[_to] += _value;

            allowance[_sender][msg.sender] -= _value;

        emit Transfer(_sender, _to, _value);
        return true;
    }

 }