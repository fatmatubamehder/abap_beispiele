*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_42
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFT_UBUNG_42.


PARAMETERS: p_scarr RADIOBUTTON GROUP abc,
            p_spfli RADIOBUTTON GROUP abc,
            p_sflgt RADIOBUTTON GROUP abc.

*data: gt_name TYPE tabname.
DATA: gt_scarr TYPE TABLE OF scarr.
DATA: gt_spfli TYPE TABLE OF spfli.
DATA: gt_sflight TYPE TABLE OF sflight.
DATA: gv_number TYPE i VALUE 1.

DATA: go_obj TYPE REF TO zft_fsm_01.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE,
               <fs_str>   TYPE any,
               <fs_field> TYPE any.

START-OF-SELECTION.

  CREATE OBJECT go_obj.

  IF p_scarr = abap_true.

    ASSIGN gt_scarr TO <fs_table>.

  ELSEIF p_spfli = abap_true.

    ASSIGN gt_spfli TO <fs_table>.

  ELSEIF p_sflgt = abap_true.

    ASSIGN gt_sflight TO <fs_table>.

  ENDIF.

  go_obj->get_data(
    EXPORTING
      iv_scarr   =  p_scarr
      iv_spfli   =  p_spfli
      iv_sflight =  p_sflgt
    IMPORTING
      et_data    = <fs_table> ).


  LOOP AT <fs_table> ASSIGNING <fs_str>.

    DO.

      ASSIGN COMPONENT gv_number OF STRUCTURE <fs_str> TO <fs_field>.

     IF <fs_field> is ASSIGNED.

       write: <fs_field>.
        UNASSIGN <fs_field>.
     else.
       exit.

     ENDIF.

     add 1 to gv_number.

    ENDDO.

    gv_number = 1.

    skip.

  ENDLOOP.
