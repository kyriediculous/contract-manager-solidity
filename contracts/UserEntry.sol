pragma solidity ^0.4.19;

import './CMCEnabled.sol';
import './ipfsLogic.sol';

contract UserEntry is CMCEnabled {

    function newAuthor(bytes32 _name, bytes32 _email) external {
        ipfsLogic(ContractProvider(CMC).contracts("ipfsLogic")).newAuthor(_name, _email, msg.sender);
    }

    function addBook(bytes32 _bookHash, bytes32 _title, bytes32 _thumbHash) external {
        ipfsLogic(ContractProvider(CMC).contracts("ipfsLogic")).addBook(_bookHash, _title, _thumbHash, msg.sender);
    }

    function authorByName(bytes32  _name) external view returns (
        bytes32 name,
        bytes32 email,
        bool registered) {
          return ipfsLogic(ContractProvider(CMC).contracts("ipfsLogic")).authorByName(_name);
    }

    function getBookByHash(bytes32 _bookHash) external view returns (
        bytes32 bookhash,
        bytes32 thumbHash,
        bytes32 title,
        address author,
        bytes32 IPPR) {
          return ipfsLogic(ContractProvider(CMC).contracts("ipfsLogic")).getBookByHash(_bookHash);
    }

    function getBookByTitle(bytes32 _title) external view returns (
        bytes32 bookhash,
        bytes32 thumbHash,
        bytes32 title,
        address author,
        bytes32 IPPR) {
          return ipfsLogic(ContractProvider(CMC).contracts("ipfsLogic")).getBookByTitle(_title);
    }

    function getBooksByAuthor(bytes32 _name) external view returns (
        uint[20] books,
        bytes32 name,
        bytes32 email) {
          return ipfsLogic(ContractProvider(CMC).contracts("ipfsLogic")).getBooksByAuthorName(_name);
    }
}
