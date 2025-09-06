*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_54
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_54.


PARAMETERS: p_scarr RADIOBUTTON GROUP abc,
            p_spfli RADIOBUTTON GROUP abc,
            p_sflgt RADIOBUTTON GROUP abc.


DATA: gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight,
      go_obj     TYPE REF TO zmc_select_in_runtime_2.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE.


START-OF-SELECTION.

CREATE OBJECT go_obj.

  IF p_scarr = abap_true.

    ASSIGN gt_scarr TO <fs_table>.

  ELSEIF p_spfli = abap_true.

    ASSIGN gt_spfli TO <fs_table>.

  ELSEIF p_sflgt = abap_true.

    ASSIGN gt_sflight TO <fs_table>.

  ENDIF.

  go_obj->get_table(
    EXPORTING
      iv_tabname = cond #( when p_scarr = abap_true then 'SCARR'
                           when p_spfli = abap_true then 'SPFLI'
                           when p_sflgt = abap_true then 'SFLIGHT' )
    IMPORTING
      et_data    = <fs_table> ).


  BREAK-POINT.
