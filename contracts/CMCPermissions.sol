pragma solidity ^0.4.19;

import './CMCEnabled.sol';
import './ContractProvider.sol';

contract CMCPermissions is CMCEnabled {
    modifier isEntryPointEnabled {
        if (CMC != 0x0 && msg.sender != ContractProvider(CMC).contracts("entrypoint")) revert();
        _;
    }

    modifier isCMCEnabled(string _name) {
        if(CMC != 0x0 && msg.sender != ContractProvider(CMC).contracts(_name)) revert();
        _;
    }
}
