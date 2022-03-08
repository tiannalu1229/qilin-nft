pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./QilinPiece.sol";

contract Qilin is Ownable, ERC721 {

    uint256 public totalQilinQty = 0;
    uint256 public constant TOTAL_QILIN_SUPPLY = 2022;

    address _pieceA;
    address _pieceB;
    address _pieceX;

    mapping (address => uint256) public whiteListA;
    mapping (address => uint256) public whiteListB;
    mapping (address => uint256) public whiteListX;

    constructor(
        address pieceA_,
        address pieceB_,
        address pieceX_,
        string memory name,
        string memory symbol
    ) ERC721(name, symbol) {
        _pieceA = pieceA_;
        _pieceB = pieceB_;
        _pieceX = pieceX_;
    }

    function mintQilin () external {
        require(totalQilinQty < TOTAL_QILIN_SUPPLY, "NTF is mint out!");

        QilinPiece a = QilinPiece(_pieceA);
        require(a.getHolder(msg.sender) > 0, "You need piece A!");
        uint256 tokenIdA = a.getHolder(msg.sender);

        QilinPiece b = QilinPiece(_pieceB);
        require(b.getHolder(msg.sender) > 0, "You need piece B!");
        uint256 tokenIdB = b.getHolder(msg.sender);

        QilinPiece x = QilinPiece(_pieceX);
        require(x.getHolder(msg.sender) > 0, "You need piece X!");
        uint256 tokenIdX = x.getHolder(msg.sender);

        a.transferFrom(msg.sender, address(this), tokenIdA);
        b.transferFrom(msg.sender, address(this), tokenIdB);
        x.transferFrom(msg.sender, address(this), tokenIdX);

        IERC721(_pieceA).getApproved(tokenIdA);
        IERC721(_pieceB).getApproved(tokenIdB);
        IERC721(_pieceX).getApproved(tokenIdX);

        a.burn(tokenIdA);
        b.burn(tokenIdB);
        x.burn(tokenIdX);

        _safeMint(msg.sender, totalQilinQty + 1);

        whiteListA[msg.sender] = 3;
        whiteListB[msg.sender] = 3;
        whiteListX[msg.sender] = 3;
    }

    function mintQilinPiece (uint256 piece) external {
        
        if (piece == 1) {

            require(whiteListA[msg.sender] == 1, "you can't mint piece A");

            QilinPiece a = QilinPiece(_pieceA);
            a.mintQilinPiece(msg.sender);
            whiteListA[msg.sender] = 2;
        } else if (piece == 2) {

            require(whiteListB[msg.sender] == 1, "you can't mint piece B");

            QilinPiece b = QilinPiece(_pieceB);
            b.mintQilinPiece(msg.sender);
            whiteListB[msg.sender] = 2;
        } else if (piece == 3) {

            require(whiteListX[msg.sender] == 1, "you can't mint piece X");

            QilinPiece x = QilinPiece(_pieceX);
            x.mintQilinPiece(msg.sender);
            whiteListX[msg.sender] = 2;
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

    function getStatus (address account) external view returns (uint256[3] memory) {

        return [whiteListA[account], whiteListB[account], whiteListX[account]];
    }

}