const CMC = artifacts.require('./CMC')
const UserEntry = artifacts.require('./UserEntry')
const Controller = artifacts.require('./Controller');
const storage = artifacts.require('./Storage')

contract('CMC', () => {
  let CMCinstance, UserEntryinstance, Controllerinstance, Storageinstance, _x = 5
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
  it("Should add Controller to the register", () => {
    return Controller.deployed().then(instance => {
      Controllerinstance = instance
      expect(() => {
        return CMCinstance.addContract("Controller", Controllerinstance.address)
      }).to.not.throw()
    })
  })
  it("Should add Storage to the register", () => {
    return storage.deployed().then(instance => {
      Storageinstance = instance
      expect(() => {
        return CMCinstance.addContract("Storage", Storageinstance.address)
      }).to.not.throw()
    })
  })
  it("Should call setX and set it to 5", () => {
    return UserEntryinstance.setX(_x).then(() => {
      return Storageinstance.x.call()
    }).then(x => {
      assert.equal(x, _x, "numbers should be equal")
    })
  })
  it("Should remove Storage", () => {
    return CMCinstance.removeContract("Storage").then(() => {
      return CMCinstance.getContract.call("Storage")
    }).then(res => {
      assert.equal(res, "0x0000000000000000000000000000000000000000", "Address should be 0x0")
    })
  })
  it("Should remove Controller", () => {
    return CMCinstance.removeContract("Controller").then(() => {
      return CMCinstance.getContract.call("Controller")
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
})
