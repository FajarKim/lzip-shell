#!/bin/bash
# lzipsh: compressor for Unix executables.
# Use this only for binaries that you do not use frequently.
#
# I try invoking the compressed executable with the original name
# (for programs looking at their name).  We also try to retain the original
# file permissions on the compressed file.  For safety reasons, bzsh will
# not create setuid or setgid shell scripts.
#
# WARNING: the first line of this file must be either : or #!/bin/bash
# The : is required for some old versions of csh.
# On Ultrix, /bin/bash is too buggy, change the first line to: #!/bin/bash5
#
# Copyright (C) 2022-present Rangga Fajar Oktariansyah
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
# along with this program. If not write to the Rangga Fajar Oktariansyah, see <https://www.gnu.org/licenses/>.
skip=87
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
]   �������� �BF=�j�g�z����n��|l�0���W_:�1��Z�Ȋ��kVr%3�_�0��[>��a�u�lPU���v$�m����T�-��J��4��4�s��b�R�S�'J�%i��鰵��\��惘�Cv������� %��FoA�h���a�e��/��� ^��۬/��$t��+�r�X=xh��������� GU� l_��P*ΐ�:}�[dN�����[&�jʵf��2@DoB�W&�u�9�r��L}�&���կ�n�W�:�v�֕�5޽���Z�a����sI׭<}��@�����L�)�J��(�e�e�I�#�~;�j��w���RQ����~R��`��	��k���!ڬP���.C����o���Z[}]�x;�aЃ��k���i�L28�^A����fmY�3Wi�U���Kx��rN��F&��ja�ª+��c�&N0���㳋j���>����Z���CCs ���������'4��K�Y}��(�RN�`�d8���ч׍�ir�{�k�Dg����L�\J�*|����.9�p���1G^WY��D7�N �|S�i��@w@O:w��<�~6����s���[�?|ck�b&[E�E��`�c��Vg�ӊjxf��ߜ2[#Y�D(��������e>,���P�u��|�|X�@R�Y��5�#�^�=��?J}�g�K4J}u86�"v�4T��I��WC4`�r�x�Ӛ3Ѷ�X��?��|"���� ��fmi[�#v�I;!v�B�[�
�N���YL��IlY�Mv�a��D9�E��#��T�y4�0b����{՞���iL�7�4~�Mu��X�!��y�ߨ?�թ��F�>�@,�`x��[�o���\��V@�i�v�|��[n4�o9�7b�@�4F:��/��}����N�'& �T*���PR!Kk&�蚰���Щ�8����_<'Jc�j�����@��<t9�yK�	�/?7����h7i���\ns6aO��K���{�&ᳫc,�d#6��}�v���T�+"���D����-�{�����a�Q��x|3�+"�����g~GB[�A��O�4�:�6ڿ��}�����8�},!&U�KBc)Μ������"�mX�|c?檛.u/���y�j��/?Y�v�A�~�"�a�ܯ�ª�<��(��ߨb��J�|��� D��t���ۍn���ѭi�r��T�!�N�1k|���iI=5��r��%+��ň���j���y.B@ɳ)vV/�BO�4<�]������Ǽ�g;q�+}�	�'�`B$@ly��� �n� �<Uh�p�G&{q���\^3g����,=:��;���!�6����u�0��;y��d����N�%����D���l�����HF����G-�)M�t��S��=�ڢB�F�f#;�6� �7Wi-ӾyP��	�W��D�Q6���^|��z0 (��X[���X��� '3$���胟Qz.&��Il~Uۜ����aR��#�)T�w��C�������z�Xz-�a����ڏ3սXe��0`Y��x��{�e��-R���xl�
���w/��&w�LAF�jόp}2��yBiS�R�-��C���	&Øe-��TЫe6ʽ��~k>����nCf1ֱ�w�nؽ�$n~RY�sµ[�4Q�\�3���n,bR���1����i�A�&P%�D�Z%��-\/ �k�/�a������/9�Мֿ3�$J�%DүaPeݯ
S8"+�g��B���H�CDj���2���i�<�i�W���WN�u鼅|��T5 1E3�j�u%��ΞY�2�]�"�;1��l���(���e��(�T1��Cz6?<p�n�<�^��3kP
����\�ڛ.���3lᴲs�\������h(���=�6[��(�-�1n�Ʒe��b7<����R\��;�齠���4��7�.�A�,��˝=��&�d�8,��U��&�����M��d�:ׯ@񂘼���7[�EVdK��X�f�U���7�̀c��>�n��|[X"l ����ABB�&�(3��f�#���2*w8��4���--�R�T3�,h����L���x&�B���a�憪&t�n�Ce�Z���+k�Ix:�g��%��e���^̆�ɡ� 6� �Q�^II��(�Ei3���_�C��<ԗ���h�D?y��IAs��8
���%�r��#
Cm>M�fՄ�����E�f���x3#�9�"zӠ�y� ��~'�j���Xs5S��we���V�;$k$���I��	U������}�C?��� �EZ*��h���{ȵ�	kl�I+���[�+m�9yv��Y̓�a[��(N��#UOd���x� ��DX�{^6������Yר��S6�ɼ3s��/	{�d��۩�
���ñs�{	��א��ي�.�8�گ-���m�5��9�p��i�O(�q;��%�QtVHސ-kNv��������)�p�rL�.��5Q1�>2��A��	��q���=mCh>�xL>��AJ��ם�}T����=KW�l�L?�T��o����������o�n��<�!�Sgƾ��+�gGm�������<�D�[ۺ��9%a�2�=���Ε�`Y�@$U���ʒXi�푃��1VyO�C�ބ�j֖�j�lb�#��m2�zڲ\��d�n<�1Y���.4]yD�8i(����>9�ΰ�'�"�đ�"�܃�����;����+i/tN�-
���?'��j�i\�(�4�����.S'�C�`�gvP���HP���n��~�Ls1���"Q��\����<uЃLf= C��@gv+�U=�7eF���xA��J�xYgl=���dF�6�s�}�&c/6�v}t}��%��^~�i������� GW����%���67QB׻\#}TR��^�
�z�k
��d���~.1��F��h�Q9�gG�t����|�j�Qi�S���Ġ"��d��*8$abZ-�2����M���/���Ȳ֡R��>�:Qy{����� Z��3��3N�фR��:��7��J9���?�;�C��9&ר���r�SQ���Ε�a.�-�u�r]g�X�n�9�������7Qm�1Q}�u����MI7?>�H��;����p��)�� W������͙�:(*S>��x�3VeOC�¸M�$ P^���pO���iu�W�f�aBB����8玩�U��%d�Wq	 ��Z];�� ���o�B-���X���s3w-�+z��V!u�r<�؇^������i�0�2tkg�ߐDs��{*����)�^G*u`&ʼɉLq�L|����<��>��M�(�p�]{Բt?���L6����Ŏ���h5O���/�f#��8�Od���pAF'�/\�O��	�%�L�C-Ð]�����ƶ���,�IM�\�����i�)���x��!��a��bI�bcDr:��<S�����W�l E}��y+�e��N�U�J�^az�w�-�	>�j]���J���ᵪ�2�&b�H��d��D�����ڧJ�>.Hު�P��WkǛ P��	�26/���'QT� �#�1�O/u@�s��W���G�	Y,��/��{���A�.I�҄�(N�12�bR�0'��� �܄/��gP�a�.J���Sm`*A2�8�֤�T�M�+�e����3����y��C"l�X~Q���_�-7{����f��	M�/j�lF���3��/���L�}	Y{4	m�4l�t>���V�8�7���3R۴�S=�
U.�
�_ڃ�%n��=�S$ �-�t_�E�Y	���ȶ�X��噣�jv�/,��W�t�('=�]��n����:ѣ�?�7�S��Bs��<i�&�B�"MIӞ��Y�_�M$sS����K�����x^�9�3T S�ٴ�h\��}wP���㎅��:�tqMf��:o(���^�+*�N5��8�ik���Y�iIJD��L`zrTz��w�S��*�����S�	[u��Xhm�p�c���'�(z���	���� 9/fO���G/zI��=7�5m�	 �%�ew½�R�VS�t��-	��9�TBZ�w��?~�p
�GۛQ#_J�-|���@���v-U�ҒSFzEϥ�zH@'�P6����~��T0�		R槠Z���FCL ����TaI�6`]^�x�/�.3�Z| `/qL��t��v��3>�Gk2����j�,^~_����2F�9�BDt�����H�l0�2�Q���8rH^�g*	����"�Š1d�*yA!�����l�N�h)j}���J:�׮��\�}��8~3sD��]�\^�&В�.���"2����e1�9���樿�NKȿ!���)��?�Q�s0���׈�u�y���XvapB�[�:Ad4�J�D�ca�V���u�5����E��ǈd�m=��S�j�٦����Y�:�����>IN|UW,�[���9����(Qg!f����D-�HKӊC�!���Z�Pt���+e�nC߼]�h8��D��������T�rg�g��f�/�G��k`k�0�r5��;����s�:�ÏJ߹�%��bܧ�x;���F�����z#bV�:Nd#�2��OLz]�g�Ⱦ�uk�%�z!}��s�y�e�Kp�u���X+��m��Ek�})M���.�j���f��A�}dU�k��k H!���y?SLg9���]�F�W�?�2g�t��!Aׯ9�/	�,qU�Wi�b��s$�;!{B��i��L�C=,���Ƹ��=�iS<�ܒ�}��ł�5
n�Aq�oG���-/��{�u4�q�Y,/��l�i�����aV	=� H���,��jEl�>��
�&BfJ&�m�@;R��X
�fc���/�KG��>���绔T4c�w���7���_I�;v���p W�Vc"�i��^!����銗
*�
��
�f ��3p}���ՙ��I:�RV,�k�
hKt|�0���9X�Z�_X����S �k�\
Rґi��2n�J������˭�j�#���b�{�P���M串������%BN$33�f�'�����t^�{�ݠ�*���YiY�$)��́�×^��m>��j�~lKw�n��g��U�P��I���%��R�?���L��Bv�&�'�q+?i>p�x����C�l��5�f���J0�n��K �,��r�AMS��j�`��a�Ho�s�xK���(�W�,�f3WlY����1
�LZ_���Ŧa�����Z.q����fBm��e�������4_R
�]��ؼ�'t��N���"�i�O_�a$���m�����<�6�,��G볊���Y	�AX�<�^�R�����o�_$_t1[��>U��EY����/��u1�?��>8M����$,�l6�)t\"$Y�5v�|�U%h<y��@n.v�f�x�.�5�T^a.�+���ۗ��S��I�Ѕ'�G���;���:����~
M�Z��Ɠ�CSoz��Kϭ��I�����kFJ�Pb�ې/��Xk1�eׯ���|��#nG9*���D�y:#�D(l1��W
Ձ�"�g^�A��CM�f�>���6�W�������
/��f��C$`��ΊK�CeҾ v(|2�&�2(����Y�U/>W���ێQcc3�������GR8\.0cV"$�G�@��Ϟ�X�����gi�aԺn�6؂/Q~�GVNr ��u����y5ҕgV�Ϲ����T�7���~��5����ݤ ~�6�܏/�ڔ�n�[R���7�~��(w�[Z�*�̣8e��z�F+��Q��[D�Yskjds���$a;�,�H�$_jﾗ;�b����v��JX������(ce�3Ұļ��$k��ːs��ZNhuYI|���[���D鴏H���=�{,��b�p &r���/>�{�	0�����>Y,C*���/&�˽�m�GA:�L��"6�m���v�8	饰�w,gg��o����XI�0~2��<|�懰���84}��OM����3���
w�?>ģ��[��I���^�t4g��F	}��?��jR�-��s�@�g�۟��}j���Y�egϓ�����o���T$o0W~�q��tJ띹��dک'Ai*����ڱ�\�p'ϔ��,.�"i`3D�?mtr�[c\������:���S�D�)�r`��D�w{���3����c��42ˊ��q>D�/H��wm�D診��rCxF<����x���z����D<\&Q#�`j����Ȳ��#��
F������+,��V�S���a������{���i�Te-�o�u��a��n�)�M�v�JD?(K���q���y#Yx���&q}eh�ގ������\�M�}'f8�Q�ղq2NV���`�`[�jf��J�)A��2錄��4��a�ŋ��q�̈1�#�^9x�uFo�H1QrƳ�^l#?rr��!�n�H��,�h��}ln�z�`�JJ�͢��t�S�n�, ~�it��2HD[n�A[���TS;u��,�}I��.�⡧oݰ��Gw����R�����?#2�,�N��� �wE.]Β���[X��Y�3 ibn�c�}�H����>t���ꨄx�Îm3HYzG���(m��ba�B�ZP�-Xê@�Z	\Y��Rm��.�5W�mH�����������՞���80L��������/���u�fý��!B��Z �����خ(�n�!n�HO�f9"���h�Zz#Y�m�X�w�>��	nt%���S�P�=t���$�JO����m����Wj�,OX_���\�&k)�l���w�p)RQ�#�X�&*%n��@�ד�W�0�	�5g�i9f6i��x!C������E�n�a�䄦���;-�w��R{z^��2I1΋h����ԫ���@P�x| � �y�Ik�G�e.\�Q��,p�<�I��J�����X~O[�J�����}�(��@̂n�Q��J�K��M��f`����6N�-�7~ݞ{�s���)7�3��
n178�Kt{��j5�[C�,�j���|a�����̋RUNi�&t�7L�xe�X
��H�b"E>�0.��u�# ��k�]�y�q6�_�Q_o�"Q{�m9�^��pz���\�H�>97��$.�eFy���WB
�s��+E1��
�L0yTF�E~\\v�,��wӍ�� � 2�`�PLI�� ��3 �ZH:�x@�(R�D�'yaʚ�f�%�xWAU�8p��=�!_ �|�FI�)�`O.5|��yy��Nws0��Y�',0^��'�Z�����.K�C���?���.a�E�31���Q�!^0�A�����N��:$���J��6�W������pG�@*���d9NF�&-i�q�����(�����q[>�&�����=]�}�X"]�#���Y��m/�c+�B} uR�m'�jZ|�1#�W�~s�ibiB�}U8=tqr��$��ӆg ��J�9V*4�HMW�PH���I�	8~�z�,�q�=%k����h+���e�����/��R�c��&�JK��#Q�	Mæ��S���MD�C���+ܸ�P�dx�6d��Ľ�8�:���t�w)��d���/U���
�;�ŷ�,-w�/����G'ٟĒ6KS�&�1�9ϛ��+�!�����4�ݐO�]�~�A���̐~c$�}oADKӷ�
Pj���hX S<����I2�d��'�\���oҼ b픱]�t��J���:��ù~О�qw�_^��Ru��Ay�(n�Ч�u�P?H�*��=,T��vJ?�:�(�xL~�����I_�o�H�Y(E��[J�B�.�b�im� @��J�#*Z�%㔟�pY��P�R�d�S�;�昗�I�u�h=�X�fk�P�
��h�k|Cc�z7+(X���ş�Ø����J���߉�?P��=��LXS���?w���8��7#'�"5.�҆�;Ӟ��+����Dx�N�.�?��b���N>�'_w�B
P�sd�c�eYY�~
�,����F�QN�iP�r�"��A���u����6K�5/�:'�����<�Mv�>�g���7&JS�7f�]P�y�*�V������ �*�m� 6XbR���>'���l�?�����E��N糿����n����32�5<�r�2�r|�j���4B����Qg�������0$J5c��u�lͩ$h�Vg�\e�D�:zU�G>3GԖa~3!�(\�T?���Kӽ�>�\d3A�r+�Eq�2]��B|l���y�������spH-=�R��N�$Ln<2$��Wq6��!�ʩ��s�����\C��������n�'�q��΄Y��zsc�Q�[����m�2k������a
<T�/��U��������w���J�'�|��8˻뻬����%���?������!�q���pL����`��3;�N���LSJ_������ܹ�v������J�U~�/Ґ&sH�#M¶����Y#��u�>W�ж40�D@��9�� H�9�TDo���	xbg��Ԩ*e��O4�VƦZJW�|�k-ו�]�=�Ԭ���'a'����I��XW��[��"ԫ��Y'\^f^���j3@,�x�I�)����<+F�	,!�͛�s緾j�(y�̮��j�_ZP����P%�-E�?�@#(���Y�_]8{s����vZ5s�E��걟q`)�ܵYuQ��(���%�TlU��,N{�D��>!��z��k��޽�����˛�X�4��N��&C�M%amLh���_�ni��L���@Hf�R��!	����%�6=
|�L,*����(��B�"&E�_Zb'�_�0����6�p�R^*����C�\�b"db?&4ε���r׻U&��Gn�Y����s���o|�1jJ����MGD 