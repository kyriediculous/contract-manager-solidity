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
})
