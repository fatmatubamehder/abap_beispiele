*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_46
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_46.


PARAMETERS: p_scarr RADIOBUTTON GROUP abc,
            p_spfli RADIOBUTTON GROUP abc,
            p_sflgt RADIOBUTTON GROUP abc,
            p_index TYPE i.


START-OF-SELECTION.

  IF p_scarr = abap_true.

    SELECT * FROM scarr
      INTO TABLE @DATA(gt_scarr).

    READ TABLE gt_scarr INTO DATA(gs_scarr) INDEX p_index.
    IF sy-subrc IS INITIAL.

      WRITE: gs_scarr-carrid.
      WRITE: gs_scarr-carrname.
      WRITE: gs_scarr-currcode.
      WRITE: gs_scarr-url.

    ENDIF.

  ELSEIF p_spfli = abap_true.

    SELECT * FROM spfli
     INTO TABLE @DATA(gt_spfli).

    READ TABLE gt_spfli INTO DATA(gs_spfli) INDEX p_index.

    IF sy-subrc IS INITIAL.

      WRITE: gs_spfli-carrid.
      WRITE: gs_spfli-connid.
      WRITE: gs_spfli-countryfr.
      WRITE: gs_spfli-deptime.

    ENDIF.

  ELSE.

    SELECT * FROM sflight
   INTO TABLE @DATA(gt_sflight).

    READ TABLE gt_sflight INTO DATA(gs_sflight) INDEX p_index.

    IF sy-subrc IS INITIAL.

      WRITE: gs_sflight-carrid.
      WRITE: gs_sflight-connid.
      WRITE: gs_sflight-fldate.
      WRITE: gs_sflight-planetype.

    ENDIF.


  ENDIF.
