*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_49
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_49.

DATA: gv_index TYPE i VALUE 10.

START-OF-SELECTION.

  SELECT * FROM sflight
    INTO TABLE @DATA(gt_table).

  "Vor 7.40- Read Table mit INDEX

  READ TABLE gt_table INTO DATA(gs_str) INDEX 5.
  IF sy-subrc IS INITIAL.

    "Write.

  ENDIF.

  "Nach 7.40- Read Table mit INDEX

  TRY.
      gs_str = gt_table[ 5 ].

    CATCH cx_sy_itab_line_not_found.

      MESSAGE 'Die gesuchte Zeile konnte nicht gefunden werden' TYPE 'E'.
  ENDTRY.


  DATA(gv_pagenumber) = lines( gt_table ).

  IF gv_index <= gv_pagenumber.

    gs_str = gt_table[ gv_index ].

  ENDIF.

  "Vor 7.40- Read Table mit WITH KEY

  READ TABLE gt_table INTO gs_str WITH KEY carrid = 'AZ' connid = '0555' fldate = '20170522'.

  IF sy-subrc IS INITIAL.

    "Write.

  ENDIF.

  "Nach 7.40- Read Table mit WITH KEY

  TRY.

      gs_str = gt_table[ carrid = 'AZ' connid = '0555' fldate = '20170521' ].

    CATCH cx_sy_itab_line_not_found.

      MESSAGE 'Die gesuchte Zeile konnte nicht gefunden werden' TYPE 'E'.

  ENDTRY.


  BREAK-POINT.
