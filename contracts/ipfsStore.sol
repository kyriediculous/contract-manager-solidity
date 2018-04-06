pragma solidity ^0.4.19;

import './CMCEnabled.sol';

contract ipfsStore is CMCEnabled {
    struct Book {
        address author; //book author
        bytes32 title; //book title
        bytes32 bookHash; //ipfs book hash
        bytes32 thumbHash; //ipfs thumbnail hash
        uint timestamp; //Time of publishing
        bytes32 IPPR; //Interplanetary Publishing Reference
    }

    Book[] public books;

    mapping (uint => address) public BookToOwner;
    mapping (address => uint) public OwnerBookCount;

    struct Author {
        bytes32 name;
        bytes32 email;
        bool registered;
    }

    mapping (address => Author) public authors;
    mapping(bytes32  => address) public authorAddresses;

    function newAuthor(bytes32 _name, bytes32 _email, address _addr) external isCMCEnabled("ipfsLogic") {
        authors[_addr].name = _name;
        authors[_addr].email = _email;
        authors[_addr].registered = true;
        authorAddresses[_name] = _addr;
    }

    function authorByName(bytes32 _name) external view isCMCEnabled("ipfsLogic") returns (bytes32, bytes32, bool) {
        return (authors[authorAddresses[_name]].name,
                authors[authorAddresses[_name]].email,
                authors[authorAddresses[_name]].registered);
    }

      function getAuthor(address _address) external view isCMCEnabled("ipfsLogic") returns (bytes32, bytes32, bool) {
        return (authors[_address].name,
                authors[_address].email,
                authors[_address].registered);
    }


    function addBook(bytes32 _bookHash, bytes32 _title, bytes32 _thumbHash, address _sender) external isCMCEnabled("ipfsLogic") {
            uint _timestamp = now;
            bytes32 _IPPR = keccak256(_sender, _title, authors[msg.sender].name);
            uint id = books.push(Book(msg.sender, _title, _bookHash, _thumbHash, _timestamp, _IPPR))-1;
            BookToOwner[id] = _sender;
            OwnerBookCount[_sender]++; ///CONVERT TO SAFEMATH
    }

    function bookCount() external view isCMCEnabled("ipfsLogic") returns (uint) {
        return books.length;
    }

    function getBookByHash(bytes32 _bookHash) external view isCMCEnabled("ipfsLogic") returns (bytes32 bookHash, bytes32 thumbHash, bytes32 title, address author, bytes32 IPPR) {
        for (uint i = 0; i < books.length; i++) {
            if (_bookHash == books[i].bookHash) return (books[i].bookHash, books[i].thumbHash, books[i].title, books[i].author, books[i].IPPR);
        }
    }

    function getBookByTitle(bytes32 _title) external view isCMCEnabled("ipfsLogic") returns (bytes32 bookHash, bytes32 thumbHash, bytes32 title, address author, bytes32 IPPR) {
        for (uint i = 0; i < books.length; i++) {
         if (_title == books[i].title) return (books[i].bookHash, books[i].thumbHash, books[i].title, books[i].author, books[i].IPPR);
        }
    }

    function getBooksByAuthor(address _author) internal view returns (uint[]) {
        uint[] memory result = new uint[](OwnerBookCount[_author]);
        uint counter = 0;
        for (uint i = 0; i < books.length; i++) { //CONVERT TO SAFEMATH
          if (BookToOwner[i] == _author) {
            result[counter] = i;
            counter++; ///CONVERT TO SAFEMATH
          }
        }
        return result;
    }

    function getBooksByAuthorName(bytes32 _author) external view isCMCEnabled("ipfsLogic") returns (uint[20], bytes32, bytes32) {
        address author = authorAddresses[_author];
        uint[] memory getBooks = getBooksByAuthor(author);
        uint[20] memory books;
        for (uint i = 0; i < getBooks.length; i++) {
           books[i] = getBooks[i];
        }
        return(books, authors[author].name, authors[author].email);
    }
}
