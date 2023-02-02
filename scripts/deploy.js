const WALLET_CONTRACT_NAME = process.env.WALLET_CONTRACT_NAME

async function main() {
  const WalletContract = await ethers.getContractFactory(WALLET_CONTRACT_NAME)
  const walletContract = await WalletContract.deploy()

  console.log("Wallet deployed to address:", walletContract.address)
}

main().catch(error => {
  console.log(error)
  process.exitCode = 1
})
