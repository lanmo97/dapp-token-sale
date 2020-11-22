pragma solidity ^0.5.0;

/**
 * The contractName contract does this and that...
 */
contract DappToken {

	//Name
	string public name = "DApp Token";
	//Symbol
	string public symbol = "DAT";
	string public standard = "DApp Token v0.1";

	uint256 public totalSupply;

	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 _value
	);

	event Approval(
		address indexed _owner,
		address indexed _spender,
	    uint256 _value
	);
	

	mapping(address => uint256) public balanceOf;
	mapping (address => mapping(address => uint)) public allowance;
	

	constructor(uint256 _initialSupply) public {
		balanceOf[msg.sender] = _initialSupply;
		totalSupply = _initialSupply;
	}

	// Transfer
	function transfer(address _to, uint256 _value) public returns (bool success){

		require (balanceOf[msg.sender] >= _value);
		
		// Transfer the balance
		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;

		emit Transfer(msg.sender, _to, _value);

		return true;
	}

	// approve
	function approve(address _spender, uint256 _value) public returns (bool success){
		
		// allowance
		allowance[msg.sender][_spender] = _value;

		// approval event
		emit Approval(msg.sender, _spender, _value);
		
		return true;
	}

	function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
		
		require (_value <= balanceOf[_from]);
		require (_value <= allowance[_from][msg.sender]);

		// change the balance
		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;
		
		// update the allowance
		allowance[_from][msg.sender] -= _value;
		
		// Transfer event
		emit Transfer(_from, _to, _value);

		// return a bool value
		return true;
	}
  
}
	