// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.27;

library SafeMath { 
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
      assert(b <= a);
      return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
      uint256 c = a + b;
      assert(c >= a);
      return c;
    }
}

contract MaazToken {

    string public constant tokenName = "muaz"; // public creates a getter function for any variable
    string public constant symbol  =    "MA" ;
    uint256 public constant decimals =   18  ;
    
    event Allowance(address indexed tokenOwner, address indexed spender, uint tokenAmount);
    event Transfer(address indexed from, address indexed to, uint tokenAmount);

    address ownerCon;
    using SafeMath for uint256;

    modifier onlyMaaz {
        require (msg.sender == ownerCon);
        _;
    }
    
    mapping(address => uint256)balances;
    //the address will hold number of tokens

    mapping(address =>mapping(address => uint256))allowed;
    //nest mapping, there are two keys and one value

    uint256 public totalSupply_;

 constructor(uint256 total) {   //to deposit all the tokens in owner's account
     totalSupply_ = total;
     balances[msg.sender] = total;
     ownerCon = msg.sender;

    }

    function balanceOf(address inputAddress) public view returns(uint256) {
        return balances[inputAddress];
    // to get balances of any address  //getter function
        } 

    function transfer(uint256 amount,  address transferTo) public returns(bool) {
        require(amount <= balances[msg.sender], "no balance in account");
        balances[msg.sender] = balances[msg.sender].sub(amount);
        balances[transferTo] = balances[transferTo].add(amount);
        emit Transfer(msg.sender, transferTo, amount);
        return true;
         
    }

    function approve(address approvedAdd, uint256 amount) public returns(bool) {
        allowed[msg.sender][approvedAdd] = amount;
        emit Allowance(msg.sender, approvedAdd, amount);
        return true;
    }
    
    function allowance(address approvedAdd, address owner) public view returns (uint256) {
        return allowed[owner][approvedAdd];

    }
    function transferFrom(address owner, address transferTo, uint256 amount) public returns(bool) {
        require(amount <= balances[owner], "not sufficient funds");
        require(amount <= allowed[owner][msg.sender]) ;
     
        balances[owner] = balances[owner].sub(amount);
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(amount);
        balances[transferTo] = balances[transferTo].add(amount);
        emit Allowance(owner, msg.sender, amount);
        return true;

    }

    }




    






