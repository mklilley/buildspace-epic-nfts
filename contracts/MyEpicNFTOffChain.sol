// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract MyEpicNFTOffChain is ERC721URIStorage {
    // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // We need to pass the name of our NFTs token and its symbol.
    constructor() ERC721("ShaiHulud", "WORM") {
        console.log("I must not fear. Fear is the mind-killer.");
    }

    // A function our user will hit to get their NFT.
    function makeAnEpicNFT() public {
        // Get the current tokenId, this starts at 0.
        // _tokenIds is a state variable which means its value is stored
        // on the smart contract itself
        uint256 newItemId = _tokenIds.current();

        // Actually mint the NFT to the sender using msg.sender.
        // msg.sender is something that Solidity provides based on who is
        // calling the smart contract. You can't spoof this - someone has to
        // sign the call to the contract.
        _safeMint(msg.sender, newItemId);

        // Set the NFTs data.
        _setTokenURI(
            newItemId,
            "https://json.lilley.io/box_ec8adabf48f555297aea/61e582aa8e3b692a0c7ec350"
        );

        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        // Increment the counter for when the next NFT is minted.
        _tokenIds.increment();
    }
}
