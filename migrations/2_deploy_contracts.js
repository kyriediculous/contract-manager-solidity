const CMC = artifacts.require('./CMC');
const UserEntry = artifacts.require('./UserEntry');

module.exports = function(deployer) {
  deployer.deploy(CMC).then(() => {
    return deployer.deploy(UserEntry)
  })
}
