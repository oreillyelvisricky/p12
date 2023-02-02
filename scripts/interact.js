const ethers = require("ethers")

const interactingLocally = true

const WALLET_CONTRACT_ARTIFACT_PATH = process.env.WALLET_CONTRACT_ARTIFACT_PATH
const WALLET_CONTRACT_ADDRESS = process.env.WALLET_CONTRACT_ADDRESS

const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY
const METAMASK_PKEY = process.env.METAMASK_PKEY

const LOCAL_PKEY = process.env.LOCAL_PKEY

let provider
let signer

if (interactingLocally) {
  provider = new ethers.providers.JsonRpcProvider()
  signer = new ethers.Wallet(LOCAL_PKEY, provider)
} else {
  provider = new ethers.providers.AlchemyProvider(network="goerli", ALCHEMY_API_KEY)
  signer = new ethers.Wallet(METAMASK_PKEY, provider)
}

const WalletContract = require(WALLET_CONTRACT_ARTIFACT_PATH)
const walletContract = new ethers.Contract(WALLET_CONTRACT_ADDRESS, WalletContract.abi, signer)

async function main() {
  console.log(">>> walletContract.test()")
  await walletContract.test(WALLET_CONTRACT_ADDRESS)
}

main().catch(error => {
  console.log(error)
  process.exitCode = 1
})

// LayersToMakeTransfer
walletContract.on("TestLogNumLayersToMakeTransfer", numLayersToMakeTransfer => {
  console.log("EVENT Wallet: TestLogNumLayersToMakeTransfer")
  console.log("numLayersToMakeTransfer:", numLayersToMakeTransfer)
})

walletContract.on("TestLogLayerToMakeTransfer", (layerNum, amountMin, amountMax, numTokens) => {
  console.log("EVENT Wallet: TestLogLayerToMakeTransfer")
  console.log("layerNum:", layerNum)
  console.log("amountMin:", amountMin)
  console.log("amountMax:", amountMax)
  console.log("numTokens:", numTokens)
})

// TransferLayers
walletContract.on("TestLogNumTransferLayers", numTransferLayers => {
  console.log("EVENT Wallet: TestLogNumTransferLayers")
  console.log("numTransferLayers:", numTransferLayers)
})

walletContract.on("TestLogTransferLayer", (transferNum, transferLayerNum, amountMin, amountMax, numTokens) => {
  console.log("EVENT Wallet: TestLogTransferLayer")
  console.log("transferNum:", transferNum)
  console.log("transferLayerNum:", transferLayerNum)
  console.log("amountMax:", amountMax)
  console.log("amountMin:", amountMin)
  console.log("numTokens:", numTokens)
})

// Transfers
walletContract.on("TestLogNumTransfers", numTransfers => {
  console.log("EVENT Wallet: TestLogNumTransfers")
  console.log("numTransfers:", numTransfers)
})

walletContract.on("TestLogTransfer", (transferNum, receiver, amount, transferLayersIndex, executed) => {
  console.log("EVENT Wallet: TestLogTransfer")
  console.log("transferNum:", transferNum)
  console.log("receiver:", receiver)
  console.log("amount:", amount)
  console.log("transferLayersIndex:", transferLayersIndex)
  console.log("executed:", executed)
})


/*
walletContract.on("LogTransferLayer", (numTransferLayers, numTransfers, amountMin, amountMax) => {
  console.log("EVENT Wallet: LogTransferLayer")
  console.log("numTransferLayers:", numTransferLayers)
  console.log("numTransfers:", numTransfers)
  console.log("amountMin:", amountMin)
  console.log("amountMax:", amountMax)
})

walletContract.on("LogTransferInQueue", (numTransferLayers, transferNum, receiver, amount, transferLayersIndex, executed) => {
  console.log("EVENT Wallet: LogTransferInQueue")

  console.log("numTransferLayers:", numTransferLayers)

  console.log("transferNum:", transferNum)
  console.log("reveiver:", receiver)
  console.log("amount:", amount)

  console.log("transferLayersIndex:", transferLayersIndex)

  console.log("executed:", executed)
})
*/
