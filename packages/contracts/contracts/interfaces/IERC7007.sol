pragma solidity ^0.8.18;

// import ERC165 from openzeppelin
import { IERC165 } from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

/**
 * @dev Required interface of an ERC7007 compliant contract.
 */
interface IERC7007 is IERC165 {
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
        uint256 prompt,
        uint256 aigcData,
        string calldata uri,
        bytes calldata proof,
        address to
    ) external returns (uint256 tokenId);

    /**
     * @dev Verify the `prompt`, `aigcData` and `proof`.
     */
    function verify(
        uint256 prompt,
        uint256 aigcData,
        bytes calldata proof
    ) external view returns (bool success);
}
