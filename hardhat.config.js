require("@nomicfoundation/hardhat-toolbox");
const dotenv =require("dotenv");

dotenv.config();

task("accounts", "Prints list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    sepolia: {
      url: process.env.REACT_APP_SEPOLIA_RPC_URL,
      accounts: [process.env.REACT_APP_PRIVATE_KEY]
    },
  },

  etherscan: {
    apiKey: process.env.REACT_APP_ETHERSCAN_KEY,
  }
};
