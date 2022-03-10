pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract QilinPiece is Ownable, ERC721{

    uint256 public totalQty = 0;

    mapping (address => uint256) public minterToTokenId;

    uint256 public _totalSupply = 0;
    string private _tokenURI;

    constructor(
        string memory name,
        string memory symbol,
        string memory tokenURI_,
        uint256 totalSupply_
    ) ERC721(name, symbol) {
        _totalSupply = totalSupply_;
        _tokenURI = tokenURI_;
    }

    function mintQilinPiece (address account) external onlyOwner {

        if (_totalSupply > 0) {
            require(totalQty < _totalSupply, "the piece is mint out!");
        }

        require(minterToTokenId[account] < 1, "you have owned this piece");

        uint256 tokenId = totalQty + 1;
        totalQty += 1;
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

    function safeTransferFrom (
        address from,
        address to,
        uint256 tokenId
    ) override public {

        require(to == owner(), "transfer is banned");
        safeTransferFrom(from, to, tokenId, "");
    }

    function safeTransferFrom (
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) override public {

        require(to == owner(), "transfer is banned");
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        _safeTransfer(from, to, tokenId, _data);
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

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        
        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI)) : "";
    }

    function _baseURI() override internal view virtual returns (string memory) {

        return _tokenURI;
    }
}