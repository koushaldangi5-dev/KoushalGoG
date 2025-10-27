const hre = require("hardhat");

async function main() {
  const CryptexaLabs = await hre.ethers.getContractFactory("CryptexaLabs");
  const cryptexaLabs = await CryptexaLabs.deploy();

  await cryptexaLabs.waitForDeployment();
  console.log("✅ CryptexaLabs deployed to:", await cryptexaLabs.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Deployment failed:", error);
    process.exit(1);
  });
