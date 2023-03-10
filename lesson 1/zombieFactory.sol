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

    // Event adalah cara bagi kontrak Anda untuk mengomunikasikan bahwa sesuatu telah terjadi 
    // di blockchain ke front-end aplikasi Anda, 
    // yang dapat 'mendengarkan' event tertentu dan mengambil tindakan saat peristiwa itu 
    // terjadi.
    // declare the event
    // event IntegersAdded(uint x, uint y, uint result);

    // function add(uint _x, uint _y) public returns (uint) {
    //     uint result = _x + _y;
    //     // fire an event to let the app know the function was called:
    //     emit IntegersAdded(_x, _y, result);
    //     return result;
    // }

    event NewZombie(uint zombieId, string name, uint dna);



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

    // Dalam Solidity, fungsi bersifat public secara default. 
    // Ini berarti setiap orang (atau kontrak lainnya) dapat memanggil fungsi kontrak Anda 
    // dan menjalankan kodenya.

    // Tentu saja hal ini tidak selalu diinginkan, dan dapat membuat kontrak Anda 
    // rentan terhadap serangan. Oleh karena itu, merupakan praktik yang baik untuk menandai 
    // fungsi Anda sebagai private secara default, dan kemudian hanya membuat 
    // fungsi public yang ingin Anda publikasikan kepada dunia.

    // Seperti yang Anda lihat, kita menggunakan kata kunci private setelah nama fungsi. 
    // Dan seperti halnya parameter fungsi, sudah menjadi konvensi untuk memulai nama 
    // fungsi privat dengan garis bawah (_).

    function _createZombie(string memory _name, uint _dna) private {
        // Sekarang kita akan mempelajari cara membuat Persons baru dan menambahkannya 
        // ke dalam susunan people.
        // // create a New Person:
        // Person satoshi = Person(172, "Satoshi");

        // // Add that person to the Array:
        // people.push(satoshi);

        // Kita juga dapat menggabungkannya dan melakukannya dalam satu baris kode 
        // untuk menjaga agar tetap bersih:

        // people.push(Person(16, "Vitalik"));

        // Perhatikan bahwa array.push() menambahkan sesuatu ke akhir array, 
        // sehingga elemen-elemennya sesuai dengan urutan yang kita tambahkan. 
        // Lihat contoh berikut ini:
        // uint[] numbers;
        // numbers.push(5);
        // numbers.push(10);
        // numbers.push(15);
        // // numbers is now equal to [5, 10, 15]

        // // Membuat Zombie dengan nama dan dna sesuai
        // parameter pada function createZombie lalu dimasukkan ke array zombies.
        // lalu menyimpannya di variable id, karena array.push mengembalikan panjang arrya,
        // maka uint id dikurang 1 membuatnya sesuai dengan index array.
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length - 1;

        // memanggil event
        emit NewZombie(id, _name, _dna);

    }

    // Untuk mengembalikan nilai dari sebuah fungsi, deklarasinya terlihat seperti ini:

    // string greeting = "What's up dog";

    // function sayHello() public returns (string memory) {
    // return greeting;
    // }

    // Fungsi di atas tidak benar-benar mengubah status di Solidity - 
    // misalnya tidak mengubah nilai apa pun atau menulis apa pun.

    // Jadi dalam kasus ini kita dapat mendeklarasikannya sebagai fungsi view, 
    // yang berarti fungsi ini hanya melihat data tetapi tidak memodifikasinya:
    // function sayHello() public view returns (string memory) {}

    // Solidity juga berisi fungsi pure, yang berarti Anda bahkan tidak mengakses data apa pun 
    // dalam aplikasi. Pertimbangkan yang berikut ini
    // function _multiply(uint a, uint b) private pure returns (uint) {
    // return a * b;
    // }
    // Fungsi ini bahkan tidak membaca dari state aplikasi - 
    // nilai kembalinya hanya bergantung pada parameter fungsinya. 
    // Jadi dalam kasus ini kita akan mendeklarasikan fungsi tersebut sebagai fungsi pure.

    function _generateRandomDna(string memory _str) private view returns (uint) {
        // Kita ingin fungsi _generateRandomDna mengembalikan sebuah uint (semi) acak. 
        // Bagaimana kita bisa mencapai hal ini?

        // Ethereum memiliki fungsi hash keccak256 di dalamnya, 
        // yang merupakan versi SHA3. Fungsi hash pada dasarnya memetakan sebuah input 
        // ke dalam sebuah angka heksadesimal 256-bit acak. 
        // Sedikit perubahan pada input akan menyebabkan perubahan besar pada hash.

        // Fungsi ini berguna untuk berbagai tujuan di Ethereum, 
        // tetapi untuk saat ini kita hanya akan menggunakannya untuk pembuatan bilangan 
        // acak semu.

        // Yang juga penting, keccak256 mengharapkan satu parameter bertipe byte. 
        // Ini berarti kita harus "pack" parameter apa pun sebelum memanggil keccak256:

        // //6e91ec6b618bb462a4a6ee5aa2cb0e9cf30f7a052bb467b0ba58b8748c00d2e5
        // keccak256(abi.encodePacked("aaaab"));
        // //b1f078126895a1424524de5321b339ab00408010b7cf0e6ed451514981e58aa9
        // keccak256(abi.encodePacked("aaaac"));
        // Seperti yang Anda lihat, nilai yang dikembalikan benar-benar berbeda 
        // meskipun hanya ada perubahan 1 karakter dalam input.

        // Terkadang Anda perlu mengonversi antar tipe data. 
        // Perhatikan contoh berikut ini:
        // uint8 a = 5;
        // uint b = 6;
        // // throws an error because a * b returns a uint, not uint8:
        // uint8 c = a * b;
        // // we have to typecast b as a uint8 to make it work:
        // uint8 c = a * uint8(b);
        // Pada contoh di atas, a * b mengembalikan sebuah uint, 
        // tetapi kita mencoba menyimpannya sebagai uint8, 
        // yang dapat menyebabkan masalah potensial. 
        // Dengan menyimpannya sebagai uint8, maka ia akan berfungsi dan 
        // kompiler tidak akan memberikan kesalahan.

        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    // Buat sebuah fungsi publik bernama createRandomZombie. 
    // Fungsi ini akan mengambil satu parameter bernama _name 
    // (sebuah string dengan lokasi data yang ditetapkan ke memori). 
    // (Catatan: Deklarasikan fungsi ini menjadi publik seperti halnya Anda 
    // mendeklarasikan fungsi sebelumnya menjadi privat)

    function createRandomZombie(string memory _name) public {
        // Baris pertama dari fungsi tersebut harus menjalankan fungsi _generateRandomDna 
        // pada _name, dan menyimpannya dalam sebuah uint bernama randDna.
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}