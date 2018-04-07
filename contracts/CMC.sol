pragma solidity ^0.4.19;

import './CMCEnabled.sol';
import './Ownable.sol';

contract CMC is Ownable {
    mapping (bytes32 => address) public contracts;

    function addContract(bytes32 _name, address _address) onlyOwner external {
      CMCEnabled _CMCEnabled = CMCEnabled(_address);
      _CMCEnabled.setCMCAddress(address(this));
      contracts[_name] = _address;
    }

    function getContract(bytes32 _name) external view returns (address) {
      return contracts[_name];
    }

    function removeContract(bytes32 _name) external onlyOwner returns (bool) {
      require(contracts[_name] != 0x0);
      CMCEnabled _CMCEnabled = CMCEnabled(contracts[_name]);
      _CMCEnabled.kill();
      contracts[_name] = 0x0;
    }

    function changeContractCMC(bytes32 _name, address _newCMC) external onlyOwner {
      CMCEnabled _CMCEnabled = CMCEnabled(contracts[_name]);
      _CMCEnabled.changeCMCAddress(_newCMC);
    }

    function kill() external onlyOwner {
      selfdestruct(owner);
    }
}
