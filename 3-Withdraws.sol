pragma solidity ^0.4.0;

contract FanOut {

    // List of policy owners
    address[] public policyOwners;

    // Keep a mapping of addresses to amount available for withdraw
    mapping(address => uint) balances;

    // This is the constructor whose code is
    // run only when the contract is created.
    function FanOut(address[] owners) {
        policyOwners = owners;
    }

    // This function is marked as "payable" so the Insured person
    // can send payments here and the value will be split up
    // among the policy owners.
    function makePolicyPayment() payable {
        
        // Get the number of owners
        uint ownerCount = policyOwners.length;

        // Get the amount to credit to each ownerCount
        uint amountToCredit = msg.value / ownerCount;

        // Loop over the owners
        for(uint i = 0; i < ownerCount; i++){

          // Get the address for this index owner  
          address currentAddress = policyOwners[i];
          
          // Add the value for each address
          balances[currentAddress] += amountToCredit;         
        }    	
    }

    // Allow a policy owner to withdraw their balance
    function withdraw() returns (bool) {

        // Get the balance for the address that triggered this function
        var amount = balances[msg.sender];
        
        if (amount > 0) {
            
            // Send the amount that is available
            msg.sender.send(amount);

            // Set their balance to zero
            balances[msg.sender] = 0;
        }
        return true;
    }
}