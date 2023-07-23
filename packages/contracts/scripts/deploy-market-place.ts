import { log } from 'console';
import { config, ethers, hardhatArguments } from 'hardhat';

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
        connect(signer).
        deploy({
            gasLimit: 10000000,
            gasPrice: ethers.utils.parseUnits('31', 'gwei')
        });

    // wait for the transaction to be mined
    await modelMarket.deployed();

    // print the address
    console.log('ModelMarket deployed to: ', modelMarket.address);

}

main()