import 'dotenv/config';

import { ethers } from 'hardhat';

module.exports = async ({ getNamedAccounts, deployments, getChainId }: any) => {
  const { deploy, read, execute } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId = await getChainId();

  const worldId = "0x719683F13Eeea7D84fCBa5d7d17Bf82e03E3d260";
  const appId = "app_staging_20ad19bc247ebb95a2fe7023f096f13d";
  const actionId = "login";

  let contract = await deploy('ModelMarket', {
    from: deployer,
    log: true,
    args: [worldId, appId, actionId],
  });


};

module.exports.tags = ['ModelMarket'];
