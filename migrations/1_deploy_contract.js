const Qilin = artifacts.require("Qilin");
const QilinPieceA = artifacts.require("QilinPiece");
const QilinPieceB = artifacts.require("QilinPiece");
const QilinPieceX = artifacts.require("QilinPiece");

module.exports = async function (deployer) {
  
  var a, b, c;
  await deployer.deploy(QilinPieceA, "A", "A", 0).then(function(instance) {
    a = instance;
  })
  var aAddress = QilinPieceA.address;
  await deployer.deploy(QilinPieceB, "B", "B", 0).then(function(instance) {
    b = instance;
  })
  var bAddress = QilinPieceB.address;
  await deployer.deploy(QilinPieceX, "X", "X", 2022).then(function(instance) {
    x = instance;
  })
  var xAddress = QilinPieceX.address;
  await deployer.deploy(Qilin, aAddress, bAddress, xAddress, "Qilin", "Qilin");

  await a.setOwner(Qilin.address)
  await b.setOwner(Qilin.address)
  await c.setOwner(Qilin.address)
};
