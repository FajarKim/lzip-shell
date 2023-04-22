#!/data/data/com.termux/files/usr/bin/bash
# Copyright (C) 2022 Fajar Kim
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not write to the Fajar Kim, see <https://www.gnu.org/licenses/>.
skip=75
set -e

tab='	'
nl='
'
IFS=" $tab$nl"

# Make sure important variables exist if not already defined
# $USER is defined by login(1) which is not always executed (e.g. containers)
# POSIX: https://pubs.opengroup.org/onlinepubs/009695299/utilities/id.html
USER=${USER:-$(id -u -n)}
# $HOME is defined at the time of login, but it could be unset. If it is unset,
# a tilde by itself (~) will not be expanded to the current user's home directory.
# POSIX: https://pubs.opengroup.org/onlinepubs/009696899/basedefs/xbd_chap08.html#tag_08_03
HOME="${HOME:-$(getent passwd $USER 2>/dev/null | cut -d: -f6)}"
# macOS does not have getent, but this works even if $HOME is unset
HOME="${HOME:-$(eval echo ~$USER)}"
umask=`umask`
umask 77

lztmpdir=
trap 'res=$?
  test -n "$lztmpdir" && rm -fr "$lztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | */tmp/) test -d "$TMPDIR" && test -w "$TMPDIR" && test -x "$TMPDIR" || TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
  */tmp) TMPDIR=$TMPDIR/; test -d "$TMPDIR" && test -w "$TMPDIR" && test -x "$TMPDIR" || TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
  *:* | *) TMPDIR=$HOME/.cache/; test -d "$HOME/.cache" && test -w "$HOME/.cache" && test -x "$HOME/.cache" || mkdir "$HOME/.cache";;
esac
if type mktemp >/dev/null 2>&1; then
  lztmpdir=`mktemp -d "${TMPDIR}lztmpXXXXXXXXX"`
else
  lztmpdir=${TMPDIR}lztmp$$; mkdir $lztmpdir
fi || { (exit 127); exit 127; }

lztmp=$lztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$lztmp" && rm -r "$lztmp";;
*/*) lztmp=$lztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | lzma -cd > "$lztmp"; then
  umask $umask
  chmod 700 "$lztmp"
  (sleep 5; rm -fr "$lztmpdir") 2>/dev/null &
  "$lztmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n' "Cannot decompress ${0##*/}"
  printf >&2 '%s\n' "Report bugs to <fajarrkim@gmail.com>."
  (exit 127); res=127
