pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract QilinPieceB is Ownable, ERC721 {

    uint256 public totalBQty = 0;
    mapping (address => uint256) public minterToTokenIdB;

    constructor() ERC721("QilinB", "B") {}

    function mintQilinPieceB () external {
        
        require(minterToTokenIdB[msg.sender] < 1, "you already have piece B");

        uint256 tokenId = totalBQty + 1;
        _safeMint(msg.sender, tokenId);

        minterToTokenIdB[msg.sender] = tokenId;
    }

    function transferB (
        address from,
        address to,
        uint256 tokenId
    ) external {

        require(to == owner(), "transfer is banned");

        _transfer(from, to, tokenId);
        delete minterToTokenIdB[from];
    }

    function burnB (uint256 tokenId) external {
        _burn(tokenId);
    }

    function getHolderB(address owner) external view returns (uint256) {
        return minterToTokenIdB[owner];
    }
}