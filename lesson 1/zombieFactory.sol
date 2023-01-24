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
}