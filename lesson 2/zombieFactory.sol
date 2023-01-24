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

        // Dalam Solidity, ada beberapa variabel global tertentu yang tersedia untuk 
        // semua fungsi. Salah satunya adalah msg.sender, yang merujuk pada alamat 
        // orang (atau smart contract) yang memanggil fungsi saat ini.
        // Catatan: Dalam Solidity, eksekusi fungsi selalu harus dimulai 
        // dengan pemanggil eksternal. 
        // Sebuah kontrak hanya akan berada di blockchain tanpa melakukan apa pun sampai 
        // seseorang memanggil salah satu fungsinya. Jadi akan selalu ada msg.sender.

        // mapping (address => uint) favoriteNumber;

        // function setMyNumber(uint _myNumber) public {
        //  // Update our `favoriteNumber` mapping to store `_myNumber` under `msg.sender`
        //     favoriteNumber[msg.sender] = _myNumber;
        // // ^ The syntax for storing data in a mapping is just like with arrays
        // }

        // Pada contoh sepele ini, siapa pun dapat memanggil setMyNumber dan menyimpan 
        // sebuah uint di dalam kontrak kita, yang akan diikat ke alamat mereka. 
        // Kemudian ketika mereka memanggil whatIsMyNumber, mereka akan mendapatkan 
        // uint yang mereka simpan.

        // Menggunakan msg.sender memberikan Anda keamanan blockchain Ethereum - satu-satunya 
        // cara seseorang dapat memodifikasi data orang lain adalah dengan mencuri private key 
        // yang terkait dengan alamat Ethereum mereka.

        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;

function whatIsMyNumber() public view returns (uint) {
  // Retrieve the value stored in the sender's address
  // Will be `0` if the sender hasn't called `setMyNumber` yet
  return favoriteNumber[msg.sender];
}

        emit NewZombie(id, _name, _dna);

    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {

        // Pada pelajaran 1, kita telah membuatnya agar pengguna dapat membuat zombie baru 
        // dengan memanggil createRandomZombie dan memasukkan nama. 
        // Namun, jika pengguna dapat terus memanggil fungsi ini untuk membuat zombie tanpa 
        // batas dalam pasukan mereka, permainan tidak akan menyenangkan.

        // Mari kita buat agar setiap pemain hanya dapat memanggil fungsi ini sekali saja. 
        // Dengan begitu, pemain baru akan memanggilnya saat pertama kali memulai permainan 
        // untuk membuat zombie awal dalam pasukan mereka.

        // Bagaimana cara membuatnya agar fungsi ini hanya dapat dipanggil sekali per pemain?

        // Untuk itu kita menggunakan require. require membuatnya agar fungsi akan 
        // melemparkan kesalahan dan berhenti dieksekusi jika ada kondisi yang tidak benar:

        // function sayHiToVitalik(string memory _name) public returns (string memory) {
        // // Compares if _name equals "Vitalik". Throws an error and exits if not true.
        // // (Side note: Solidity doesn't have native string comparison, so we
        // // compare their keccak256 hashes to see if the strings are equal)
        //     require(keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("Vitalik")));
        // // If it's true, proceed with the function:
        //     return "Hi!";
        // }
        // Jika Anda memanggil fungsi ini dengan sayHiToVitalik("Vitalik"), 
        // fungsi ini akan mengembalikan "Hai!". Jika Anda memanggilnya dengan input lain, 
        // fungsi ini akan melemparkan kesalahan dan tidak akan dijalankan.

        // Dengan demikian, require sangat berguna untuk memverifikasi kondisi tertentu 
        // yang harus benar sebelum menjalankan sebuah fungsi.
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

// Kode game kita menjadi sangat panjang. Daripada membuat satu kontrak yang sangat panjang, 
// terkadang masuk akal untuk membagi logika kode Anda menjadi beberapa kontrak untuk mengatur 
// kode.

// Salah satu fitur Solidity yang membuat hal ini lebih mudah dikelola adalah pewarisan 
// kontrak:

// contract Doge {
//   function catchphrase() public returns (string memory) {
//     return "So Wow CryptoDoge";
//   }
// }

// contract BabyDoge is Doge {
//   function anotherCatchphrase() public returns (string memory) {
//     return "Such Moon BabyDoge";
//   }
// }

// BabyDoge mewarisi dari Doge. Ini berarti jika Anda mengkompilasi dan menggunakan BabyDoge, 
// ia akan memiliki akses ke catchphrase() dan otherCatchphrase() 
// (dan fungsi-fungsi publik lain yang dapat kita definisikan di Doge).

// Ini dapat digunakan untuk pewarisan logika (seperti pada subkelas, Kucing adalah Hewan). 
// Tetapi juga bisa digunakan untuk mengatur kode Anda dengan mengelompokkan logika yang sama 
// ke dalam kontrak yang berbeda.

// contract ZombieFeeding is ZombieFactory {

// }