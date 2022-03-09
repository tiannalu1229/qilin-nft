const Qilin = artifacts.require("Qilin");
const QilinPieceA = artifacts.require("QilinPiece");
const QilinPieceB = artifacts.require("QilinPiece");
const QilinPieceX = artifacts.require("QilinPiece");

module.exports = async function (deployer) {
  
  await deployer.deploy(QilinPieceA, "A", "A", 0)
  await deployer.deploy(QilinPieceB, "B", "B", 0)
  await deployer.deploy(QilinPieceX, "X", "X", 2022)
  await deployer.deploy(Qilin, QilinPieceA.address, QilinPieceB.address, QilinPieceX.address, "Qilin", "Qilin");


  await QilinPieceA.deployed().then(async function(instance) {
    await instance.setOwner(Qilin.address)
  })

  await QilinPieceB.deployed().then(async function(instance) {
    await instance.setOwner(Qilin.address)
  })

  await QilinPieceX.deployed().then(async function(instance) {
    await instance.setOwner(Qilin.address)
  })
};
