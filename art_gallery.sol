//SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.7.0 <0.9.0;

contract ArtGallery {
    uint256 counter = 0;
    struct Art {
        string artName;
        uint256 artPrice;
        address artCreater;
        address artHolder;
        bool boughtStatus;
    }
    
    mapping(uint256 => Art) artCollec;
    
    function addArt(string memory _artName, uint256 _artPrice) public {
        uint256 _uniqueId = counter + 1;
        artCollec[_uniqueId].artName = _artName;
        artCollec[_uniqueId].artPrice = _artPrice;
        artCollec[_uniqueId].artCreater = msg.sender;
        artCollec[_uniqueId].boughtStatus = false;
    }
    
    function bidArt(uint256 _artId) payable public {
        require(artCollec[_artId].boughtStatus == false  , "Art not available for bid");
        
        require(msg.value == artCollec[_artId].artPrice , "Bid Price cannot be lower than art price");
        
        payable (artCollec[_artId].artCreater).transfer(artCollec[_artId].artPrice);
        
        artCollec[_artId].boughtStatus = true;
        artCollec[_artId].artHolder = msg.sender;
    }
}
