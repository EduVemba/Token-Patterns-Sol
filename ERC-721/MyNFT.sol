// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract MyNFT {
    string public name;
    string public symbol;


    //Mapping the token address ID
    mapping(uint256 => address) private _owners;

    //Mapping the address for the numbers of token the owner have
    mapping(address => uint256) private _balances;

    //Mapping the authorization for transfer
    mapping(uint256 => address) private _tokenApprovals;

    //Aprove for all the tokens
    mapping(address => mapping(address => bool)) private _operatorApprovals;


    /*
    * Events
    */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed  owner, address indexed operator, bool approved);

    function balanceOf(address owner) public view returns (uint256){
        require(owner != address(0),"Address zero is not a valid owner");
        return _balances[owner];
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0),"Token does not exist");
        return owner;
    }

    function getAproved(uint256 tokenId) internal view returns (address) {
      require(_owners[tokenId] != address(0), "Token does not exist"); 
      return _tokenApprovals[tokenId];
    }

    function isApproved(address owner, address spender) internal view returns (bool) {
        require(owner != address(0),"Addres zero is not a valid owner");
        return _operatorApprovals[owner][spender];
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        address owner = ownerOf(tokenId);
        return (spender == owner || getAproved(tokenId) == spender || isApproved(owner, spender));
    }

    function _transfer(address from, address to, uint256 tokenId) internal {
        require(from != address(0),"Addres zero is not a valid owner");
        require(to != address(0),"Address zero is not a valid recipient");
        require(_owners[tokenId] == from,"Transfer not authorized by owner");

        _balances[from] -= 1;
        _balances[to] += 1;

        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) public {
        require(_isApprovedOrOwner(msg.sender, tokenId),"Not authozired");
        require(to != address(0),"Invalid addres");

        _transfer(from, to, tokenId);
    }
}