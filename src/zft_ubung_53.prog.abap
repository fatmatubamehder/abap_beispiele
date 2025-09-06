*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_53
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFT_UBUNG_53.

types: BEGIN OF gty_str,
       carrid TYPE s_carr_id,
       seatsocc TYPE S_SEATSOCC,
       fldate type S_DATE,
       jahr     TYPE n LENGTH 4,
  END OF gty_str.

  data: gt_table TYPE TABLE OF gty_str,
        gs_strr TYPE gty_str.

"Wie viele 'AZ' gibt es in der TAbelle sflight?

data: gv_number TYPE i.

START-OF-SELECTION.

select * from sflight
  into table @data(gt_sflight).


 " Vor 7.40


LOOP AT gt_sflight into data(gs_str) where carrid = 'AZ'.

  add 1 to gv_number.

ENDLOOP.


"nach 7.40

data(gv_number_1) = REDUCE i( INIT x = 0 FOR gs_str_1 in gt_sflight WHERE ( carrid = 'AZ' ) NEXT x = x + 1 ).



"Wie hoch ist die Summe der SeatsOcc-Werte der Flüge aus dem Jahr 2018 in der Tabelle SFLIGHT, deren Carrier-ID ‚AZ‘ ist?


select * from sflight
  into CORRESPONDING FIELDS OF table gt_table
  where carrid = 'AZ'.

LOOP AT gt_table into gs_strr.

  gs_strr-jahr = gs_strr-fldate+0(4).

  modify gt_table from gs_strr TRANSPORTING jahr.

ENDLOOP.


data(gv_sum) = REDUCE i( INIT x = 0 FOR gs_str_2 IN gt_table WHERE ( carrid = 'AZ' and jahr = '2018' ) NEXT x = x + gs_str_2-seatsocc ).



BREAK-POINT.
