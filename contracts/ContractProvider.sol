pragma solidity ^0.4.19;

contract ContractProvider {
    function contracts(bytes32 _name) external returns (address);
}
