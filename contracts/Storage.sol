pragma solidity ^0.4.19;

import './CMCEnabled.sol';

contract Storage is CMCEnabled {
  uint x;

  function setX(uint _x) external isCMCEnabled("Storage") {
    x = _x;
  }
}
