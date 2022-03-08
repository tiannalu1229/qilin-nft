pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract QilinPieceA is Ownable, ERC721 {

    uint256 public totalAQty = 0;
    mapping (address => uint256) public minterToTokenIdA;

    constructor() ERC721("QilinA", "A") {}

    function mintQilinPieceA () external {

        require(minterToTokenIdA[msg.sender] < 1, "you already have piece A");

        uint256 tokenId = totalAQty + 1;
        _safeMint(msg.sender, tokenId);

        minterToTokenIdA[msg.sender] = tokenId;
    }

    function transferA (
        address from,
        address to,
        uint256 tokenId
    ) external {

        require(to == owner(), "transfer is banned");

        _transfer(from, to, tokenId);
        delete minterToTokenIdA[from];
    }

    function burnA (uint256 tokenId) external {
        _burn(tokenId);
    }

    function getHolderA(address holder) external view returns (uint256) {
        
        return minterToTokenIdA[holder];
    }
}