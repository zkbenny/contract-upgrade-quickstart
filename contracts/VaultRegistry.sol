// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

// Proxy Support
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

// Beacon support
import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";

import "./IImplementation.sol";

/// @title A registry for vaults
/// @author Steer Protocol
/// @dev All vaults are created through this contract
contract VaultRegistry is Initializable, UUPSUpgradeable
{
    /// @dev Vault creation event
    /// @param deployer The address of the deployer
    /// @param vault The address of the vault
    event VaultCreated(
        address deployer,
        address vault
    );

    /// @dev intializes the vault registry
    function initialize(
    ) public initializer {
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override {}

    /// @dev Creates a new vault with the given strategy
    function createVault(
        address beaconAddress,
        address _vaultManager
    ) external returns (address) {
        // Make sure that we have a beacon for the provided vault type
        // This ensures that a bad vault type hasn't been provided
        require(beaconAddress != address(0), "Beacon is not present");
        // Create new vault implementation
        BeaconProxy newVault = new BeaconProxy(
            beaconAddress,
            abi.encodeWithSelector(
                IImplementation.initialize.selector,
                _vaultManager
            )
        );

        // Emit vault details
        emit VaultCreated(
            msg.sender,
            address(newVault)
        );

        // Return the address of the new vault
        return address(newVault);
    }
}
