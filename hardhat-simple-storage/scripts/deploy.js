const { ethers, run, network } = require("hardhat");

async function main() {
  const SimpleStorageFactory = await ethers.getContractFactory("SimpleStorage");
  console.log("Deploying the contract...");

  const simpleStorage = await SimpleStorageFactory.deploy();
  await simpleStorage.waitForDeployment();
  console.log("Deployed contract to: ", simpleStorage.target);

  // verifying contract
  // we can use chainId to figure out which one is a test net or a live network
  console.log("NETWORK CONFIG: ", network.config);
  // sepolia testnet chainId: 11155111
  if (network.config.chainId === 11155111 && process.env.ETHERSCAN_API_KEY) {
    await simpleStorage.deploymentTransaction().wait(6);
    await verify(simpleStorage.target, []);
  }
}

async function verify(contractAddress, args) {
  console.log("Verifying the contract...");
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
    });
  } catch (error) {
    if (error.message.toLowerCase().includes("already verified")) {
      console.log("Already Verified");
    } else {
      console.error(error);
    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });
