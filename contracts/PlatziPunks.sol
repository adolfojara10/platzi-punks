// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";

contract PlatziPunks is ERC721, ERC721Enumerable{

    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;

    uint256 public maxSupply;

    constructor(uint256 _maxSupply) ERC721("PlatziPunks", "PLPKS"){
        maxSupply = _maxSupply;
    }


    function mint() public{

        uint256 current = _idCounter.current();

        require(current<maxSupply, "No platzipunks left");
        _safeMint(msg.sender, current);
    }

    function tokenURI(uint256 tokenID) public view override returns(string memory){
        require(_exists(tokenID),"No existe el token");

        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{ "name": "PlatziPunks #',
                tokenID,
                '", "description": "Platzi Punks are randomized Avataaars stored on chain to teach DApp development on Platzi", "image": "',
                "// TODO: Calculate image URL",
                '"}'
            )
        );

        return string(abi.encodePacked("data:application/json;base64,", jsonURI));
    }


    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

}