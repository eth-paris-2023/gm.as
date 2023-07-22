pragma solidity ^0.8.18;

// import IERC7007
import { IERC7007 } from "./interfaces/IERC7007.sol";

contract ERC7007 is IERC7007 {
    /**
     * @dev Emitted when `tokenId` token is minted.
     */
    event Mint(uint256 indexed tokenId, bytes indexed prompt, bytes indexed aigcData, string uri, bytes proof);

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
    ) external returns (uint256 tokenId) {
        // TODO: implement
    };

    /**
     * @dev Verify the `prompt`, `aigcData` and `proof`.
     */
    function verify(
        bytes calldata prompt,
        bytes calldata aigcData,
        bytes calldata proof
    ) external view returns (bool success) {
        // TODO: implement
    };
}
