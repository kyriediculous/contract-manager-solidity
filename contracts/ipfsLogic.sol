pragma solidity ^0.4.19;

import './CMCEnabled.sol';

import './ipfsStore.sol';

contract ipfsLogic is CMCEnabled {

    function newAuthor(bytes32 _name, bytes32 _email, address _addr) external {
        bool registered;
      (,,registered) = ipfsStore(ContractProvider(CMC).contracts("ipfsStore")).getAuthor(_addr);
      require(!registered);
      ipfsStore(ContractProvider(CMC).contracts("ipfsStore")).newAuthor(_name, _email, _addr);
    }

    function addBook(bytes32 _bookHash, bytes32 _title, bytes32 _thumbHash, address _sender) public {
        //Check if author is registered
        bool registered;
        (,,registered) = ipfsStore(ContractProvider(CMC).contracts("ipfsStore")).getAuthor(_sender);
        require(registered);
        //Check if book exists on contract
        require(!_bookExists(_bookHash));
        ipfsStore(ContractProvider(CMC).contracts("ipfsStore")).addBook(_bookHash, _title, _thumbHash, _sender);
    }

    function _bookExists(bytes32 _bookHash) internal view returns (bool) {
        uint length = ipfsStore(ContractProvider(CMC).contracts("ipfsStore")).bookCount();
        for (uint i = 0; i < length; i++) {
            bytes32 bookHash;
            (bookHash,,,,) = ipfsStore(ContractProvider(CMC).contracts("ipfsStore")).getBookByHash(_bookHash);
           if (_bookHash == bookHash) return true;
        }
        return false;
    }
}