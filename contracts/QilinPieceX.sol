pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract QilinPieceX is Ownable, ERC721 {

    uint256 public constant TOTAL_X_SUPPLY = 2022;

    uint256 public totalXQty = 0;
    mapping (address => uint256) public mintRecordX;

    constructor() ERC721("QilinX", "X") {}

    function mintQilinPieceX () external {

        require(totalXQty < TOTAL_X_SUPPLY, "piece X is sold out!");
        require(mintRecordX[msg.sender] < 1, "you already have piece B");

        uint256 tokenId = totalXQty + 1;
        _safeMint(msg.sender, tokenId);

        mintRecordX[msg.sender] = tokenId;

    }

    function transferX (
        address from,
        address to,
        uint256 tokenId
    ) external {

        require(to == owner(), "transfer is banned");

        _transfer(from, to, tokenId);
        delete mintRecordX[from];
    }

    function burnX (uint256 tokenId) external {
        _burn(tokenId);
    }

    function getHolderX(address owner) external view returns (uint256) {
        return mintRecordX[owner];
    }
}