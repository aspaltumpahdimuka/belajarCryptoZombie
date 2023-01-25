// SPDX-LICENSE-IDENTIFIER: MIT

pragma solidity ^0.8.17;

// Whoa! Anda akan melihat bahwa kita baru saja membersihkan kode di sebelah kanan, 
// dan Anda sekarang memiliki tab di bagian atas editor Anda. 
// Silakan klik di antara tab-tab tersebut untuk mencobanya.

// Kode kita menjadi sangat panjang, jadi kita membaginya menjadi beberapa file agar 
// lebih mudah dikelola. Ini adalah cara yang biasa Anda gunakan untuk menangani kode 
// yang panjang dalam proyek-proyek Solidity Anda.

// Ketika Anda memiliki banyak file dan ingin mengimpor satu file ke file lainnya, 
// Solidity menggunakan kata kunci import:
import './zombieFactory.sol';

// Agar kontrak kita dapat berbicara dengan kontrak lain di blockchain yang bukan milik kita, 
// pertama-tama kita perlu mendefinisikan sebuah antarmuka.

// Mari kita lihat sebuah contoh sederhana. Katakanlah ada sebuah kontrak di blockchain 
// yang terlihat seperti ini:
// contract LuckyNumber {
//   mapping(address => uint) numbers;

//   function setNum(uint _num) public {
//     numbers[msg.sender] = _num;
//   }

//   function getNum(address _myAddress) public view returns (uint) {
//     return numbers[_myAddress];
//   }
// }
// Ini akan menjadi sebuah kontrak sederhana di mana setiap orang dapat menyimpan 
// nomor keberuntungan mereka, dan nomor tersebut akan dikaitkan dengan alamat Ethereum mereka. 
// Kemudian orang lain dapat mencari nomor keberuntungan orang tersebut dengan menggunakan 
// alamat mereka.

// Sekarang katakanlah kita memiliki kontrak eksternal yang ingin membaca data dalam 
// kontrak ini menggunakan fungsi getNum.

// Pertama, kita harus mendefinisikan antarmuka kontrak LuckyNumber:
// contract NumberInterface {
//   function getNum(address _myAddress) public view returns (uint);
// }
// Perhatikan bahwa ini terlihat seperti mendefinisikan kontrak, dengan beberapa perbedaan. 
// Pertama, kita hanya mendeklarasikan fungsi yang ingin kita gunakan untuk berinteraksi - 
// dalam hal ini getNum - dan kita tidak menyebutkan fungsi atau variabel state lainnya.

// Kedua, kita tidak mendefinisikan badan fungsi. Alih-alih menggunakan kurung kurawal ({ dan }), 
// kita cukup mengakhiri deklarasi fungsi dengan tanda titik dua (;).

// Jadi, bentuknya seperti kerangka kontrak. Dengan cara inilah kompiler tahu bahwa itu adalah 
// sebuah interface.

// Dengan menyertakan antarmuka ini di dalam kode dapp, kontrak kita mengetahui seperti apa 
// fungsi-fungsi kontrak lainnya, bagaimana cara memanggilnya, dan respons seperti apa yang diharapkan.

// Kita akan membahas cara memanggil fungsi-fungsi kontrak lain di pelajaran selanjutnya, 
// tetapi untuk saat ini mari kita mendeklarasikan antarmuka untuk kontrak CryptoKitties.

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  ) {}
}

contract ZombieFeeding is ZombieFactory {

    address ckAddress = 0x145422e73271E672d733A5a94eFf1817CFdda9F0;
    KittyInterface kittyContract = KittyInterface(ckAddress);

    // Dalam Solidity, ada dua lokasi untuk menyimpan variabel - di penyimpanan dan di memori.

    // Penyimpanan mengacu pada variabel yang disimpan secara permanen di blockchain. 
    // Variabel memori bersifat sementara, dan akan dihapus di antara pemanggilan fungsi 
    // eksternal ke kontrak Anda. Anggap saja seperti hard disk komputer Anda vs RAM.

    // Sebagian besar waktu Anda tidak perlu menggunakan kata kunci ini karena Solidity 
    // menanganinya secara default. Variabel state (variabel yang dideklarasikan di luar fungsi) 
    // secara default merupakan penyimpanan dan ditulis secara permanen ke blockchain, 
    // sedangkan variabel yang dideklarasikan di dalam fungsi merupakan memori dan 
    // akan hilang ketika pemanggilan fungsi berakhir.

    // Namun, ada kalanya Anda perlu menggunakan kata kunci ini, 
    // yaitu ketika berurusan dengan struktur dan array di dalam fungsi:
    // contract SandwichFactory {
    //     struct Sandwich {
    //         string name;
    //         string status;
    //     }

    //     Sandwich[] sandwiches;

    //     function eatSandwich(uint _index) public {
    //         // Sandwich mySandwich = sandwiches[_index];

    //         // ^ Seems pretty straightforward, but solidity will give you a warning
    //         // telling you that you should explicitly declare `storage` or `memory` here.

    //         // So instead, you should declare with the `storage` keyword, like:
    //         Sandwich storage mySandwich = sandwiches[_index];
    //         // ...in which case `mySandwich` is a pointer to `sandwiches[_index]`
    //         // in storage, and...
    //         mySandwich.status = "Eaten!";
    //         // ...this will permanently change `sandwiches[_index]` on the blockchain.

    //         // If you just want a copy, you can use `memory`:
    //         Sandwich memory anotherSandwich = sandwiches[_index + 1];
    //         // ...in which case `anotherSandwich` will simply be a copy of the 
    //         // data in memory, and...
    //         anotherSandwich.status = "Eaten!";
    //         // ...will just modify the temporary variable and have no effect 
    //          // on `sandwiches[_index + 1]`. But you can do this:
    //         sandwiches[_index + 1] = anotherSandwich;
    //         // ...if you want to copy the changes back into blockchain storage.
    //     }
    // }

    // Jangan khawatir jika Anda belum sepenuhnya memahami kapan harus menggunakan 
    // yang mana - sepanjang tutorial ini kami akan memberi tahu Anda kapan harus menggunakan 
    // penyimpanan dan kapan harus menggunakan memori, dan kompiler Solidity juga akan memberi 
    // Anda peringatan untuk memberi tahu Anda kapan Anda harus menggunakan salah satu dari 
    // kata kunci ini.

    // Untuk saat ini, cukup memahami bahwa ada beberapa kasus di mana Anda perlu 
    // mendeklarasikan penyimpanan atau memori secara eksplisit!
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna; // deklarasi
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId); // menugaskan return terakhir getktty
        feedAndMultiply(_zombieId, kittyDna);
    }
}
