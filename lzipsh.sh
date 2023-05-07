#!/bin/bash
# lzipsh: compressor for Unix executables.
# Use this only for binaries that you do not use frequently.
#
# I try invoking the compressed executable with the original name
# (for programs looking at their name).  We also try to retain the original
# file permissions on the compressed file.  For safety reasons, lzipsh will
# not create setuid or setgid shell scripts.
#
# WARNING: the first line of this file must be either : or #!/bin/bash
# The : is required for some old versions of csh.
# On Ultrix, /bin/bash is too buggy, change the first line to: #!/bin/bash5
#
# Copyright (C) 2022-2023 Rangga Fajar Oktariansyah
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
]   �������� �BF=�j�g�z����n��|l�0���W_:�1��Z�Ȋ��kVr%3�_�0��[>��a�u�lPU���v$�m����T�-��J��4��4�s��b�R�S�'J�%i��鰵��\��惘�Cv������� %��FoA�h���a�e��/��� ^��۬/��$t��+�r�X=xh��������� GU� l_��P*ΐ�:}�[dN�����������K;c�A�r~ƋX���E�-)��_�a|�)��	�q�\^��r��IY�-��D諺:����T���l���4�6v	��[�%T�772k��L�z/�Y�����[��(���e6GY���h�bv�,ݥ�bGI&t!�+�4��ْ�Q>)Ω�>�r-�#�[��L�27b�z��$$!��uA�:�ԲSm���Q�{3b_`��s�"#C�1� �-{V=.R��2CJ��w$��.e���т�������	#'�2�g�Ҁ�՜�#0�G,@~C�O�W�X����KҞ�I��/3�Jqa�����1���+��ja�@����Q��d�P<�� ���y����J�~V�L�U#�K���Y@ڑ�&\���+mX�`������|;x�,�w�@�V����� ,x��l����g�ǜӂ�)�e�TO]v����L(Ih�f^mg4��1�A��׏�D1F�A�����Ə��m�d$�Wc8!���>WN�sH�ϒ�-�f�V����tO*�o/Ԗ��X'bs)��Q���F%D ��k�&b{�_G��2�5����ׅH�L��m��v�Px��h��8�:�s�VtQ� ����gui�\�����L���P��'�d��=+Ǖd�`�S�!����`x݈�h*r���q	\+BL���
!���F�q-=}nܪ� m[&�0�|q9 �G��$F��/	Y�M�]�����oD���<>�� ˁ��w$���J!41ۓ���K��,E��l��~��!�jg���� �H��u���m�������L�w��Wg�$�y����#��jo�#o%xf��:j�V}J�_�b�gW�g�rY�4`�v�s�x��^����i���eIo��z�?�,g�Q����RcaM�p�B�?����?�)�V�Np�:S]<?'��T���������y¿Uԥ��^�~ʍT�[���:��̒��]$p��o˧�0����9}���'p6����#���=s/_A�6�g��Db)���ھ[\�hQ����� ��:�M�C�~\�?X?�Ŷ��o�o�Ϡ�H��`%��G��$L��y�p�!O�@�<�6��k��H�c?��9�W���P-m�b�/s��.�����r>��>���%�ƚ5����3*0#�/�?�����x�:��9�Cuzx�m�/���A�� Ol�J�Dj|����=�S��νy���\f6��/���vta��p�&�Xk� �#\JRȚ�J@+?ڇ>ڧ�����EݖB-(g�qe��y��[�ٜ����HQwC�^|��3a2�NM�/�lT����{hR�ޗ�H�Ó#�R�"n:��%1z���E�,-�p�8�x��W�s�2���[ xP1��؊��ӌ_��?cر:8�o+R���ÿ������m2�eI�Գʑ��ͤ����&8T��#��K7W�n���U����:��e6�p�E��l��~;Gf�%���3
��F��d��O
YO��l�{�{���������"�͞7�m^ ��&����O��,GWxTKլXJ���؝�&=�ĸ#��?�͢�����&��D�E�a�Xb۳�+Q,��6�����0
��V��~k�����]o�T�r�ս<���_|Ԇ������c�ht����PX�'�3s�N�����c:<��ߐ��,��*���xO*\�x�Uu\	O��p���<�� l����>���!t!w�G�0�6��K����FP(���7jP/�Fv�~L��ѯZ:e`�p��d��#��{�����WWd�$��f��kף�95�����(/v��J�;����Í�>V�:�,(�D;��D���S�7��5����v��>Ź��L2i�	�c��+�}us{�HS�D��[1���S�ڌi�{���������<F�����Ȫ($��#�WH��Yŭ�	�|�nNAZ�ά���̥z���%�P9fs���k�9��
Z#���g7e��谉�WWN��Ղ�ȗ��1��4pĤ���i��&�n ��E�7��zb)g��\Y��[���ڬhNM*L�@^�Y
�9��QL�
�jk+�v0��X�<��v�?��Ą�p�_�CvvE��.��0������lV���b]��rM��ПFn\���oYVn�)��r�7ǳ�w8�jRL�:��G��������hOu���
���ýW�>j���0 J�Z�j��\j�諸�/'�@��	8�r��{VM蒷3W�8Ƶ|���w+����yW�S�Fv�N��y��:<(��tYy��T���?�rG����n��Qn)�װ���=�<}�PO	�.�	Sc�f��7T�Bh*Wg# ����߷�ޣηB��iwO��l�4��Jn9�q�ʤ��qP�[�S�>'%^�G��g&.sB8u��,L)����`���W7*�^�g>��3=Ky]k��vˢ��#�s�Hp�#`2�֞sF����#�h��w�L�F/k��A72�)1�k�Ɂ�Q��"WDJ�/p���+?"Y�u�_��1?`
���{8����o��sy���(�fx��������P��;A}l����=�]doa��R��x�o�|��o����o���os����'���v1�3'L�ٻ���s�o�����0n�dt��hO`��z���p��4��Z��Y�}���+3Jӊ1�t�0�w�!!gMs����F`���Cí�:��a�������/��}���wo��/�A%�!(^��~v���Ӏ�a �ݨ�D_��iE,#��BE��;�J�3��`\���^;�L�}k��ஈ��T [Aƌl��D�s	{"I_��N�g�I�ʿ�x.�ב�,��P���$����'�Hu &P��&��Tw`��<F^�c��GT��a�F'���^{�^*��yX������?P�ٰ踓�©��2v���3!Ė[Ȋc��m���c�X��C�"���O۶s|yn;��g�V*�@��^��;�a�e�d�1�lx��	$K�b�˙7���w]�ߤ��9.B����
� S���D6��qg�����=�#o/�"bm�VX2^ �mG޸+��{?{5��ߢٔ�H�.�LaL��(^RZ�{@� �Jy�?)��o�n�+���&�vX�t���*g��E�H��c���.��g�R}t����̇�����^�,�D��3Ʊ4l�ߙļ[`.n��g��4�Q
�_� ·�ߕ�.�����uS2.ӊuc���s ������Z�9��3
r�O� B$.����V����L_��ݯ�NO��x3!jm�B½Kʢ���-ܹ����M�� b� �/��8I�]��R ��m�b�ۣk�"�-?���0�ʞ8�9���\ͭ�vCV!����q�n;1Cr�`Ѫ+Ml��vv������G�.m�?Q�4�+��馃�Rq>a����� p�֜b�
��3&��?vԑ6� ���*s+_
D��Z�E�=�Ό�9ދ�؞Z�A�,g�R�4j�>�	��
�*t*?/��w�)����h�c�R�Clslao���r����t���Ğ��N�-ڭn�����<�޳�%A�m��6�<3��@��-�W3��Se�ypJ.y��~��b�⛤�y�����DznC���LZ���i4qF��� �T�H#EdB.p��<�j��"����˹r�ˣ��L��t�d��^��s�2$�4���J���a�R2unR~Ec�D[�Y^kX�l�'&y�̿o���P��b���ʖi64Iz��^��0�#�	r,{�� ��&�Wѳ�9���yy��6a��(x����`s�;{�Zz�.�5x3���V�ĝ�Y*�-�������~i����[��� 'u�2W�S*��ٌ�F��/T�UI�a�Kgb�-����;V���Ж`�?�'��}zڒx ��������qU!��8��^���Os��瘮fB��P���x�rIg��᥶�a�%9s���!z����DjN ����쵍��Q��	��t�+qZ����us��e�u��b[�Hc� E���ys��u!�lxn��t�M��������.�zs���&��̴���uie-�~��0*�'O�Y .�ou����0IRt�hybef�W��p�����VT��Grꬢ[ ��w3\8�Y7a�o�-���(��Kt��r�d�|�v�B&'���+�ô��L'���#J��J�ĸ�u�qq/�m��N�����^#sh�����O�� �!Y�?f�9�5��0��%�b�!�%!�F�x����4(�)�a˓<L�(R��*q��.8��'xX�\�x��w��
� ϒ����#�\�1�(�e��;�eV%��;r�����:ȝ�*^��R�.���=�thxhM;�rwG��v�Y8����_���8���(��5h�J�����ᔻ݋|�p�n|}������MfE�2�ɩ�=nvk��HI-_#8����Lwz{��y q/���nk0 �8�`Ku�0å�Ss:H�l�b�0%�D�z���B)�B����\���r�=i��ib��bA�J�G�]X�ģ�a���b8e���|��-���a#)���VR��]ڌ+��I���_��� ؙW�@5�dU�q�	�
�[���*�e.x	��"g��6��Oў*Ę����$����n�W��{����?go���C_��~�_"�F��NryѮ�,��u��-����f)cM�<�U��A��H��@�~�Wǎ�#(��[j.-~}�:t.g�c�)[1f��@�¸�����tPy�>y/D8�``BG ����Q@�ɍU��H�7��ߜˌ�L�2�*݃�@\Kk���-�Px·܎��ƙ5���bUCrR��E����Z��1�u�]�ުc��0�"+3��D���QNu�L)�A��Rw�d�.���t���C�k���-L������(xHx�Ey�q�Rg	:^��URm��]+���Ü���<7������Pc}� ݉2�n;��^��`D[��{�
�ݥp9J�POw��4�$s/�|��y�`.�6������JL�fF�l����$?@����ī�ۥ���V_�#-�w1���
�w�&�ܦ�LS��Ƶ�f�֤��TF�4��*�Jv]z6m_�h^�v�.{C�]��VH�*}[��j�C�w7Q���;A �8s��;�S�W�0���ؔ�rB���}�eu��K1�}�Zl씳��v��e�]{dM.�)�[���Z�Z�ڒ'Ĝ�F��Q�M0I�SX��f�H��i2��E��eG(,��	��<yC��Lڜ��=c*I�≭����� 
Y������%�p�ۮ��Ad_R��3!�զ"c1lM{#�ju�T��\��2��Ƚ�4�水���K�H�����"=���J�Wgq��j#`'x+bX�Mǈ�_��v:���U��'��2�b�|2��I 5H����9|�{R��3g�2�^�aE�
g�>�(������U�4����ĺ��Q]���MGk��Ds7y���I�Ph��>ȸ�Sm��	j?��6���*% ��[� ���X5	^�d|E�.��sm�������!tl�6��J��t=;mQp�h.��I�-�|��t��x9�M3�X)(�?n9���Z/H�V/��h\k�M��Qd4>����C�e�r���#�I��1�}�%���H�&b�t�g��W�(I�ُJ�.�3N�;�Ӈ�J��93bx_�a�u����%'�>fz;����������|c�D�XB�q#6L�������i�h%bH	��}���w��~8m�m*W�3�?��ܑ!g�xV9�T*��jQ���ڴ2ke�?�Bz����5����)���%o���0鉘	��87��
j�T��q�o����������N�^�o�32$J�H�m�J2�25`���V�g�V��v$��oi' d[�<[l�(j�!�<sm7?��E�l!��n`J?X�{��D�.���d{2T��"�N,���;}�Y�o��p���XlR>��a@�?s��	���HVsji� �(,6�w����|.,�Չ�pA��B��vL��i�����7G;}' >|4�$z:{!@��֞B�PJyk{G�^l.�(]v�<�G}�����0y�U24#������b4%�ӧ$4w`՚DYG ;P�ގ}0�������Ñ�=Z�^!_�Tl��3��ܳ���8�d�,?�PU��
�������=��.�˗�!�����X���M�G� j*x6���|���l�Q�h�2ts�И����:߲��z��Jͪ ��Ȩ�l��v����"��G�Mݸ����r<�l@�5�飻a|����a�a�UAq;�eehl���KP5X|�$����T�{h�ѡ����{Z'�?"��(F�!V��VB|���
����m�QW��lX��$b�����G�?|Z��#�+a�V�p�Q\+?���os;J�K�Y'�������ܮ��r�f��L��\�(|o5Z@����Z]�Ƅ�%���Rr���vj�1�.��"T�yR�r�1)_�HeU���AC��߉z�:����cW�d`�nG��C�I����-�!:M��}tb����v�Ϯt�y�8y�:[�@+
��:Xa�6�]�U	B1��qLUt�ʯH���)N0�:�F��~H���ܜ6 V��R!`V�֢�����I�gNۮ�\T�S��W4ϥ1u!��w��j�z�~���:�n_Qg�5h���)?���Q��*ٞuK�6ǁ]jJԕ�J�j�s��/���5�f��`k6;��-����Ǿ�I�B����z�Z+��֐K��z��]�ړ��ɽ}��[�MFIg�
݌\�/AƷ�׋�&h�+
@��Ɩ1����M���	�����LKK�S�.�v-�S��9���HS,H���d+���