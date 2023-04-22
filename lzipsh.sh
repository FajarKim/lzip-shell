#!/bin/bash
# bzsh: compressor for Unix executables.
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
]   �������� �BF=�j�g�z���a�HO?Hz�_��*���@�X�נ�����Y;�耻mJ��Hp�H,*�W�pt|b��,��+�d�����C�k��p������nh(�0@T� �&VM�c[XDR�y峬�+:cw�*��o��2��x	RB:Ny�*<���ٯ�X�W����)�Q1߫��h�v#����Vn�\�p'HA��yhq�@����_2��<{a�����{ϔ�:����T�����O��eΏE�!`kt7t��<�	=Z�!��(ԪW\VDn�����C��;XK��ݠ;9��5o��"R}?e&HK�严�"ۍ����c����!x;֡���25��\+���\&}��L*č��.�	���Z��O�@@��S^�6pFyw԰�9�f�M��sYy8,K��z�g�*�&�l�;=O���Y=��O����-H��*��2 �7�O`�><DJi�)@\dX���|#��w�Չ���A����"��,�����iX,�$H،�QXT����nw`�8�2iw�>�FBʜ!wGB�ZJ�g���T���1�Q��)��0 ϼ�5;�ts�����K��3ҝ ���߳���۽�NF���`�O-���eh&U��x�B93[q:���Y�w�4��6>����ױ_Mo�/�z�0��� 21��d֊�Mƫ��kp�]�t�.�בPD�k��"�?��X�<�	�<-i,vҳ�Ć��"�[*�5�I����6��T6`�(��.�D� v�@��ܮ��?�I7�p�3촍�~��㣵xr�\�Z�Y�����qp%z�Q�$k��1�y��q�Ĺu�l�.���ǆ,������m��qL������e�e�H6�E��~A���V�j�=6�d1���,�z�+>)�J�c(����R[&Gf����(	R��t.{G�G[N�.k-�a���v@�6�<���.�o���ϗ	�%�H��J�/�;�3a��+O=G�}���Zw���`lHMT����6�830 �T�&���mb�h:�USf�t���q���I���-�I��Ⱥ�p@�5n�'�R8��2�h�2V�
# Q)jX����Pb�D2s��/�Js�K����y4�>�I�1���̋��,��@����E����7�Ch�{�-��V�����W��M".����-��X�9RvY9���VV>$�e8�IҾHH��H���,�~ek88��-a��ҜD7n`��k� 4b`��qX�
[&f��꽤y�.���N�>h��/%��=E�r	��~��\�� ��WH)�Ϻ�ľ;U��6!L��η����֢�N���2�|�u�<�L�&��ؽ�f����<�>�k�K�q隌p	U/��{ �.l�8?����l�l|c*���'��T�{�QJ�Ty
��Qr~dδ����kH��|���-�;�4ݯU׈�]$#ڞq�"�g�a��r�s45#��uiZJ!pٻF�PQ#����e<K_V5���J����0��YhnB�# a�C�d�P�!yE���R��14�y�L��x Z����-ɢ�AX�+���y@m1/W:/똾,/��H�R����=�i�E��G��r"�D�����99���E[zN�Dm��|�eI�4p���bLA�?cD��vI��F_�>{τ&���w��3�ʍ̰��p~� ���?0�_5�[�zsܑ�qԟO��E�w	^���
���pdܚ�T��N�C�j�c���!nS]����	�b�
�?�D��!�?���3�kx�������>���"�
���Z�E��//1𵅋~	�Ms�w�b%�Fȕ��L��l����&<��_��tH��C��E(A;"��8-�O?��0`��6a��
ĕ����H�2���T"=3p�WϬ6l�ޘށ�W(��g���W�)�Nb��_c�VN�{������;�vx�0�,Z��,��JL��b�h�`SI���щgx5�0��A'F���}�ǼF��$�9���6�wn�����u��TYN�m&���{�y�_.�o�G�6g�����x�`;m�54;�c0>IczgJ����^"�m7�w�O�"A��-��iىW����+�ң�ǒ1a�$�[G����ϲ�����Y��6���8�:�Hf$����ˠk���b��ڒ6C��������o��54��������%���?OR!e=V����HU�ѻ����F��E7�_J�7P�?�Q�L������/���Z�p���yd.�K�)Sqo1�sM0�ʙ��������X���>1���wt���0y��Kn|uჼN�G<~Pd&�ͅ������pR��3j��5�K�d��f(��� ��/_�x�gčYku$�� ����p���H\*���F��M��f*q�Qgh�`'����P&�0�{؀��>{7��P���k;��~�ô�暋����l�Zlu.~oqW����ηS!��jkRi|f�o�K��V���%%�kO{P���`�������J@_%i`KJ���5�����q�2�׼�(�_|3������uL���	�a*8uC?���%J�9��-@��T�h�}E��SW�Eu��~D�Kl��ς�k�.�CtRc�L�5�$0ǘLO�M�p�у�f�m�:!���eB�Nô��e5��w۸q���f���Y�٦#�F`_�]b�ا��k�s\F��3/�,@�NGK�i&�-�T�vH}�D_��eJn/��e�<7R�ȴ_����y�)���F��_3�J3 Ԕ���N�μ��a(F���{���R�it�ɺ�N*�C�c��K������AX\rB��Y����.�'Gfj۵=�=��U�0�eu�N �P��Tdd ��y�=�;O\�������ڟ����Y�"7w�+4Ӆ����{�#��MF���L~��Rv�ӑE�S����x	��r|(v��ٍH^)2�]���*,�fp��x�[j�+��àhz,���3B^F��o��{��b�`�ljA9����8@�>b�`+���V�`�<�mO�\��QV�%�w�[˯}�Dq����6��<��?ۘ!�P�vL��SA�Ul�Uo��^t�'ټ���
����R[�9���A�o�r��b�/`2�x���"�O��zm�O��3n]|r�`8t~zn�Xzw��*2��N�w�\�Mh�lU� �~�2W��,	)�ͱ�x��9���7Æ�4s.�,]<�[�3Ӄ�C�ױ:s�i��D7~�̦�&�Bhv�a��^p@����ҹ]��j~۸�����I��ɭh�r|� 7�_Va��Y���Y�ф�m���،]�(�	Ý츲���Kͻv3�e���_�qK�k8L����3	�z�NF�;*f������+p+0F�2^,��S@ˣ�X%�\[N����l�
���B/��q�������_�	�9�ƿ+��'0��ǚ����&�P�õ�h��l��#�Mo�>��ￋ	&`V�:�Q�ZS��YW)յm}$��~{,n�{U�Zqz�q��{�ӓ��q�<�|dގ��M�N��S�%�tj��io����[yݢ{..�e���t��sj������1�yчg�
c�u��Mf��}��� ���H��/�'L������~�����'�lv���I�􎯦u?7-���IC���M��-t���J��?�i��k��b���H��Jn(���)�"oH�)(���Emи�9��+�5b&H4�ka��f��F��1#���U=��4x�O��Y�G�1؊����W�d��U�����;� ��O�C�8x��F�5h�^�b��N��;��׶X���`s⅛�z ��q�څ�# �;��R2��1=8�$$E�oGL��V�����C_���;���w�?h� �����&EG��j�y:t�P��|X������ � �;i]^�%J�K3�d���5��e��� H��N+L?$l�a�'�'0��Kcze����m�H����c_r����Peo�W�E2Y�H��,v2t�M]���P$lP��)�n��gA���˨\�+�񇣘�]FG?B_uMI�4޿��g"ǰ�!j!%!�l{�RA��c �@|F��)k�aQ�O݂��ĺMI��u���Ԇ�W@�M��$������\���r�#�g�f@��^ol�s�OV'T�:��)����ǌ*{��sֻ�` PM���L�6AD��m�V��b�|�r�Z`c4YC�5id`�c́��<�Zs^�j���*�ܳ�W��]�_�1�m:��]�N����U̕�Tq���ᕗL��V��|�Me�����2U�v�҄�\�k�ɢ��oo�\�kF��hJ�Q�Yz��� ��D5�g�6�]�ʹ� 46��LG���2�� �>4xh��VGD����oa����gZ<������e�q#c�K�b�?O�y����t ���P;�v�a�wݎ� L�k��}���=�03y`Ol�Y�}������q�-}�k��X�r�3�t� ����.J����q�'e�r�}����!��!Kq ��E�O��A�w�խ��Ai;�e��zT�?���;#-s=��fn�9*D�#8 ݺ���r�6?=��-�������I�I;�g�A�#V�ޗ�@0D$=��Gm����š�bv��w��T�{N���}���7	��<�ӣ��#or�*��W6���Eqf}�InI�*^��LF5رj5�����$�|�!�贘rZ�b��.̤���3�z�cT��X�t5�?�!N`��Auc0� ��muN��AH�RyCƮ��4>�C�5|�,0A���n���%Ou3�����7���9���@����|�L�S�pb5V�8+E���>�j��&�%)����KU����(�q��='���fx�X�z�n���FҩkJ����rKML	�N�٦�UGnX�[��b��]!Wt^Aw
0�T���L�V5J��F�
�6˔��|��@}ʥ�3={7��Aq	�Fڑ,Q	wn�x�WX��A<�V$WQ����hU� }u5���+ǯ�鲹��9v���MM���ytMK�B=����̣� x���)&�+��<��W���+ǋ�W�@WE]�Өr��T���n�����7�CPb=�hmN�KkJ�S�&tv	߽a_=��u�6av�nT:��&e��c"���F���e�14[t�C7�gc ��p��^j	/�X�L����ѯ��� 
��̂M�o��q��������	�(zr?�~�]��+��#�!k��fi�d��|��U?����q��������d�Nsn�2��#�g�5�(���68��iKp�A1����G�۽� ����z[k=��6���"�8\�O���t�r=�K�-]~�Y�N��h��L ������ūN:�"��=�So��u���J0�J>��r
s�K1�	@��X���:T��>[ock���VV�����`ey��2�RO��(ԓ�7���B����O������9�k���6U�Te��ftE�<�h����#fY���]Bcg_M-���]�Qc�b	��W���a��R��ݢ�iܽ��XGA哋��JQ	� O��s2sK�If��q�c�u`�͹?8�t:V� ��h�	�9�j�Yv�NBm\�� ��`���r���1\n�,��Vwy�f���毛���,����͌WU\B�M�,,l/�ܦ�T�3��-�#�+}�����@�ʖzI�����U�2, �;FݜAVC������W%L�͋�{Q�YOۍ�!�uZ}Gߟ���#��cMV�#xJ�@Y�|V> i��B����.4�Ɗ�k�lɸ[y�w�n��Fj�H�B���Iz&6+�.FD�A�Fv�A�ܻ&��OM�R6��a"'M�=}r#+�k��(��(�,�]��P`��aԯ*3^s���{�������]0H{�C0�[Ѹ�W�q�t,?|��� ��tu����7׭k<�sբmSR����7:�$�l@A�8
LK��^9/Nu  ������1��C��H5���x	�NH�7��A:%m���!Z�̴�H���`o-2���
�,�s�27�RW��0���h̑=�s,��� �=Bwi����|tb�#�*�3���q�'Fb���0�ϰJl�����,�M.�3D�h%g���8v+,ʟ�}wӨ�'�8d�Dw4Wn�j�O#R_!� �؟����vh����ќ�q(��~�c#i7SY�~�#"�N���H�
���#�6.*�IZ �E�����*fp %���1�}οmG��M^�(��]ۭ,/�
֙��]�B���#��������� -Kv�5w&�%�j�#{o���0���I�0�ǣ���-ˇ�#3����;gN�m[��21Z`���3/k6�b��߆F���m��7|�c4N�LxՅ����y~[���z�?�Lš���?	1��:���;���Dk�4ߘ�&(�b	�����ѥ"�Z(ĽG��3]�R��CY!���{���B�D)��Be�����k�q���0��h�N��D��-h���2�o/U�/	�w�ž5�y+.���Y/.�u�q�O��D=t��R\�NV��MF˜1�;����A\���Em�_���J�wc)H�s��A���/����'�E܎�d�S���|�e<���<{.@��8�%3vN��r�����{K?YG��ܑ�t�N\��a&d;S�X��	�˹�����G�U`��W��%�rf[��>� �J��+p�t��>���.7�w��hl�qT����g+��r+l��=8d]���a�y/��F��h��zꌜ??��R^[�I%�8�&�ĤA��@�j�Ư��{LW���M��m1_�!Oh�
�����|�C;AN�;]OkLv l@șyr�>��� %fL�?8��,�����W�z����or^��\cG.���)J���cH�+)�G�"���sYv�9���{�;���<�H�� !��*��z߀Hd0��� _�8\������!V�?ݭ�9Fc��S��F��L\��`m:"C78tOC2���Ö��{Ԩ�/k�r���)�$> �H88D�~W2���"�칠Ymk<��[��H �3yh ,��{�d�<�w*5	'����聎3꺣2�6`�6|W�
����*w����%Q��!H2��,8��l�dy	��L�̀9,}2�i��vǭ+ E�܎o��7��-,Ѳ����mo�/�ZT�
�zEo�'����+]�*��X�.�^A���Ǵ��U�����;r<���t�%0x�,�ƪ!OZr�-_�+-Qǚ?�2hN�li��:F�r�4]x�+���y-�7v�H�\��{=������,rv!X^0��TlC��<��`��4JVcY���H9&A�0=K|b�ܦ�h@�3���T����q����m���ұ��Q�J��'*���!6�,F��a��\��P�0ę��M�=�O.lj;�h ��l������j��������Q�KK�,�hP�m��B�y�JUސ�p��XuڄL��'N!ov�����z�����(4h�$v!�����u2�VE�>/��x�1�y�H`��l������#hft͓o��}�9�g�t�����9>/��ߝL�<���@��е.����+��̹��-�tb�n�݅ILj��˅������/6�~BX������xs˖*8��X��j7|�/5� g⢍b�\�ϢI�gd���r�7zyedU��N�k���n]q�I�&S�ۋ��� >��3�׸�V_,���0>f�L�4�D���u+�Rs3�K�Dk�ۖϠh������3�D4�j~_�P��-��0;HT����l�@J�G����[eՄwL�Oq"n*�v?�ȸSU�4����W��rPފ��<CW�Fץ�Q߂g��� �U�ї��E$e<�;�'i����YB3f�p1��|+���|!|�����+M�:�utP������U�7V"{�zXK�k9���ܹ��U�m��	ޯg�|5}��*��o濑P0��I��Tv�1��/بg���v9�.wC��X��u�Y��5S����}p���0̏"w�qû��mW��~�ʡ��*��`�Lp��i!����U�Z�zU8��]��H��$D��4 N
U3�y��������e����mV�y?��S/�4/��f��{f��f1��WZ�o�q�,>j?hx�/s��
[!B�"i \m[$������ox����%��U54x��&����iZO���ɒoih_��yb���6�q��aj�C�ۼ'9D����m<n��<��*���|$�.0�7��^�8o��)�_��AX|�������j^ �p7 2v���f����]�=��&Y�F�g���(N�d�m�L��	6T���5/�}�!U�o�rq'�1�"}J�y�:��<%�8틷��!�~l�����#灯#ik6����y��?�AG�幆�^���mt�y����@W'.�[j;��ޞ�i�,���1SW�P�P��O�ps�����IWXk�<�9e�x�>��Q���y��>w�k�q���V���p�GCπ�0OO���47�rV�>9����( ,p�������5��!+D�9xŗԃ��K��dP�����*�bW�+�u��T�I�S� ��jWS��[�~�X���X�v���l;,�A~+x���[�O&�b 32����Pe�-�&��1�%к�q�ȧ�DHF�_m��&ʕ�iٜ�2�)� 9�ŉ?�L��