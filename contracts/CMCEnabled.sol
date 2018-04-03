pragma solidity ^0.4.19;

import './ContractProvider.sol';

/**
 * Base class for every contract (DB, Controller, ALC,)
 * Once the CMC address being used by our newly added contract is set it can not be set again
**/

contract CMCEnabled {
    address public CMC;

    modifier isCMCEnabled(bytes32 _name) {
        if(CMC == 0x0 && msg.sender != ContractProvider(CMC).contracts(_name)) revert();
        _;
    }

    function setCMCAddress(address _CMC) external {
        if (CMC != 0x0 && msg.sender != CMC) {
            revert();
        } else {
            CMC = _CMC;
        }
    }

    function kill() external {
        assert(msg.sender == CMC);
        selfdestruct(CMC);
    }
}
