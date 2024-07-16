// SPDX-License-Identifier: BSL-1.1

pragma solidity ^0.8.0;

interface IImplementation {
    /// @dev To initialize a vault.
    function initialize(
        address _vaultManager
    ) external;
}
