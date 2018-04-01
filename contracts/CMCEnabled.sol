pragma solidity ^0.4.19;

import './Ownable.sol';

/**
 * Base class for every contract (DB, Controller, ALC,)
 * Once the CMC address being used by our newly added contract is set it can not be set again
**/

contract CMCEnabled {
    address CMC;

    function setCMCAddress(address _CMC) external returns (bool success) {
        if (CMC != 0x0 && msg.sender != CMC) {
            return false;
        } else {
            CMC = _CMC;
            return true;
        }
    }

    function kill() external {
        assert(msg.sender == CMC);
        selfdestruct(CMC);
    }
}
