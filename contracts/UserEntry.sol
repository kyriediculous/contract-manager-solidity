pragma solidity ^0.4.19;

import './CMCEnabled.sol';
import './ipfsLogic.sol';

contract UserEntry is CMCEnabled {

    function() external {
       revert();
    }

    function newAuthor(bytes32 _name, bytes32 _email) external {
        ipfsLogic(ContractProvider(CMC).contracts("ipfsLogic")).newAuthor(_name, _email, msg.sender);
    }

    function authorByName(bytes32  _name) external view returns (bytes32 name, bytes32 email, bool registered) {
        (name, email, registered) =  ipfsStore(ContractProvider(CMC).contracts("ipfsStore")).authorByName(_name);
        return (name, email, registered);
    }

    function addBook(bytes32 _bookHash, bytes32 _title, bytes32 _thumbHash) external {
        ipfsLogic(ContractProvider(CMC).contracts("ipfsLogic")).addBook(_bookHash, _title, _thumbHash, msg.sender);
    }

    function getBookByHash(bytes32 _bookHash) external view returns (
        bytes32 bookhash,
        bytes32 thumbHash,
        bytes32 title,
        address author,
        bytes32 IPPR) {
            return ipfsStore(ContractProvider(CMC).contracts("ipfsStore")).getBookByHash(_bookHash);
    }

    function getBookByTitle(bytes32 _title) external view returns (
        bytes32 bookhash,
        bytes32 thumbHash,
        bytes32 title,
        address author,
        bytes32 IPPR) {
            return ipfsStore(ContractProvider(CMC).contracts("ipfsStore")).getBookByTitle(_title);
    }

    function getBooksByAuthor(bytes32 _name) external view returns (uint[20] books, bytes32 name, bytes32 email) {
        return ipfsStore(ContractProvider(CMC).contracts("ipfsStore")).getBooksByAuthorName(_name);
    }
}
