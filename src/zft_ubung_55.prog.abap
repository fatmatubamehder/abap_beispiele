*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_55
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_55.

DATA: gt_table   TYPE zft_tt_sap04,
      gt_table_2 TYPE zft_tt_sap04,
      gt_table_3 TYPE zft_tt_sap04,
      gs_str     TYPE zft_s_sap04.

START-OF-SELECTION.

  SELECT * FROM zft_stravelag
    INTO TABLE @DATA(gt_stravelag).


  "vor 7.40

  LOOP AT gt_stravelag INTO DATA(gs_stravelag).

    MOVE-CORRESPONDING gs_stravelag TO gs_str.

    APPEND gs_str TO gt_table.
    CLEAR: gs_str.

  ENDLOOP.

  " nach 7.40


  LOOP AT gt_stravelag INTO gs_stravelag.

    gs_str = CORRESPONDING #( gs_stravelag ).

    APPEND gs_str TO gt_table.
    CLEAR: gs_str.

  ENDLOOP.


  " für Tabelle


  "vor 7.40

MOVE-CORRESPONDING gt_stravelag to gt_table_2.


  "nach 7.40

gt_table_2 = CORRESPONDING #( gt_stravelag ).


"Wenn die Daten in der Tabelle nicht gelöscht, sondern durch neue ergänzt werden sollen.

"vor 7.40


MOVE-CORRESPONDING gt_stravelag to gt_table_3 KEEPING TARGET LINES.

"nach 7.40

gt_table_3 = CORRESPONDING #( BASE ( gt_table_3 ) gt_stravelag ).


  BREAK-POINT.
