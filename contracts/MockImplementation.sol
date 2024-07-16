// SPDX-License-Identifier: BSL-1.1

pragma solidity ^0.8.0;

import "./IImplementation.sol";

contract  MockImplementation is IImplementation {
    address public vaultManager;

    event VaultManagerUpdate(
        address indexed vaultManager
    );

    /// @dev To initialize a vault.
    function initialize(
        address _vaultManager
    ) external {
        vaultManager = _vaultManager;
        emit VaultManagerUpdate(_vaultManager);
    }
}
