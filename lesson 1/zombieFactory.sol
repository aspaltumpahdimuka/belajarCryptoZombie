// SPDX-LICENSE-IDENTIFIER: MIT
/*
Semua kode sumber Solidity harus dimulai dengan "pragma versi" - deklarasi versi
 kompiler Solidity yang akan digunakan oleh kode ini. 
 Hal ini untuk mencegah masalah dengan versi kompiler di masa depan yang berpotensi 
 memperkenalkan perubahan yang akan merusak kode Anda.
*/
pragma solidity ^0.8.0;

/*
Kode Solidity dikemas dalam kontrak. 
Kontrak adalah blok bangunan fundamental dari aplikasi Ethereum - semua variabel dan fungsi 
termasuk dalam kontrak, dan ini akan menjadi titik awal dari semua proyek Anda.
*/
contract ZombieFactory {
    /*
    Variabel state disimpan secara permanen dalam penyimpanan kontrak. 
    Ini berarti variabel tersebut ditulis ke blockchain Ethereum. 
    Anggap saja seperti menulis ke DB.
    */

    /*
    Tipe data uint adalah bilangan bulat tidak bertanda, yang berarti nilainya harus 
    non-negatif. Ada juga tipe data int untuk bilangan bulat bertanda.
    */
    uint dnaDigits = 16;

    /*
    Matematika dalam Solidity cukup mudah. Operasi berikut ini sama dengan kebanyakan bahasa 
    pemrograman:

    Penambahan: x + y
    Pengurangan: x - y,
    Perkalian: x * y
    Pembagian: x / y
    Modulus / sisa: x % y (misalnya, 13 % 5 adalah 3, karena jika Anda membagi 5 menjadi 13, 
    3 adalah sisanya)
    Solidity juga mendukung operator eksponensial (yaitu "x pangkat y", x^y):
    */
    uint dnaModulus = 10 ** dnaDigits; // 10^16

    /*
    Struct memungkinkan Anda membuat tipe data yang lebih rumit yang memiliki 
    banyak properti.
    */

    /*
    
    Perhatikan bahwa kami baru saja memperkenalkan tipe baru, string. 
    String digunakan untuk data UTF-8 dengan panjang sembarang. 
    Contoh: string salam = "Halo dunia!"
    */

    // membuat struct Zombie
    struct Zombie {
        string name; // propert name bertipe string
        uint dna; // properti dna bertipe uint
    }

    /*
    Ketika Anda menginginkan sebuah koleksi dari sesuatu, 
    Anda dapat menggunakan array. 
    Ada dua jenis array di Solidity: array tetap dan array dinamis:
    */

    // // array dengan panjang tetap 2 elemen:
    // uint[2] fixedArray;
    // // array tetap lainnya, bisa berisi 5 string:
    // string[5] stringArray;
    // // Larik dinamis - tidak memiliki ukuran tetap, dapat terus bertambah:
    // uint[] dynamicArray;

    /*
    Anda juga dapat membuat sebuah array dari struct. 
    */
    // Person[] people; // Array dinamis, kita dapat terus menambahkannya

    // Anda bisa mendeklarasikan sebuah larik sebagai publik, dan 
    // Solidity akan secara otomatis membuat metode pengambil untuk larik tersebut. 
    // Sintaksnya terlihat seperti ini:
    // Person[] public people;

    // Kontrak lain akan dapat membaca dari, tetapi tidak dapat menulis ke larik ini. 
    // Jadi, ini adalah pola yang berguna untuk menyimpan data publik dalam kontrak Anda.

    // Membuat array publik bernama zombies dari struct Zombie
    Zombie[] public zombies;

    // Deklarasi fungsi dalam solidity 
    // terlihat seperti berikut ini:
    // function eatHamburgers(string memory _name, uint _amount) public {

    // }

    // Ini adalah sebuah fungsi bernama eatHamburger yang mengambil 2 parameter: 
    // sebuah string dan sebuah uint. Untuk saat ini, badan fungsi masih kosong. 
    // Perhatikan bahwa kita menetapkan visibilitas fungsi sebagai publik. 
    // Kami juga memberikan instruksi tentang di mana variabel _name harus disimpan - 
    // di dalam memory. Hal ini diperlukan untuk semua tipe referensi seperti 
    // array, struct, mapping, dan string.

    // Nah, ada dua cara untuk mengoper argumen ke fungsi Solidity:

    // Dengan value, yang berarti kompiler Solidity membuat salinan baru dari nilai parameter 
    // dan meneruskannya ke fungsi Anda. Hal ini memungkinkan fungsi Anda untuk memodifikasi 
    // nilai tanpa perlu khawatir nilai parameter awal akan berubah.

    // Dengan referensi, yang berarti bahwa fungsi Anda dipanggil dengan ... referensi 
    // ke variabel asli. Dengan demikian, jika fungsi Anda mengubah nilai variabel 
    // yang diterimanya, nilai variabel asli akan berubah.

    // Catatan: Sudah menjadi konvensi (tetapi tidak wajib) 
    // untuk memulai nama variabel parameter fungsi dengan garis bawah (_) 
    // untuk membedakannya dari variabel global.

    function createZombie(string memory _name, uint _dna); public {
        
    }
}