const CMC = artifacts.require('./CMC');
const UserEntry = artifacts.require('./UserEntry');
const Controller = artifacts.require('./Controller');
const storage = artifacts.require('./Storage')

module.exports = function(deployer) {
  deployer.deploy(CMC).then(() => {
    return deployer.deploy(UserEntry)
  }).then(()  => deployer.deploy(Controller))
  .then(()  => deployer.deploy(storage))
}