fi; exit $res
]   �������� �BF`�*�+��)��l
�!=�N�T/ԡ�Zi��f��~ϗY��@�Զ�)�Z2<���%c*�/���Jn��_5�=��RY�֔�u4X=pi�݈����0\+�LY��|����`ז
�)پ���|��g�Q<�Z�F�Y;7�_K P��GY��9bS���H����Z�w���d��C�3p#@,��9�U]��q7�W�ޓe�r!��6(�ƀ�y2��-g�QL��HY?�m7V���a�^!J�b���2s����TM~}uBrM�z�T�؂�bY�s�Ƅmq���]�����q�U%3�6��M s$���Ы��n���7G¹�"�x���]�T��,��zM?�t��4+d���3���)ab�����jM�M �\�N5�%����N�&�)dN}����	~��P�E��|G1+�#?�JΤ��M���:^`��)�F|����-jP�QS67�#��r�r&��!�H��Wl�m���#����L
��|�t8� -��ת��p�{��Dؔ�EB��GF�~Dg�=\iw �|�ETSy"'���=Yp�o����ć
�ūD0���yK�
�G�m�l>Ox���u�h��r\�t��ޓ)4����.�d�/�����5��H�
�+�<�7���n��/�l�@v%�j��>���Q5ǭ���S�;�Dg;�Z��m'g-���=����}���u�o���%be� cp{�R�t�~'v'>g�V�Fqz��i���n*D�_�R:B�蘒%��k[��c䂢�"&(�m�m��ld�cĨcqo����LjMa�c��N��ђ`j)�i����Z.����҇-A<C��"><!�/w�:���ݺ
���+����]�^=D����J�T'��e^@c^�&5�h�7!���.��E�02�vӻ���TMGX�+�EJ�2��z��xCq�M���w�^?�� ��DD���@�_�q0cYB3*R�%'�Ξvm���,�2�`[<��5U�t�7�X���E�}iG��bG&gv�k#�;���:���Y��o���@���}�0S�>�;�/H�%��A)U��狦��Z�ү�v��`�*r�B�V��Q@�n�?�κJk�qvf	�G�Ω�[����A �\��&PB+KS���.2p��B�P('��8ɮf��,Ub��j���G�{ �kW7D뻸�Rw���\{v���hy����8W�E]^"�J����A̭P�ݏ�~�Ϊ���K��v�gr˯�
Sf�ִ���	b{M|�We���"]%��*��&�'Ե���W�1��x`_�B74I��j(v���QA[&�F�7s���~#�)�p̚i tp׻��Bn%%lgiw��Y��V'daJ�ރ�O�6�<=*Cj��.1�jQ����l���[�L}=�,CH�,�59��`�;I�+��6�&F�x��1(�v���r�-��FoyP�D�L;��72��±n_v�"���WS�W��m�e���@}�g0�q[]=\�;RS����r��Bv�O[��3�&��Q#{�8�[]��"r��N8%�� ��hx<2޽kL~ti+H ��ax}�N]��<��R�W��-ybYQ���DiQ����mR2!3�`��q������a�#���0��f��(�������Im�Ұ��N����`yx����c6V<Uz�t�B�6C���r= ��!�����O�sQ��oJpH@�^�d0�8�>t����Ie���Q�+67���6.�h<i������3K�2�&�S�K�u�y��[�!�`�(}�sTL.�ShFC�����κ3����#Z�X��Aa\�j��-�\�R�Ά5��"	A�Ŧ}k�B�\��C�Au�/at�?���]��Y�-�p����_�����ױ���FX���溹�D���M�NfX1�\�@t������<�=d�_��1�-��tƵ�"�������u.���>0�����U�[�'A�#�H&2��ЛP��xP�ߡ��J�'����:˘6��2�]i|�7rF"�?n�1�nR MZ�sN��K��^p���<�7z2���S6��E���#�$��"�^�3U ��O��X�k��u}�'H�ܺ�V�(� �//��c'-�)�?�AXT��Đ���]q�di�50$&Z��_�>i�����cBh�a�;m��]�K���R�4�����Si��|�-�D�j.�i�u,?^뉼�`o�n������t?���nJY���8���g@g^�%��+K�cZ� r���bē���|k���z����Bఆ���χ҂E%����T�%��o�?��y��e���&?��������H��+�x�
�|\S����EDsKJ�%�G�!�Ӱ�,��xܼz�_�|'���\���}J�A�6f�p`�OOxY�:}����RZ��c5PC�"�m�z�(��*,��[ByDS�	9`2��;�p���7�1�Hf�Ix6�}i��Z�i?�i�Y��h�:��"��ʗz{��Y!"�x	�qr��bk)K�51Of�q����<�/Wj�la��ٯ·�XI����ߋ0[ds=�0^'�}?�c��DG��'���y������U���
���U,���B��~�9$��6V]�D�|Y�����i��� �vC���Z��gI����#8l!�&/��k�ua���M9��e�`S�Q6ĵ��WRl-��Q���h�Ώg�d���.<�J���࣎[U��_8z�������Or��Y�0o�6�Rw�0j���
�������Ҹ���v���n�~[[4�䣵| �J�7m1�@6KƞѼ���^/I��Y5�X]o=����{Y6�i�c���n� �7�e�b����N��W���(�x'=�B�N��?̌���^���}�~#�ͣ���|<����Bj6yB���a}>�3Q�h`��6�	j��~	1���e��Fw��k���v�ɇUd7���?wT�9<�Q��
�������v8eiQ"���b#S�^�w��oO��F�n�Jx��M8����\�<-As���	y#X$���L�=8��g�&Z�nju_�GT�=�X4'H0S4?{~6�o/\���1,	�2"G����_�+�My�]�������.1�� -��6�ѣ��m�O�1�!8B���2m��y������
�4�)٫K�7�s'J���V�� �dc�dM7,E��1됴w��ݔ��4�,�ks���.�ܪiEI��b2#�;�x�Z�j�����ʹ�����iИ@T�����Fq��%��>Ց�p+���lr��T0�oo��&n�h�P������X����}|'z��OR��9�7�%��`�������~ص���(�	=4�� z6��e
�A��&d�����˗�v�ӿ����a	��%,%��ԇ�Q{R�/�K�@��V��g[���cb�	<�C�b딨5#�wk��Lؙ@��G/_�=�oX��j$���kBSulK�N��ө�F���>��}l��ilhz��)�8j�2�ߗ���w�Pd�>�Qd��4��Fӑ)�3�s�� b8��hG+YN:�_H!/��E�:;,�!`��R��m;B���4�g���h?���^��K�ٟEtY]����J]���S�� g���U���f�`�m�@F�Y���?�L&m�>k�.Cr3�ez8����d=">;�m<{�A���3���y�a�m�F9��n�7�o�w�d�G��q�|'哞����~A3Yzޙ�ьPhÔ�o*�lӄP%���]�a���7��6K�QH��
4�┻r��H¸�����5u?����!Pr��!i;����(6,�Bf����(���OsrZ�b�&�����|O��r Y(	L�s��n�����/A��+�o)��jPX�����׳@�ES�L�
���������L�!���wN}�(�U +�J�GuÝ�ɦa���)��j��N`�p�8�M&mmk���zO��W	��8қ�wDyT8c;*D�Q嵷;���e�Y4�~2���U}�u��ks�7
��P@���/��o�Z��Lc�����z}s�Bd�o����=Ƚuȉ�'��s�;WL%�d�����Z���l��3�,��?�(�i� �v�冥�³���������_5c�k \� �Xj�0<~P��&���9 �{VM3=.�5#L�x�W��3 V<�l�m�����j�u��5�2G4���v�1��*��u��8p�� �d�6k.ħ����[�9K����IQ�ɦ�G-����O��%�r�]X{г�}V©��l]jwa�J��Ѫǃ�'� cM��b�4�T6�@|l��� F(d���?�09f7�`��D�xe`vd���<���or,E����8