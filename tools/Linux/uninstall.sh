#!/bin/bash
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
]   �������� �BF=�j�g�z�ᑃ�s(��Z����9un�T	S�29�M~1����v�Dd�+����j�X�H"Yu
��!5���D�rɝ^��<ի�G
�c&j���p;�><8ݶc�qԊՐinc�eQ�7 �/�-]��J�pTz0�S�?���>bKYc��I�'u��y��\�!1���ٝ@��-ĥ����L����OR��G�D�-I��D��:1�������9BU=/�C�0ͭ/��vA����D��2�W�b� 	���~S?���*NpDz���d�t<q'�],��z"�~�z�g�����<*��y[�k�B�,�d���V��[�?��P�	~3��,8�������xJ�
��P3�b2l�ٚ�_+�Y�>�$I�=hc��7	�lm�9%EA+�nKDDY��퇒x Es�B�W����U��P��~��y��_8�X��p �}	��2%�V%�2-I�������;�wJb̹�"~����XFT��T�]5z���5���������IM9	Eh��r���םw;2@����MW���V�_���RV�X2U���.��Wm5��͠]N���U(����w���(b��ܥ)�RJ�1j"|}�g3���G�r�d�Vñ0Ng<c����a7��T/�˵����_8b�H���Cb���4��~�z�PJ\+�U;�ϝ�������Ć�/�]�+�(�"�ixNK۞��?O8k���Q/�Y�!��SP�Z$��5����&�l��_�����giI(��M�K��n��C�X==�`(k
�.��{�}���p�����է��r���E&���=5N��{�XT��[��g�G��G1��ܧӮX/�f
�
�!����v1cD,�5W��J�n��{F.w� �PM��ң�W3DaUXg�T��TrEE�Qé�L4j!�Q���s]нe��f[�E�[�R<Gć�NE�,��sR!�����p|V�;�ñ�M�ۛz�µCoRv�z�$5t�fQw N2V���c����cY���)Ԗ**�5 �a\���N3s���Yᘴ��p���K���]2 ђ�\������rz6|N'�89ށB&x�����Rl���e�%$���1P��q�H$6$ѵWgd�f���yÛeM�NO���5���U�E{b���� Ao�Ây����@�[F*=��uc�΄�-T���	 ��R��PZfi��C��y�δ�*Za"+�Fg�LP�ڠ�زe��{T� �f���CcW��<e��� a�}�aX(37��ޅ��e�K�z@���2��.Z��if�)��zR^@��6���K;���6�X����Z��ѕj��C:t'��d�ys�mT$�G?�*L���G(1!�pZìeޑgX���Nx��n�6���jC��d���W�w�Ag,���mL��-'c&��?�|�h��ߗ�Χ|_�o���&�CG����4���o?�m2��&:��:y���&�������~t�H����a�[pb'9*��t �ꐞw�Y�Ѻ����X�	���w>H��M͜	��M-��D�N�d5
��i��X[M)�^��ـ*��9ˬo�7�u(��5�Or
=�s<��Att%sZ{L�*:���:a��bM�?� �-�=�,$:�_f��s�uB�N�3�h9���k&8�f�ۛ$�*20� d�P���p]��:9�(� ��@9��ܺ�������aп<Rδ]0�Ԑ+�����@,��J�;i�,	,�Ǵ*ׅ,�f*�{��(w4��:E���9u]	�>�+ub�&ch�>��u��-�Z�Bi�z�Gsv|�+��r!���6:�kXe�}� �ƴ�F͚�
�m2�XW�=G�b]ύ&Q�'<�*����U���5*	]�~��\�	%�c�>����y�VJ$�c�<
�dl�r���=A�i��1��=�WUi���:�[?�$�g�;��У Q���*�,�*�y��D8@��ћ6��{?��f����@0qv
\T���A�)=���yl�?&�|av.������-�������5n�a���A��q�
Y�՘6,�;�����J�6��+Fn�i���j6�\�2SM4�H�H�>%>���71
3��S̢�T7wl*K���̙l