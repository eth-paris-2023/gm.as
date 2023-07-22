pragma solidity ^0.8.18;

// import IERC7007
import { ERC7007 } from "./ERC7007.sol";
// import erc721
import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract GMASS is ERC721, ERC7007 {
    constructor() ERC721("GMASS", "GMASS") {}

    /**
     * @dev Mint token at `tokenId` given `prompt`, `aigcData`, `uri` and `proof`.
     *
     * Requirements:
     * - `tokenId` must not exist.'
     * - verify(`prompt`, `aigcData`, `proof`) must return true.
     *
     * Optional:
     * - `proof` should not include `aigcData` to save gas.
     */
    function mint(
        bytes calldata prompt,
        bytes calldata aigcData,
        string calldata uri,
        bytes calldata proof
    ) external override returns (uint256 tokenId) {
        // TODO: Call verify before minting token

        // TODO: Create a counter to increase tokenId every mint
        _mint(msg.sender, tokenId);
    }
}
