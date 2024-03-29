![LZip Shell Exec Logo](https://raw.githubusercontent.com/FajarKim/lzip-shell/master/image/logo.jpg)
<div align="center">
    <a href="https://github.com/FajarKim/lzip-shell"><img src="https://img.shields.io/github/languages/code-size/FajarKim/lzip-shell?label=LZip%20Shell%20Exec&style=plastic&logo=github&color=blue" alt="LZip Shell Exec"></a>
    <a href="https://github.com/FajarKim/lzip-shell/stargazers/"><img src="https://img.shields.io/github/stars/FajarKim/lzip-shell?label=Star&style=plastic&color=red" alt="Stars"></a>
    <a href="https://github.com/FajarKim/lzip-shell/network/members/"><img src="https://img.shields.io/github/forks/FajarKim/lzip-shell?label=Fork&style=plastic&color=f5ff5e" alt="Forks"></a>
    <a href="https://github.com/FajarKim/lzip-shell/issues?q=is%3Aopen+is%3Aissue/"><img src="https://img.shields.io/github/issues/FajarKim/lzip-shell?label=Issue&style=plastic&color=a1b3ff" alt="Issues"></a>
    <a href="https://github.com/FajarKim/lzip-shell/issues?q=is%3Aissue+is%3Aclosed/"><img src="https://img.shields.io/github/issues-closed/FajarKim/lzip-shell?label=Issue&style=plastic&color=ffffff" alt="Issues"></a>
    <a href="https://github.com/FajarKim/lzip-shell/watchers/"><img src="https://img.shields.io/github/watchers/FajarKim/lzip-shell?label=Watch&style=plastic&color=1fe1f" alt="Whatchers"></a>
    <a href="https://github.com/FajarKim/lzip-shell/pulls?q=is%3Aopen+is%3Apr/"><img src="https://img.shields.io/github/issues-pr/FajarKim/lzip-shell?&label=Pull%20requests&style=plastic&color=971dff" alt="Pull-requests"></a>
    <a href="https://github.com/FajarKim/lzip-shell/pulls?q=is%3Apr+is%3Aclosed/"><img src="https://img.shields.io/github/issues-pr-closed/FajarKim/lzip-shell?&label=Pull%20requests&style=plastic&color=orange" alt="Pull-requests"></a>
    <a href="https://github.com/FajarKim/lzip-shell/blob/master/LICENSE"><img src="https://img.shields.io/github/license/FajarKim/lzip-shell?label=License&style=plastic&color=01ffc4&logo=gnu" alt="License"></a>
</div>

# LZip Shell Exec
LZip Shell Exec is a tool that can be used to compress script strings of several shell types 🔐 such as Bourne Shell (sh), Bourne Again Shell (bash), Z Shell (zsh), Korn Shell (ksh), and MirBSD Korn Shell (mksh) into LZip format.

<details>
<summary>Translations</summary>

- [🇫🇷 France](https://github.com/FajarKim/lzip-shell/blob/master/README-FR.md)
- [🇮🇩 Indonesian](https://github.com/FajarKim/lzip-shell)
- [🇰🇷 Korean](https://github.com/FajarKim/lzip-shell/blob/master/README-KR.md)
</details>

# Installation Instructions
## Termux
### Step 1
- `$ pkg update -y && pkg upgrade -y`
- `$ pkg install lzip xz-utils git -y`
- `$ git clone https://github.com/FajarKim/lzip-shell`
- `$ cd lzip-shell/tools/Termux`
- `$ ./install.sh` or `$ bash install.sh`
### Step 2
<table>
    <tr>
        <td><div align="center"><b>Method</b></div></td>
        <td><div align="center"><b>Command</b></div></td>
    </tr>
    <tr>
        <td><div align="center"><b>curl</b></div></td>
        <td><div align="left"><code>bash -c "$(curl -fsSL https://raw.githubusercontent.com/FajarKim/lzip-shell/master/tools/Termux/install.sh)"</code></div></td>
    </tr>
    <tr>
        <td><div align="center"><b>wget</b></div></td>
        <td><div align="left"><code>bash -c "$(wget -qO- https://raw.githubusercontent.com/FajarKim/lzip-shell/master/tools/Termux/install.sh)"</code></div></td>
    </tr>
    <tr>
        <td><div align="center"><b>fetch</b></div></td>
        <td><div align="left"><code>bash -c "$(fetch -o - https://raw.githubusercontent.com/FajarKim/lzip-shell/master/tools/Termux/install.sh)"</code></div></td>
    </tr>
<table>

As an alternative, you can first download the `install.sh` script and run it afterwards:
```text
$ wget https://raw.githubusercontent.com/FajarKim/lzip-shell/master/tools/Termux/install.sh
$ bash install.sh
```
## Linux
### Step 1
- `$ apt update -y && apt upgrade -y`
- `$ apt install lzip xz-utils git -y`
- `$ git clone https://github.com/FajarKim/lzip-shell`
- `$ cd lzip-shell/tools/Linux`
- `$ ./install.sh` or `$ bash install.sh`
### Step 2
<table>
    <tr>
        <td><div align="center"><b>Method</b></div></td>
        <td><div align="center"><b>Command</b></div></td>
    </tr>
    <tr>
        <td><div align="center"><b>curl</b></div></td>
        <td><div align="left"><code>bash -c "$(curl -fsSL https://raw.githubusercontent.com/FajarKim/lzip-shell/master/tools/Linux/install.sh)"</code></div></td>
    </tr>
    <tr>
        <td><div align="center"><b>wget</b></div></td>
        <td><div align="left"><code>bash -c "$(wget -qO- https://raw.githubusercontent.com/FajarKim/lzip-shell/master/tools/Linux/install.sh)"</code></div></td>
    </tr>
    <tr>
        <td><div align="center"><b>fetch</b></div></td>
        <td><div align="left"><code>bash -c "$(fetch -o - https://raw.githubusercontent.com/FajarKim/lzip-shell/master/tools/Linux/install.sh)"</code></div></td>
    </tr>
<table>

As an alternative, you can first download the `install.sh` script and run it afterwards:
```text
$ wget https://raw.githubusercontent.com/FajarKim/lzip-shell/master/tools/Linux/install.sh
$ bash install.sh
```

# Instructions for Use
Supported commands:
<table>
    <tr>
        <td><div align="center"><b>Command</b></div></td>
        <td><div align="center"><b>Description</b></div></td>
    </tr>
    <tr>
        <td><div align="left"><code>-h</code> or <code>--help</code></div></td>
        <td><div align="left">Display this help</div></td>
    </tr>
    <tr>
        <td><div align="left"><code>-v</code> or <code>--version</code></div></td>
        <td><div align="left">Output version information</div></td>
    </tr>
    <tr>
        <td><div align="left"><code>-t</code> or <code>--type-shell</code></div></td>
        <td><div align="left">Select a type shell (sh, bash, zsh, ksh, atau mksh)</div></td>
    </tr>
    <tr>
        <td><div align="left"><code>-f</code> or <code>--file</code></div></td>
        <td><div align="left">Compress each FILE instead it</div></td>
    </tr>
<table>

How to run this tool:
### Example 1
```text
$ lzipsh.sh -t bash -f FILE
```
or
```text
$ lzipsh.sh --type-shell bash --file FILE
```
### Example 2
```text
$ lzipsh.sh -t bash -f FILE1 FILE2 FILE3...
```
or
```text
$ lzipsh.sh --type-shell bash --file FILE1 FILE2 FILE3...
```
### Note
The more number of lines in a file, the longer it will take to encrypt.

# Contact
Please contact me below if there are any problems or questions regarding this tool. Don't forget to follow me!
<div align="center">
    <a href="https://www.facebook.com/fajarrkim"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/facebook_logo.png" alt="Facebook" width="35"></a>
    &ensp;
    <a href="https://www.instagram.com/fajarkim_"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/instagram_logo.png" alt="Instagram" width="35"></a>
    &ensp;
    <a href="https://wa.me/6285659850910?text=Hi"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/whatsapp_logo.png" alt="WhatsApp" width="35"></a>
    &ensp;
    <a href="https://t.me/FajarThea"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/telegram_logo.png" alt="Telegram" width="35"></a>
    &ensp;
    <a href="https://www.twitter.com/fajarkim_"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/twitter_logo.png" alt="Twitter" width="35"></a>
    &ensp;
    <a href="mailto:fajarrkim@gmail.com"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/gmail_logo.png" alt="Gmail" width="35"></a>
</div>

# Donate
For those who would like to donate to the development and progress of this account, please click the link below! I thank you very much to those who want to donate 😊😊😊
<div align="left">
    <a href="https://github.com/sponsors/FajarKim/"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/donate_github.png" alt="GitHub Sponsor" width="250"></a>
    <a href="https://paypal.me/agusbirawan/"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/donate_paypal.png" alt="PayPal Donate" width="250"></a>
    <a href="https://trakteer.id/FajarKim/"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/donate_trakteer.png" alt="Trakteer.id Donate" width="250"></a>
</div>