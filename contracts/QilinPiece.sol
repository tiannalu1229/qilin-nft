pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract QilinPiece is Ownable, ERC721{

    uint256 public totalQty = 0;
    mapping (address => uint256) public minterToTokenId;

    uint256 public _totalSupply = 0;

    constructor(
        string memory name,
        string memory symbol,
        uint256 totalSupply_
    ) ERC721(name, symbol) {
        _totalSupply = totalSupply_;
    }

    function mintQilinPiece (address account) external {

        if (_totalSupply > 0) {
            require(totalQty < _totalSupply, "the piece is mint out!");
        }

        require(minterToTokenId[account] < 1, "you have owned this piece");

        uint256 tokenId = totalQty + 1;
        _safeMint(account, tokenId);

        minterToTokenId[account] = tokenId;
    }

    function transferFrom (
        address from,
        address to,
        uint256 tokenId
    ) override public {

        require(to == owner(), "transfer is banned");

        _transfer(from, to, tokenId);
    }

    function burn (uint256 tokenId) external onlyOwner {
        
        _burn(tokenId);
    } 

    function getHolder (address holder) external view returns (uint256) {
        
        return minterToTokenId[holder];
    }

    function setOwner (address owner) external onlyOwner {

        _transferOwnership(owner);
    }
}