//Define Solidity ver.
pragma solidity =0.8.6;

contract Trust {
        struct Kid {
            uint amount;
            uint maturity;
            bool paid;
            
            
        }
    mapping(address => Kid) public kids;
    
    address public admin;
    
    constructor() {
        admin = msg.sender;
    }
    
    
    function addkid(address kid, uint timeToMaturity) external payable {
        require(msg.sender == admin, 'only admin');
        require(kids[msg.sender].amount == 0, 'Kid already exist');
        kids[kid] = Kid(msg.value, block.timestamp + timeToMaturity, false);
        
        
    }
        
    
    function withdraw() external {
        Kid storage kid = kids[msg.sender];
        require(kid.maturity <= block.timestamp, 'Too early');
        require(kid.amount > 0, 'Only kid can withdraw');
        require(kid.paid == false, 'dont steal money!');
        kid.paid = true;
        payable(msg.sender).transfer(kid.amount);
        
        
    }
}