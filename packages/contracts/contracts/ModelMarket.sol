pragma solidity ^0.8.18;
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {GMASS} from "./GMASS.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";


contract ModelMarket is Ownable {
    using ECDSA for bytes32;

    mapping(address => uint256) public balances;
    mapping(address => uint256) public prices;
    mapping (address => bool) freeMinted;

    constructor() {}

    /**
     * @dev Deposit ETH to the contract
     */
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    /**
     * @dev Withdraw ETH from the contract
     */
    function withdraw() external {
        // require(balances[msg.sender] > 0, "Insufficient balance");
        uint256 balance = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(balance);
    }

    function getBalance(address _user) external view returns (uint256) {
        return balances[_user];
    }


    function delployModel(uint256 price, address verifier) external onlyOwner {
        address newModel = address(new GMASS(verifier));
        prices[newModel] = price;
    }


    function freeMint(
        address _model, 
        uint256 promptCommitment,
        uint256 aigcData,
        string calldata uri, 
        bytes calldata proof,
        address to
    ) external onlyOwner {
        freeMinted[to] = true;  
        GMASS(_model).mint(promptCommitment, aigcData, uri, proof, to);
    }

    function mintGMASS(
        address _model, 
        uint256 promptCommitment,
        uint256 aigcData,
        string calldata uri, 
        bytes calldata proof,
        bytes memory signedPrompt,
        address to
    ) external payable onlyOwner {
        require(balances[to] >= prices[_model], "Insufficient payment");
        bytes32 _hash = keccak256(abi.encodePacked(promptCommitment));
        require(to == ECDSA.toEthSignedMessageHash(_hash).recover(signedPrompt));

        payable(msg.sender).transfer(prices[_model]);
        balances[to] -= prices[_model];
        
        GMASS(_model).mint(promptCommitment, aigcData, uri, proof, to);
    }





}