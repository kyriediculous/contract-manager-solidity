pragma solidity ^0.4.19;

import './CMCEnabled.sol';
import './Ownable.sol';

contract contractManager is Ownable {
    mapping (bytes32 => address) public contracts;

    function addContract(bytes32 _name, address _address) external {
      CMCEnabled _CMCEnabled = CMCEnabled(_address);
      _CMCEnabled.setCMCAddress(address(this));
      contracts[_name] = _address;
    }

    function getContract(bytes32 _name) external view returns (address) {
        return contracts[_name];
    }

    function removeContract(bytes32 _name) external onlyOwner returns (bool) {
        if (contracts[_name] == 0x0) return false;
         contracts[_name] = 0x0;
         return true;
    }
}
