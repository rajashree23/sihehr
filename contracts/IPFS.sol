pragma solidity >=0.4.21 <0.7.0;

contract IPFS {
    struct Key{
        string encryptedKey;
    }
    // struct Keys {
    //     string ipfsHash;
    //   mapping(address => Key) encryptedkey;
    // }
    struct Pat {
        address patient;
        bytes32[] ipfs;
    }
    mapping(bytes32 => mapping(address => bytes32) ) public key;
    mapping(address => Pat) public patients;

    function sendIPFS(
        bytes32 hash,
        address patient,
        bytes32 aeskey
    ) public {
        if (patients[patient].patient==address(0))
        {
              patients[patient] = Pat(patient, new bytes32[](0));
              patients[patient].ipfs.push(hash);
            //   key[hash].ipfsHash = hash;
              key[hash][patient] = aeskey;
        }
        else
        {
         patients[patient].ipfs.push(hash);
        //  key[hash].ipfsHash = hash;
         key[hash][patient] = aeskey;

        
        }
    }
    function retriveKey(bytes32 hash)
        public
        view
        returns (bytes32)
    {

        return  key[hash][msg.sender];
    }
    function createPermission(bytes32 hash, bytes32 aeskey,address user)
        public
    {
        key[hash][user] = aeskey;
    }

      function removePermission(bytes32 hash, address user)
        public
    {
        key[hash][user] = "";
    }
     function recordcount(address patient) public view  returns(uint ){
           return patients[patient].ipfs.length;
     }
     function record(uint z,address patient) public view returns(bytes32 ){
     //   return patients[msg.sender].record[z];
             return patients[patient].ipfs[z];
     }

}
