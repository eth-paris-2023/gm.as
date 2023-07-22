import 'dotenv/config';

import { BigNumber, BigNumberish, Contract } from 'ethers';
import { deployments, ethers } from 'hardhat';

import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { ModelMarket } from '../typechain';
import { expect } from 'chai';
import { Verifier } from '../typechain/contracts/VerifierBase.sol';

let owner: SignerWithAddress;
let user1: SignerWithAddress;
let market: ModelMarket;
let verifier: Verifier;


async function getContract(contractName: string) {
  return await ethers.getContractAt(contractName, (await deployments.get(contractName)).address);
}

describe('ModelMarket', function () {
  beforeEach(async function () {
    // Get Signers
    [owner, user1] = await ethers.getSigners();


    // Deploy Contracts
    await deployments.fixture(['ModelMarket',"VerifierBase"]);

    // Get Contracts
    market = (await getContract('ModelMarket')) as ModelMarket;
    verifier = (await getContract('Verifier')) as Verifier;
    
  });

  it('market should deploy', async function () {
    expect(market.address).to.not.equal(0);
  });

  it('verifier should deploy', async function () {
    expect(verifier.address).to.not.equal(0);
  });

});

