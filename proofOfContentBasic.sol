pragma solidity ^0.4.21;
contract DogChainPOC {
    string public currentText = "";
    address owner = msg.sender;
    uint private maxLength = 50;
    
    function setText(string _newText) public returns (bool) {
        if (bytes(_newText).length < maxLength) {
            currentText = _newText;
            return true;
        } else {
            return false;
        }
    }
}
