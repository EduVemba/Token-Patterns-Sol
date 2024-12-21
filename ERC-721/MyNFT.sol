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
}