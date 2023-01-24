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

contract ZombieFeeding is ZombieFactory {
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
        uint storage newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }
}
