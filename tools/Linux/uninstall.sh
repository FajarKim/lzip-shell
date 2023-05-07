#!/bin/bash
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
skip=79
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
]   �������� �BF=�j�g�z�ᑪ�c���Y"�p���Je�C��Ų�� BNZ�)���)�#|s������d%�Ѳ����Y �_�5aK�1W`Dki�b�o��O/[�@8�1�3B�9&�GF̪�7C�c�T�"�{ 1D^����k�1ӹ�s8cg����C�Ӝ��"�3��N���O�b ��o�<��%�(�0�-:qؔ�̜ᘦH�r���Af5�D�m���dDy���ǯ;��n�]�W{K.��^y�:ś4�1�۩)�;��U��x��쩵�ȯhƁo��+�Ta9����Ɗo�<�˨U7/�52]���"��:��.��n�q{a�L�r(ÿ2�����nO��G�Ӥܮ��_��R�I����͌>�^�V4*���>*�Y���<���r��[Uk��:�f��
�˥��/\�Z�\ج�
W��U�2S7ft��?����]c_}�G�JPǜ�gp������qb���j5��,X-�����U(|����om㚍Ԩ�X�b#� ;�Of��A",�6��#8��	��{3�'�}}S�E��C��$�+LS��=Y�t�V�'�J��N|��	��G���,m�[�������ޠTT��^�MF(�앷�G��rz`]1H�ϥ�f̊��̼��z겐,$���#�(s�/eԒ ��n4B~t�(�ܱ���G{v�Y0�M@G�l��z���\.k�@�� z4���mU���+vS�z{1mj��!��t:�ٿ�D��N�q�:���ʤ4fi�Zf��e�%��h��J�C�<�])�r��gi�A��OH��.��j�W��zHN<��[ *Hp�6�5�h�73��8άIm�]��:�~2�[�2Af��-t���Ak���K���f���{nB8���D�}���`f^��{E T�s�#$r�������j�r�p�jfèĩ�)��g��_$k�e���S ҩĉ-�c�Z%�H�i�@�������Z�9V[A�K�( EA�[V��O����Ч4[���H����%E���׻����Of���=B���!��^p����b{�_�L��6M�x�֥����(�#���Tb��׽�P��L�@�h���>�[8!Gj����v���{��|�����U7�)	�خ���a�d���@����B�m�8�*X����}}�
�{�K�*"[��_���/2]�+�x?���`t��+�
��;�������Sc��oU}��an2�T�����Pfv���H��ƺ��� �O��%"RUzd�?�G�s�B8�&s���TH��!^��/�q_ͤ�h��{�W�pC�D>�t8�p갷��V���Y�̪T���4F�m���E�.pϝ�_ߚ�CA¼1J �l�
�U3��)h ��ȱ�JJ����������M
ȫ!�raI�Hp,�Vɹ���{d������7��Pt��h����E��^ׯQ7PA���!��-���[M.��m\�Jr��;+�ʐ�Ƭ���$O0�yټ+�QBQw^���,-�5cI\�����^W0���]�H����Y�4��JZm�Pu֧��Zu���I�"��kcZ���-B�!�NcoZ:������c�x�Ǒ����\qW���w�z.~6v����9o�[�5PL��w2?������Ƥ�Sxh��9m�*��iϓ ��lG3���X��loM��m�jz����aB�А���[�q�V�`��o��\�>DH��c�kl�7d�)��֥ �@Zަ��]�$K]��r���">话mB�p��5�!n���yR�>S,?*�%Ug*��#dl_WL<NVYċ���������.;���>���Z&-��x�a=��m-(�@����2�����ػz��;��]��B���=%]�)�ȑ�6��wxzI�ރ� ſ�@,G�u��=��0���\I5�l�]B˙�:������ �H��RE�ʔa(�&<�mf	��A�q�.� ��fPX�0R@��F	{��a(w�M���H��p�&�-7�[#"a2�68�������dc�#��@�����	��rll���9�tD��m[���.������W��s.6��`�V`d��[\�HFZ�j�<#s+��`ίi-����<�������s3å{�V�e�ֽ����=���ec�B�/xH<]✴o�/�ԱE$�DC8Sq���"��z@�q=\R���:��������k�ǅuq���Р�p,r���>K\K����#�*