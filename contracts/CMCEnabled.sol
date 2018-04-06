pragma solidity ^0.4.19;

import './ContractProvider.sol';

/**
 * Base class for every contract (DB, Controller, ALC,)
 * Once the CMC address being used by our newly added contract is set it can not be set again except by our CMC contract
**/

contract CMCEnabled {
    address public CMC;

    modifier isCMCEnabled(bytes32 _name) {
        require(msg.sender == ContractProvider(CMC).contracts(_name));
        _;
    }

    function() external {
       revert();
    }

    function setCMCAddress(address _CMC) external {
        if (CMC != 0x0 && msg.sender != CMC) {
            revert();
        } else {
            CMC = _CMC;
        }
    }

    function changeCMCAddress(address _newCMC) external {
      require(CMC == msg.sender);
      CMC = _newCMC;
    }

    function kill() external {
        assert(msg.sender == CMC);
        selfdestruct(CMC);
    }
}
