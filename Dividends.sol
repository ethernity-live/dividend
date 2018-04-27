pragma solidity ^0.4.19;

    /****************************************************************
     * 
     * Genevieve Dividends sender
     * version 0.0.1
     * author: Juan Livingston & Fatima for Ethernity.live
     *
     ****************************************************************/

contract GXVCDividends {

    // data
    address public admin;
    address public owner;

    // Mapping to store balances
    mapping(address => uint256) public balances;

    // Constructor function with main constants and variables  
    function GXVCDividends() {
      admin = msg.sender;
      owner = 0x6890A532bC4a2659f36a9825c0e9d8b9522F1Fca;
    }

    // Modifier for authorized calls
    modifier onlyAdmin() {
        if ( msg.sender != owner && msg.sender != admin ) revert();
        _;
    }


    // Send dividends
    function payDividends(address _address , uint256 _amount) onlyAdmin returns (bool success) {
        require( balances[_address] == 0 );
        balances[_address] = _amount;
        require( _address.send(_amount) );
        return true;
    }


    function flushEthers () public onlyAdmin { // Send ether to collector
        require( owner.send( this.balance ) );
    }


    // This function can be called only by owner
    function changeOwner(address _newOwner) returns(bool) {
        if (msg.sender != owner) revert();
        owner = _newOwner;
        return true;
    }

    // This function can be called by owner or admin
    function changeAdmin(address _newAdmin) onlyAdmin returns(bool) {
        admin = _newAdmin;
        return true;
    }
}

