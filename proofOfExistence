pragma solidity ^0.4.21;

    /*
    DogChain Initial Smart contract
    Consists of the Proof of Existence (dog identity and ownership) and Proof of Content (digital time capsule)
    
    Things to work on:
    - Proof of Content code
    - Determine what the exact data entries are going to be (currently a hash of: dog ID, user ID, dog info/medical info)
    - Do we need to add a 'watch' component to parse the blockchain for our posted events?
    - How to check to see if a dog already has an owner so a dog ID cannot have multiple owners? [could be solved via a comprehensive array on-chain or completely off-chain]
    - Determine what is the gas cost for running the contract (dependent on volume of data entered)
    - What is the maximum amount of data that would be allowed to be entered into the blockchain?
    */

contract DogChainPOE {
    
    // record event when a dog's record as been updated/changed
    event StoreRecordToBlockchain(uint transactionId, uint dogId);
    // 
    // event RecordValidation(uint transactionId);
    //
    //
    event CreatedDog(uint dogId);
    
    address contractOwner;
    
    // struct Dog {
    //     uint dogId;
    //     uint transactionId;
    // }
    
    // struct Human {
    //     uint humanId;
    //     Dog[] dogs;
    // }
    
    // assign dog to human owner (all related to off-chain database)
    mapping (uint => uint) private dogToHuman;
    // store latest transactionId (and therefore the latest record) to the appropriate dog Id
    mapping (uint => uint) private transactionIdToDog;
    // indicate whether the transaction Id referenced has been stored to the blockchain
    mapping (uint => bool) private validTransactionId;
    
    // All IDs will be stored and hashed off-chain
    // Entries into the smart contract will only come from the DogChain owned wallet
    
    // Constructor sets the address contacting the smart contract as the contract owner
    constructor() public {
            contractOwner = msg.sender;
        }
 
    // Maps a dog to its owner as long as the dog is not already created under that owner's ID
    function createDog(uint _dogId, uint _humanId) public onlyContractOwner {
        require(checkOwnership(_dogId, _humanId) == false); // how to check if the dog already has an owner? Thought: Create an array of all dogs created (off-chain or on-chain)
        dogToHuman[_dogId] = _humanId;
        emit CreatedDog(_dogId);
    }
 
    // Checks to see if the dog in question is actually owned by the person accessing the app
    function checkOwnership(uint _dogId, uint _humanId) public view onlyContractOwner returns(bool){
        return _humanId == dogToHuman[_dogId];
    }
 
    // store transaction Id to the correct dog ID, then store transaction Id as true
    function storeRecord(uint _transactionId, uint _dogId) private {
        validTransactionId[_transactionId] = true;
        transactionIdToDog[_transactionId] = _dogId;
    }
    
    // Enables the right owner for a certain dog to update that dog's info / tx Id hash
    function pushRecord(uint _transactionId, uint _dogId, uint _humanId) public {
        require(checkOwnership(_dogId, _humanId) == true); // how to we limit running this only to the correct dog owner?
        storeRecord(_transactionId, _dogId);
        emit StoreRecordToBlockchain(_transactionId, _dogId);
    }
    
    // Public Proof of Existence component: runs the recordExists function
    function checkTransactionId(uint _transactionId) public view returns(bool) {
        return recordExists(_transactionId);
    }
    
    // Private Proof of Existence component: checks if dog's info has been added to the blockchain
    function recordExists(uint _transactionId) private view returns(bool) {
        return validTransactionId[_transactionId];
    }
    
    // Requires that the address attempting to call this function is the contract owner
    // Otherwise function will fail to run
        modifier onlyContractOwner () {
        require(msg.sender == contractOwner);
        _;
    }
   
}
