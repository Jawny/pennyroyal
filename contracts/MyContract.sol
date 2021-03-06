pragma solidity ^0.5.0;

contract MyContract {

	struct User {
		uint phoneNumber;
		uint pin;
		uint balance;		// How much cash they got in their account
	}

	// State variable - we will be storing user data here 
	User[] public users;

	function createUser(uint phoneNumber, uint pin) public {
		uint i = findUser(phoneNumber);
		if (users[i].phoneNumber != phoneNumber)  {
			users.push(User(phoneNumber, pin, 0));
		}
	}

	// Update user funds
	function updateUser(uint phoneNumber, uint amount) public {
		uint i = findUser(phoneNumber);	
		users[i].balance = amount;
	}

	function transferFunds(uint phoneNumber, uint amount, uint receiver) public {
		uint i = findUser(phoneNumber);	
		users[i].balance = users[i].balance - amount;

		uint j = findUser(receiver);
		users[j].balance = users[j].balance + amount;
	}

	function readUser(uint phoneNumber) public view returns (uint, uint) {
		uint i = findUser(phoneNumber);
		return (users[i].phoneNumber, users[i].balance); 
	}

	function deleteUser(uint phoneNumber) public {
		uint i = phoneNumber;
		delete users[i];
	}

	// Code that can search inside the user array
	function findUser(uint phoneNumber) internal view returns (uint) {
		for(uint i = 0; i < users.length; i++) {
			if(users[i].phoneNumber == phoneNumber) {
				return i;	
			}
		}
	}
}
