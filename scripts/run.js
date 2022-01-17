const main = async () => {
  // Compile the smart contract with name MyEpicNFT.sol in the contracts folder
  // and put some files in the artifacts directory
  const nftContractFactory = await hre.ethers.getContractFactory("MyEpicNFT");
  // Create a local ethereum network just for this contract. Network gets destroyed
  // after this script is finished
  const nftContract = await nftContractFactory.deploy();
  // Wait until the contract has been "mined"
  await nftContract.deployed();
  console.log("Contract deployed to:", nftContract.address);

  // Call the function.
  let txn = await nftContract.makeAnEpicNFT();
  // Wait for it to be mined.
  await txn.wait();

  // Mint another NFT for fun.
  txn = await nftContract.makeAnEpicNFT();
  // Wait for it to be mined.
  await txn.wait();
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
