*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_22
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_22.

DATA: gv_1 TYPE c LENGTH 3 VALUE '100',
      gv_2 TYPE c LENGTH 3 VALUE '10A',
      gv_3 TYPE c LENGTH 3 VALUE '200',
      gv_4 TYPE c LENGTH 3 VALUE '/$&',
      gv_5 TYPE string VALUE 'Tükenmez Kalem',
      gv_6 TYPE string VALUE 'Dolma Kalem',
      gv_7 TYPE string VALUE 'abap Programlama Dili Ögreniyorum.',
      gv_8 TYPE string VALUE 'wro',
      gv_9 TYPE string VALUE 'www.google.com'.



IF gv_1 CO '0123456789'.
  WRITE: 'Mathematische Operation ist möglich.'.
ELSE.
  WRITE: 'Mathematische Operation ist nicht möglich.'.
ENDIF.

IF gv_2 CO '0123456789'.
  WRITE: 'Mathematische Operation ist möglich.'.
ELSE.
  WRITE: 'Mathematische Operation ist nicht möglich..'.
ENDIF.

IF gv_3 CN '0123456789'.
  WRITE: / 'Mathematische Operation ist nicht möglich..'.
ELSE.
  WRITE: / 'Mathematische Operation ist möglich.'.
ENDIF.

IF gv_4 CN '0123456789'.
  WRITE: / 'Mathematische Operation ist nicht möglich.'.
ELSE.
  WRITE: / 'Mathematische Operation ist möglich.'.
ENDIF.

IF gv_5 CA 'üÜöÖğĞşŞıİçÇ'.
  WRITE: / 'Der Text enthält türkische Buchstaben.'.
ELSE.
  WRITE: / 'Der Text enthält keine türkische Buchstaben.'.
ENDIF.

IF gv_6 NA 'üÜöÖğĞşŞıİçÇ'.
  WRITE: / 'Der Text enthält keine nicht-englischen Buchstaben.'.
ELSE.
  WRITE: / 'Der Text enthält Englische Buchstaben.'.
ENDIF.

IF gv_7 CS gv_8.
  WRITE: / 'Der rechte Text ist im linken Text enthalten.'.
ELSE.
  WRITE: / 'Der rechte Text ist nicht im linken Text enthalten.'.
ENDIF.

IF gv_7 NS gv_8.
  WRITE: / 'Der rechte Text ist nicht im linken Text enthalten.'.
ELSE.
  WRITE: / 'Der rechte Text ist im linken Text enthalten.'.
ENDIF.

IF gv_9 CP '*.com'.
  WRITE: / 'Es endet mit .com.'.
ELSE.
  WRITE: / 'Es endet nicht mit .com.'.
ENDIF.

IF gv_9 CP 'www*'.
  WRITE: / 'Es beginnt mit www.'.
ELSE.
  WRITE: / 'Es beginnt nicht mit www.'.
ENDIF.

IF gv_9 NP '*.com'.
  WRITE: / 'Es endet nicht mit .com..'.
ELSE.
  WRITE: / 'Es endet mit .com.'.
ENDIF.

IF gv_9 NP 'www*'.
  WRITE: / 'Es beginnt nicht mit www.'.
ELSE.
  WRITE: / 'Es beginnt mit www.'.
ENDIF.


BREAK-POINT.
