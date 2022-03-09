const { providers, Contract, Wallet, utils, BigNumber } = require('ethers');
const { abi, address, providerAddress, privateKey } = require('./config');

async function doTest() {
    let overrides = {
        gasLimit: 10000000,
        gasPrice: utils.parseUnits('20.0', 'gwei'),
    };

    let provider = new providers.JsonRpcProvider(providerAddress);
    let wallet = new Wallet(privateKey, provider);
    let network = "4"

    let Qilin = new Contract(address(network, 'Qilin'), abi('Qilin'), provider).connect(wallet);

    /* ---------------------------------------------------------------------------------------- */
    console.log("1")
    let result = await Qilin.setWhiteList("0x0bb328ABb7a2d948532Ab098e80aa5936993055a", 1, overrides);
    console.log("2")
    await Qilin.setWhiteList("0x0bb328ABb7a2d948532Ab098e80aa5936993055a", 2, overrides);
    await Qilin.setWhiteList("0x0bb328ABb7a2d948532Ab098e80aa5936993055a", 3, overrides);
}

async function test() {
    try {
        await doTest()
    } catch (e) {
        console.error(e)
    }
}

test()