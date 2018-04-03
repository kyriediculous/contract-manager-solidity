pragma solidity ^0.4.19;

import './CMCEnabled.sol';

import './Storage.sol';

contract Controller is CMCEnabled {
  function setX(uint _x) external isCMCEnabled("UserEntry") {
    Storage(ContractProvider(CMC).contracts("Storage")).setX(_x);
  }
}
