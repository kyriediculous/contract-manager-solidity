pragma solidity ^0.4.19;

//Import ownable from CMCEnabled too
import './CMCEnabled.sol';

contract contractManager is Ownable {
    mapping (string => address) contracts;

    function addContract(string _name, address _address) external {
      CMCEnabled _CMCEnabled = CMCEnabled(_address);
      require(_CMCEnabled.setCMCAddress(address(this)));
      contracts[_name] = _address;
    }

    function getContract(string _name) external view returns (address) {
      return contracts[_name];
    }

    function removeContract(string _name) external onlyOwner returns (bool) {
      if (contracts[_name] == 0x0) return false;
      contracts[_name] = 0x0;
      return true;
     }
}
