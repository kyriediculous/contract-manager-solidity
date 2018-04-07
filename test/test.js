const CMC = artifacts.require('./CMC')
const UserEntry = artifacts.require('./UserEntry')
const ipfsLogic = artifacts.require('./ipfsLogic')
const ipfsStore = artifacts.require('./ipfsStore')

const convertHex = (input) => web3.toAscii(input).replace(/\u0000/g, '')

contract('CMC', (accounts) => {
  console.log(web3.version.api)
  let CMCinstance, UserEntryinstance, Controllerinstance,
  Storageinstance, name = "John Doe", email = "john@example.com",
  address = accounts[0], bookHash = "1234ABCD", title = "test",
  thumbHash ="UWXYZ9876";
  it("Should add a newly deployed contract (UserEntry) to the register", () => {
    return CMC.deployed().then(instance => {
      CMCinstance = instance
      return UserEntry.deployed()
    }).then(instance => {
      UserEntryinstance = instance
      expect(() => {
        return CMCinstance.addContract("UserEntry", UserEntryinstance.address)
      }).to.not.throw()
    })
  })
  it("Should add ipfsLogic to the register", () => {
    return ipfsLogic.deployed().then(instance => {
      Controllerinstance = instance
      expect(() => {
        return CMCinstance.addContract("ipfsLogic", Controllerinstance.address)
      }).to.not.throw()
    })
  })
  it("Should add ipfsStore to the register", () => {
    return ipfsStore.deployed().then(instance => {
      Storageinstance = instance
      expect(() => {
        return CMCinstance.addContract("ipfsStore", Storageinstance.address)
      }).to.not.throw()
    })
  })
  it("Should create a new Author", () => {
    return UserEntryinstance.newAuthor(name, email, {from: address})
    .then(() => UserEntryinstance.authorByName(name))
    .then((res) => {
      let _name = convertHex(res[0]), _email = convertHex(res[1])
      assert.equal(name, _name, "Not the same author")
      assert.equal(email, _email, "Emails not equal")
      assert.equal(true, res[2], "Registration not succesful")
    })
  })
  it("Should add a new book", () => {
    expect(() => {
      return UserEntryinstance.addBook(bookHash, title, thumbHash, {from: address})
    }).to.not.throw()
  })
  it("Should return our book by title", () => {
    return UserEntryinstance.getBookByTitle(title)
    .then(res  => {
      let _bookHash = convertHex(res[0]), _thumbHash = convertHex(res[1]), _title = convertHex(res[2]), _address = res[3]
      assert.equal(bookHash, _bookHash, "Not the same book")
      assert.equal(thumbHash, _thumbHash, "Wrong thumbnail")
      assert.equal(title, _title, "Not the same title")
      assert.equal(address, _address, "Not the same author")
    })
  })
  it("Should return an array of book Id's by the author name", () => {
    return UserEntryinstance.getBooksByAuthor(name)
    .then(res => {
      assert.typeOf(res[0], 'array')
      assert.equal(res[0][0], 0, "Book id not 0")
    })
  })
  it("Shoudl get a book by bookHash", () => {
    return UserEntryinstance.getBookByHash(bookHash)
    .then(res  => {
      let _bookHash = convertHex(res[0]), _thumbHash = convertHex(res[1]), _title = convertHex(res[2]), _address = res[3]
      assert.equal(bookHash, _bookHash, "Not the same book")
      assert.equal(thumbHash, _thumbHash, "Wrong thumbnail")
      assert.equal(title, _title, "Not the same title")
      assert.equal(address, _address, "Not the same author")
    })
  })
  it("Should remove ipfsStore", () => {
      return CMCinstance.removeContract("ipfsStore").then(() => {
        return CMCinstance.getContract.call("ipfsStore")
      }).then(res => {
        assert.equal(res, "0x0000000000000000000000000000000000000000", "Address should be 0x0")
      })
    })
  it("Should remove ipfsLogic", () => {
      return CMCinstance.removeContract("ipfsLogic").then(() => {
        return CMCinstance.getContract.call("ipfsLogic")
      }).then(res => {
        assert.equal(res, "0x0000000000000000000000000000000000000000", "Address should be 0x0")
      })
    })
  it("Should remove UserEntry", () => {
      return CMCinstance.removeContract("UserEntry").then(() => {
        return CMCinstance.getContract.call("UserEntry")
      }).then(res => {
        assert.equal(res, "0x0000000000000000000000000000000000000000", "Address should be 0x0")
      })
    })
  it("Should remove CMC", () => {
      expect(() => {
        return CMCinstance.kill()
      }).to.not.throw();
    })
})
