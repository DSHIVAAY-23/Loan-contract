// Define the loan contract
contract LoanContract {
    
    // Define the variables
    address payable public borrower;
    uint public loanAmount;
    uint public interestRate;
    uint public repaymentTerm;
    uint public repaymentAmount;
    bool public paidBack;
    
    // Define the events
    event LoanCreated(address borrower, uint loanAmount);
    event RepaymentMade(address borrower, uint amount);
    
    // Constructor
    constructor(uint _loanAmount, uint _interestRate, uint _repaymentTerm) public payable {
        borrower = msg.sender;
        loanAmount = _loanAmount;
        interestRate = _interestRate;
        repaymentTerm = _repaymentTerm;
        repaymentAmount = loanAmount + ((loanAmount * interestRate) / 100);
        paidBack = false;
        emit LoanCreated(borrower, loanAmount);
    }
    
    // Repay the loan
    function repayLoan() public payable {
        require(msg.sender == borrower, "You are not authorized to make this payment.");
        require(!paidBack, "Loan has already been repaid.");
        require(msg.value == repaymentAmount, "Incorrect repayment amount.");
        borrower.transfer(msg.value);
        paidBack = true;
        emit RepaymentMade(borrower, msg.value);
    }
    
    // Get loan details
    function getLoanDetails() public view returns(address, uint, uint, uint, uint, bool) {
        return (borrower, loanAmount, interestRate, repaymentTerm, repaymentAmount, paidBack);
    }
}
