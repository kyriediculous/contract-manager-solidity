const CMC = artifacts.require('./CMC');
const UserEntry = artifacts.require('./UserEntry');
const ipfsLogic = artifacts.require('./ipfsLogic');
const ipfsStore = artifacts.require('./ipfsStore')

module.exports = function(deployer) {
  deployer.deploy(CMC).then(() => {
    return deployer.deploy(UserEntry)
  }).then(()  => deployer.deploy(ipfsLogic))
  .then(()  => deployer.deploy(ipfsStore))
}
