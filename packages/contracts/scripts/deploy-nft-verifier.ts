import { log } from 'console';
import { config, ethers, hardhatArguments } from 'hardhat';

let newVerifier = false;
let verifierAddress = "0xA367EF8d08932CE8aB74b727c34a1dc654C1BFCF"
let marketAddress = "0x9D3157630Fc66D281E6Ff5381Cf82d1E528919bB"

async function main() {
    log('Hardhat Arguments: ');
    const signer = (await ethers.getSigners())[0];
    const address = await signer.getAddress();
    const chainId = await signer.getChainId();

    console.log('Signer Address: ', address);
    console.log('Chain ID: ', chainId);

    // get balance
    const balance = await signer.getBalance();
    console.log('Balance: ', ethers.utils.formatEther(balance));

    // get the contract builder
    const ModelMarket = await ethers.getContractFactory('ModelMarket');

    // deploy the contract
    const modelMarket = await ModelMarket.
        connect(signer).attach(marketAddress);

    // wait for the transaction to be mined
    await modelMarket.deployed();

    const Verifier = await ethers.getContractFactory('Verifier');
    let verifier;
    if (newVerifier) {
        verifier = await Verifier.
            connect(signer).
            deploy({
                gasLimit: 10000000,
                gasPrice: ethers.utils.parseUnits('31', 'gwei')
            });
        await verifier.deployed();
    } else {
    // deploy the contract
        verifier = await Verifier.    
            connect(signer).attach(verifierAddress);
    }


    // print the address
    console.log('Verifier deployed to: ', verifier.address);

    // get the contract builder
    modelMarket.deployModel(5, verifier.address, {
        gasLimit: 10000000,
        gasPrice: ethers.utils.parseUnits('31', 'gwei')
    }).then((gmass) => {
        console.log('ModelMarket deployed to: ', gmass);
    });
}

main()