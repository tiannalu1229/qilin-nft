pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./QilinPieceA.sol";
import "./QilinPieceB.sol";
import "./QilinPieceX.sol";

contract Qilin is Ownable, ERC721 {

    uint256 public totalQilinQty = 0;
    uint256 public constant TOTAL_QILIN_SUPPLY = 2022;

    mapping (address => uint256) public whiteListA;
    mapping (address => uint256) public whiteListB;
    mapping (address => uint256) public whiteListX;

    constructor() ERC721("Qilin", "Qilin") {}


    function mintQilin () external {
        require(totalQilinQty < TOTAL_QILIN_SUPPLY, "NTF is mint out!");

        QilinPieceA a = new QilinPieceA();
        require(a.getHolderA(msg.sender) > 0, "You need piece A!");
        uint256 tokenIdA = a.getHolderA(msg.sender);

        QilinPieceB b = new QilinPieceB();
        require(b.getHolderB(msg.sender) > 0, "You need piece B!");
        uint256 tokenIdB = b.getHolderB(msg.sender);

        QilinPieceX x = new QilinPieceX();
        require(x.getHolderX(msg.sender) > 0, "You need piece X!");
        uint256 tokenIdX = x.getHolderX(msg.sender);

        a.transferA(msg.sender, owner(), tokenIdA);
        b.transferB(msg.sender, owner(), tokenIdB);
        x.transferX(msg.sender, owner(), tokenIdX);
        _safeMint(msg.sender, totalQilinQty + 1);
    }

    function mintQilinPiece (uint256 piece) external {
        
        if (piece == 1) {
            QilinPieceA a = new QilinPieceA();
            a.mintQilinPieceA();
        } else if (piece == 2) {
            QilinPieceB b = new QilinPieceB();
            b.mintQilinPieceB();
        } else if (piece == 3) {
            QilinPieceX x = new QilinPieceX();
            x.mintQilinPieceX();
        }
    }

    function setWhiteList (address whiteLister, uint256 piece) external onlyOwner {

        if (piece == 1) {

            require(whiteListA[whiteLister] < 1, "the address is already in white list A");
            whiteListA[whiteLister] = 1;

        } else if (piece == 2) {

            require(whiteListB[whiteLister] < 1, "the address is already in white list B");
            whiteListB[whiteLister] = 1;

        } else if (piece == 3) {

            require(whiteListX[whiteLister] < 1, "the address is already in white list X");
            whiteListX[whiteLister] = 1;

        }
    }

}