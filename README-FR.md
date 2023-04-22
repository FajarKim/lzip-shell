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
LZip Shell Exec est un outil qui peut être utilisé pour compresser les chaînes de script de plusieurs types de shell 🔐 tels que Bourne Shell (sh), Bourne Again Shell (bash), Z Shell (zsh), Korn Shell (ksh), et MirBSD Korn Shell (mksh) au format LZip.

<details>
<summary>Traduction</summary>

- [🇬🇧 English (UK)](https://github.com/FajarKim/lzip-shell/blob/master/README-KR.md)
- [🇮🇩 Indonesian](https://github.com/FajarKim/lzip-shell)
- [🇰🇷 Korean](https://github.com/FajarKim/lzip-shell/blob/master/README-KR.md)
</details>

# Instructions d'installation
## Termux
### Méthode 1
- `$ pkg update -y && pkg upgrade -y`
- `$ pkg install lzip lzma git -y`
- `$ git clone https://github.com/FajarKim/lzip-shell`
- `$ cd lzip-shell/tools/Termux`
- `$ ./install.sh` ou `$ bash install.sh`
### Méthode 2
<table>
    <tr>
        <td><div align="center"><b>Méthodes</b></div></td>
        <td><div align="center"><b>Commande</b></div></td>
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

Vous pouvez également télécharger le script `install.sh` et l'exécuter ensuite:
```text
$ wget https://raw.githubusercontent.com/FajarKim/lzip-shell/master/tools/Termux/install.sh
$ bash install.sh
```
## Linux
### Méthode 1
- `$ apt update -y && apt upgrade -y`
- `$ apt install lzip lzma git -y`
- `$ git clone https://github.com/FajarKim/lzip-shell`
- `$ cd lzip-shell/tools/Linux`
- `$ ./install.sh` ou `$ bash install.sh`
### Méthode 2
<table>
    <tr>
        <td><div align="center"><b>Méthodes</b></div></td>
        <td><div align="center"><b>Commande</b></div></td>
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

Vous pouvez également télécharger le script `install.sh` et l'exécuter ensuite:
```text
$ wget https://raw.githubusercontent.com/FajarKim/lzip-shell/master/tools/Linux/install.sh
$ bash install.sh
```

# Instructions d'utilisation
Commande supportées:
<table>
    <tr>
        <td><div align="center"><b>Commande</b></div></td>
        <td><div align="center"><b>Description</b></div></td>
    </tr>
    <tr>
        <td><div align="left"><code>-h</code> ou <code>--help</code></div></td>
        <td><div align="left">Afficher cette aide</div></td>
    </tr>
    <tr>
        <td><div align="left"><code>-v</code> ou <code>--version</code></div></td>
        <td><div align="left">Informations sur la version de sortie</div></td>
    </tr>
    <tr>
        <td><div align="left"><code>-t</code> ou <code>--type-shell</code></div></td>
        <td><div align="left">Sélectionner un type de shell (sh, bash, zsh, ksh, ou mksh)</div></td>
    </tr>
    <tr>
        <td><div align="left"><code>-f</code> ou <code>--file</code></div></td>
        <td><div align="left">Compresser chaque FILE à sa place</div></td>
    </tr>
<table>

Comment utiliser cet outil:
### Exemple 1
```text
$ bzsh.sh -t bash -f FILE
```
ou
```text
$ bzsh.sh --type-shell bash --file FILE
```
### Exemple 2
```text
$ bzsh.sh -t bash -f FILE1 FILE2 FILE3...
```
ou
```text
$ bzsh.sh --type-shell bash --file FILE1 FILE2 FILE3...
```

# Contacter
N'hésitez pas à me contacter ci-dessous si vous avez des problèmes ou des questions concernant cet outil. N'oubliez pas de me suivre!
<div align="center">
    <a href="https://www.facebook.com/profile.php?id=100071979099290"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/facebook_logo.png" alt="Facebook" width="35"></a>
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

# Faire un Don
Pour les personnes aimables qui veulent faire un don pour le développement et la progression de ce compte, veuillez cliquer sur le lien ci-dessous! Je vous remercie beaucoup pour ceux qui veulent faire un don 😊😊😊
<div align="left">
    <a href="https://github.com/sponsors/FajarKim/"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/donate_github.png" alt="GitHub Sponsor" width="165"></a>
    <a href="https://paypal.me/agusbirawan/"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/donate_paypal.png" alt="PayPal Donate" width="165"></a>
    <a href="https://trakteer.id/FajarKim/"><img src="https://raw.githubusercontent.com/FajarKim/FajarKim/master/images/donate_trakteer.png" alt="Trakteer.id Donate" width="165"></a>
</div>