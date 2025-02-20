// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    // Task 2: Declare a string as message;
    // Task 3: Declare a mapping of address to balance as balances;
    uint256[] numbers;
    string public message;
    mapping(address => uint256) balances;


    // Bug 1: Array bounds
    // Explaination
    // this function can resulted error if user input the index out of range, so i add a required to prevent the index input is will not greater than numbers.length
    function getNumber(uint index) public view returns (uint) {
        require(index < numbers.length, "The index is out of range");
        return numbers[index]; 
    }

    function addNumber(uint number) public {
        // Task 4: Implement adding numbers to the array
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    // Explaination
    // We need to add a reuqire to prevent "start" value more than "end" 
    // And  we need "end" to not over the "numbers.length"
    // We can use new variable _slicedArray and set the length to end-start to reduce gas used
    // And then we can use for loop to add the numbers to _sliceArray as position we set before, and then return the _slicedArray
    function sliceArray(uint start, uint end) public view  returns (uint[] memory) {
        require(start < end, "Start index must less than end index");
        require(end <= numbers.length, "End index can't be more than numbers leggth");
        uint256[] memory _slicedArray = new uint256[](end - start);
        for (uint i = start; i < end; i++){
            _slicedArray[i - start] = numbers[i];
        }
        // return numbers[start:end];
        return _slicedArray;
    }

    // Bug 3: Concatenate strings correctly
    // Explaination
    // In solidiy we cannot just add string like in python or other programming langauge
    // We need to use function string(abi.encodePacked(message1, message2)); 
    function setMessage(string memory newMessage) public{
        message = string(abi.encodePacked(message, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params?
    // Explaination
    // we need change the storage to memory/calldata for "ref" because in function the variable is temporary so we just need to 
    // borrow a memory in EVM 
    // Real Explaination, we just need to push the numbers with input, we can use for loop to push each "input" value
    function validMemoryUsage(uint[] memory input) public {
        // uint[] memory _ref = input;
        // Implement logics to update numbers here
        for(uint256 i = 0; i < input.length; i++){
            // numbers[i] = input[i];
            numbers.push(input[i]);
        }

    }

    function getBalance(address user) public view returns (uint) {
        // Task 5: Returning the balance for a specific user
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    // Explaination
    // I think we need to add a require to prevent user to pop the element if there's no element in the array
    // So there will no gas wasted.
    function removeLastNumber() public {
        require(numbers.length != 0, "You don't need to pop element because the array already empty");
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        // Task 6: Update balance of a user with a specific amount
        balances[user] += amount;
    }
}
