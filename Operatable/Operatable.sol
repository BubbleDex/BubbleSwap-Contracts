
// File: @openzeppelin/contracts/utils/Context.sol



pragma solidity >=0.6.0 <0.8.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol



pragma solidity ^0.7.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

   address public pendingOwner;

 function renounceOwnership() public onlyOwner {
 _owner = address(0);
 pendingOwner = address(0);
 emit OwnershipTransferred(_owner, address(0));
 }

 function transferOwnership(address newOwner) public onlyOwner {
 require(address(0) != newOwner, "pendingOwner set to the zero address.");
 pendingOwner = newOwner;
} 
function claimOwnership() public {
 require(msg.sender == pendingOwner, "caller != pending owner");

 _owner = pendingOwner;
 pendingOwner = address(0);
 emit OwnershipTransferred(_owner, pendingOwner);
}

// File: @sheepdex/core/contracts/lib/Operatable.sol


pragma solidity =0.7.6;


// seperate owner and operator, operator is for daily devops, only owner can update operator
contract Operatable is Ownable {
    address public operator;

    event SetOperator(address indexed oldOperator, address indexed newOperator);

    constructor(){
        operator = msg.sender;
        emit SetOperator(address(0), operator);
    }

    modifier onlyOperator() {
        require(msg.sender == operator, 'not operator');
        _;
    }

    function setOperator(address newOperator) public onlyOwner {
        require(newOperator != address(0), 'bad new operator');
        address oldOperator = operator;
        operator = newOperator;
        emit SetOperator(oldOperator, newOperator);
    }
}
