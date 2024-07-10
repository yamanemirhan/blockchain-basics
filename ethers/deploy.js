const ethers = require("ethers");
const fs = require("fs-extra");

async function main() {
  let provider = new ethers.JsonRpcProvider("HTTP://127.0.0.1:7545");
  let wallet = new ethers.Wallet(
    "0x562edeb6389e3aa1b3c7ee7b170512f579f80e1477bb55f891ad125fe12c98bf",
    provider
  );

  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf8"
  );

  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);

  console.log("Deploying, please wait...");

  const contract = await contractFactory.deploy();
  console.log("CONTRACT: ", contract);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
