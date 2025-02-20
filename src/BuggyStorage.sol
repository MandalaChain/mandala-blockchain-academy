// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    uint[] public numbers;
    // Task 2: Declare a string as message;
    string public message;
    // Task 3: Declare a mapping of address to balance as balances;
    mapping(address => uint) public balances;

    // Bug 1: Array bounds
    // Fungsi ini mengambil nilai dari array numbers pada index tertentu
    // Memastikan index tidak melebihi panjang array dengan require
    function getNumber(uint index) public view returns (uint) {
        require(index < numbers.length, "Index out of bounds");
        return numbers[index];
    }

    // Fungsi untuk menambahkan angka baru ke dalam array numbers
    // Menggunakan push untuk menambahkan di akhir array
    function addNumber(uint number) public {
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    // Fungsi untuk mengambil potongan array dari indeks start sampai end
    // Memastikan start <= end dan end tidak melebihi panjang array
    // Mengembalikan array baru yang berisi elemen-elemen yang dipotong
    function sliceArray(
        uint start,
        uint end
    ) public view returns (uint[] memory) {
        require(start <= end, "Start must be less than or equal to end");
        require(end <= numbers.length, "End index out of bounds");

        uint[] memory sliced = new uint[](end - start);
        for (uint i = start; i < end; i++) {
            sliced[i - start] = numbers[i];
        }
        return sliced;
    }

    // Bug 3: Concatenate strings correctly
    // Fungsi untuk menggabungkan string baru dengan string yang sudah ada
    // Menggunakan abi.encodePacked untuk menggabungkan string
    function setMessage(string memory newMessage) public {
        message = string(abi.encodePacked(message, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params?
    // Fungsi untuk menambahkan array angka baru ke dalam array numbers
    // Menggunakan parameter memory untuk menghemat gas
    // Menambahkan setiap elemen dari input ke dalam array numbers
    function validMemoryUsage(uint[] memory input) public {
        for (uint i = 0; i < input.length; i++) {
            numbers.push(input[i]);
        }
    }

    // Fungsi untuk mendapatkan saldo dari alamat pengguna tertentu
    function getBalance(address user) public view returns (uint) {
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    // Fungsi untuk menghapus elemen terakhir dari array numbers
    // Memastikan array tidak kosong sebelum menghapus
    function removeLastNumber() public {
        require(numbers.length > 0, "No numbers to remove");
        numbers.pop();
    }

    // Fungsi untuk memperbarui saldo dari alamat pengguna tertentu
    function updateBalance(address user, uint amount) public {
        balances[user] += amount;
    }
}
