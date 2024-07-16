import {deployContract, getWallet} from "./utils";
import {HardhatRuntimeEnvironment} from "hardhat/types";
import {Deployer} from "@matterlabs/hardhat-zksync";

// An example of a basic deploy script
// It will deploy a Greeter contract to selected network
// as well as verify it on Block Explorer if possible for the network
export default async function (hre: HardhatRuntimeEnvironment) {
  const implArtifactName = "MockImplementation";
  const implContract = await deployContract(implArtifactName, []);

  const beaconArtifactName = "MockBeacon";
  const constructorArguments = [await implContract.getAddress()];
  const beaconContract = await deployContract(beaconArtifactName, constructorArguments);
  const beaconAddr = await beaconContract.getAddress();

  const wallet = getWallet();
  const deployer = new Deployer(hre, wallet);
  const vrArtifact = await deployer.loadArtifact("VaultRegistry");
  const vr = await hre.zkUpgrades.deployProxy(
      getWallet(),
      vrArtifact,
      [],
      { initializer: 'initialize' }
  );

  await vr.waitForDeployment();

  const tx = await vr.createVault(beaconAddr, wallet.address);
  console.log('CreateVault tx: ', tx.hash);
}
