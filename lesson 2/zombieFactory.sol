// SPDX-LICENSE-IDENTIFIER: MIT

pragma solidity ^0.8.0;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits; // 10^16

    struct Zombie {
        string name; // propert name bertipe string
        uint dna; // properti dna bertipe uint
    }

    Zombie[] public zombies;

    // Blockchain Ethereum terdiri dari akun-akun, 
    // yang dapat Anda bayangkan seperti rekening bank. 
    // Sebuah akun memiliki saldo Ether (mata uang yang digunakan pada blockchain Ethereum), 
    // dan Anda bisa mengirim dan menerima pembayaran Ether ke akun lain, 
    // seperti halnya rekening bank Anda yang bisa mentransfer uang ke rekening bank lain.

    // Setiap akun memiliki alamat, yang dapat Anda anggap seperti nomor rekening bank. 
    // Alamat tersebut merupakan pengenal unik yang mengarah ke akun tersebut, 
    // dan terlihat seperti ini:

    // 0x0cE446255506E92DF41614C46F1d6df9Cc969183

    // Kita akan membahas seluk-beluk alamat di pelajaran selanjutnya, 
    // tetapi untuk saat ini Anda hanya perlu memahami bahwa sebuah alamat dimiliki oleh 
    // pengguna tertentu (atau smart contract).

    // Jadi kita dapat menggunakannya sebagai ID unik untuk kepemilikan zombie kita. 
    // Ketika pengguna membuat zombie baru dengan berinteraksi dengan aplikasi kita, 
    // kita akan menetapkan kepemilikan zombie tersebut ke alamat Ethereum yang memanggil 
    // fungsi tersebut.

    // Pada Pelajaran 1 kita telah melihat struct dan array. 
    // mapping adalah cara lain untuk menyimpan data yang terorganisir di Solidity.

    // Mendefinisikan mapping terlihat seperti ini:
    // // For a financial app, storing a uint that holds the user's account balance:
    // mapping (address => uint) public accountBalance;
    // // Or could be used to store / lookup usernames based on userId
    // mapping (uint => string) userIdToName;

    // Pemetaan pada dasarnya adalah sebuah penyimpanan nilai-kunci untuk menyimpan 
    // dan mencari data. Pada contoh pertama, kuncinya adalah alamat dan nilainya adalah uint, 
    // dan pada contoh kedua kuncinya adalah uint dan nilainya adalah string.

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length - 1;
        emit NewZombie(id, _name, _dna);

    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}