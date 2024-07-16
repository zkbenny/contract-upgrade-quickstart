// SPDX-License-Identifier: BSL-1.1

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";

contract  MockBeacon is UpgradeableBeacon {

    constructor(address implementation_) UpgradeableBeacon(implementation_) {
    }
}
