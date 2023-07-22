pragma solidity ^0.8.18;
import { IERC7007 } from "./interfaces/IERC7007.sol";
import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { Verifier } from "./VerifierBase.sol";

contract GMASS is Ownable, ERC721, IERC7007 {

    uint256 public counter;
    address public verifier;
    mapping(uint256 => string) public tokenURIs;

    constructor(address verifier) ERC721("GMASS", "GMASS") {
        verifier = verifier;
    }

    /**
     * @dev Mint token at `tokenId` given `promptCommitment`, `aigcData`, `uri` and `proof`.
     *
     * Requirements:
     * - `tokenId` must not exist.'
     * - verify(`promptCommitment`, `aigcData`, `proof`) must return true.
     *
     * Optional:
     * - `proof` should not include `aigcData` to save gas.
     */
    function mint(
        uint256 promptCommitment,
        uint256 aigcData,
        string calldata uri,
        bytes calldata proof,
        address to
    ) external override onlyOwner returns (uint256 tokenId) {
        require(_verify(promptCommitment, aigcData, proof), "Verification failed");
        _mint(to, counter);
        tokenURIs[counter] = uri;
        counter += 1;
        return counter;
    }

    /**
     * @dev Verify the `promptCommitment`, `aigcData` and `proof`.
     */
    function verify(
        uint256 promptCommitment,
        uint256 aigcData,
        bytes calldata proof
    ) external override view returns (bool success) {

        return _verify(promptCommitment, aigcData, proof);
    }

    function _verify(
        uint256 promptCommitment,
        uint256 aigcData,
        bytes calldata proof
    ) internal view returns (bool success) {
        uint256[] memory pubInputs = new uint256[](1);
        pubInputs[0] = promptCommitment;
        pubInputs[1] = aigcData;

        Verifier verifier = Verifier(verifier);
        return verifier.verify(pubInputs, proof);
    }
}
