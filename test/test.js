const CMC = artifacts.require('./CMC')
const UserEntry = artifacts.require('./UserEntry')

contract('CMC', () => {
  it("Should add a newly deployed contract (UserEntry) to the register", () => {
    let CMCinstance, UserEntryinstance
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
})
