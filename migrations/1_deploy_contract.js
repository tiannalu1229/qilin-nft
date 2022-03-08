const Qilin = artifacts.require("Qilin");
const QilinPieceA = artifacts.require("QilinPiece");
const QilinPieceB = artifacts.require("QilinPiece");
const QilinPieceX = artifacts.require("QilinPiece");

module.exports = async function (deployer) {
  var a, b, x;
  await deployer.deploy(QilinPieceA, "A", "A", 0).then(function (instance) {
    a = instance
  });
  await deployer.deploy(QilinPieceB, "B", "B", 0).then(function (instance) {
    b = instance
  });
  await deployer.deploy(QilinPieceX, "X", "X", 2022).then(function (instance) {
    x = instance
  });
  await deployer.deploy(Qilin, QilinPieceA.address, QilinPieceB.address, QilinPieceX.address, "Qilin", "Qilin");

  await a.setOwner(Qilin.address);
  await b.setOwner(Qilin.address);
  await x.setOwner(Qilin.address);
};
