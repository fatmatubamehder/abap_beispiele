*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_56
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFT_UBUNG_56.

data: gv_text TYPE string.

START-OF-SELECTION.

"vor 7.40

CONCATENATE 'TEXT_1' 'TEXT_2' into gv_text SEPARATED BY space.


"Nach 7.40

data(gv_text_2) = |TEXT_1| & | | & |TEXT_2|.


data(gv_1) = 'Fatma'.
data(gv_2) = 'Mehder'.

data(gv_text_3) = |{ gv_1 }| & | | & |{ gv_2 }|.

BREAK-POINT.
