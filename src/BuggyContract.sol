// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BuggyContract {
    uint private count = 0;
    address private owner;
    bool public isPaused;

    constructor() {
        owner = msg.sender; // Bug 1: Perbaiki constructor
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    // Fungsi untuk increment, private visibility diperbaiki
    function increment(uint amount) private {
        count += amount;
    }

    // Fungsi untuk mendapatkan nilai count
    function getCount() public view returns (uint) {
        return count;
    }

    // Fungsi untuk membagi count dengan pemeriksaan divisor = 0
    function divideCount(uint divisor) public returns (uint) {
        require(divisor != 0, "Divisor cannot be zero");
        count = count / divisor;
        return count;
    }

    // Fungsi untuk set message (disimpan sebagai variabel temporer)
    function setMessage(string memory message) public {
        string memory tempMessage = message;
    }

    // Fungsi untuk menghitung penjumlahan n angka
    function sumNumbers(uint n) public pure returns (uint) {
        return (n * (n + 1)) / 2; // Menggunakan formula langsung untuk efisiensi
    }

    // Fungsi untuk set count dengan multiplikasi
    function setCountWithMultiplication(uint x, uint y) public {
        // Gunakan unchecked jika diperlukan atau overflow checks (v0.8+ sudah built-in overflow protection)
        count = x * y;
    }

    // Fungsi untuk reset count (tambahkan public visibility)
    function resetCount() public onlyOwner {
        count = 0;
    }

    // Fungsi untuk toggle isPaused
    function togglePause() public onlyOwner {
        isPaused = !isPaused; // Menggunakan negasi boolean
    }
}
