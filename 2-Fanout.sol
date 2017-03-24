pragma solidity ^0.4.0;

contract FanOut {
    address[] public policyOwners;

    // This is the constructor whose code is
    // run only when the contract is created.
    function FanOut(address[] owners) {
        policyOwners = owners;
    }

    // This function is marked as "payable" so the Insured person
    // can send payments here and the value will be split up
    // among the policy owners and sent out.
    function makePolicyPayment() payable {
        
        // Get the number of owners
        uint ownerCount = policyOwners.length;

        // Get the amount to send to each ownerCount
        uint amountToSend = msg.value / ownerCount;

        // Loop over the owners
        for(uint i = 0; i < ownerCount; i++){

          // Send each owner the value
          policyOwners[i].send(amountToSend);
          
        }
    	
    }
}