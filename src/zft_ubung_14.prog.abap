*&---------------------------------------------------------------------*
*& Report ZFT_SAP04_SU_20
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_14.

data: gs_spfli TYPE spfli.
data: gt_spfli TYPE TABLE OF spfli.
data: gt_sflight TYPE TABLE OF sflight.

SELECT-OPTIONS: so_spfli FOR gs_spfli-countryfr.


START-OF-SELECTION.

select * from spfli
  into table gt_spfli
  where countryfr in so_spfli.

select * from sflight
  into table gt_sflight
  FOR ALL ENTRIES IN gt_spfli
  WHERE carrid = gt_spfli-carrid.

  BREAK-POINT. 
