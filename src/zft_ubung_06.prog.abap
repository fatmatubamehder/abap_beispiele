*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_06.

*Erstellen Sie einen neuen Bericht und nehmen Sie drei Parameter vom Benutzer entgegen (alle in Form von Radiobuttons).
*
*Die Radiobuttons sollen wie folgt benannt sein: „SCARR“, „SPFLI“ und „SFLIGHT“.
*
*Je nachdem, welchen Radiobutton der Benutzer auswählt, sollen die entsprechenden Tabellendatensätze gelesen und auf dem Bildschirm ausgegeben werden.
*
*Die Verarbeitung der jeweiligen Tabellen soll in getrennten Form-Routinen erfolgen.



PARAMETERS: p_scarr RADIOBUTTON GROUP abc,
            p_spfli RADIOBUTTON GROUP abc,
            p_sflg  RADIOBUTTON GROUP abc.


DATA: gs_scarr   TYPE scarr,
      gt_scarr   TYPE TABLE OF scarr,
      gs_spfli   TYPE spfli,
      gt_spfli   TYPE TABLE OF spfli,
      gs_sflight TYPE sflight,
      gt_sflight TYPE TABLE OF sflight.

START-OF-SELECTION.

  IF p_scarr = abap_true.

    PERFORM scarr.

  ELSEIF p_spfli = abap_true.

    PERFORM spfli.

  ELSE.

    PERFORM sflight.

  ENDIF.

FORM scarr.

  SELECT * FROM scarr
    INTO TABLE gt_scarr.

  LOOP AT gt_scarr INTO gs_scarr.

    WRITE: gs_scarr-carrid,
           gs_scarr-carrname,
           gs_scarr-currcode,
           gs_scarr-url.

    ULINE.
    SKIP.

  ENDLOOP.


ENDFORM.


FORM spfli.

  SELECT * FROM spfli
    INTO TABLE gt_spfli.

  LOOP AT gt_spfli INTO gs_spfli.

    WRITE: gs_spfli-carrid,
           gs_spfli-connid,
           gs_spfli-countryfr,
           gs_spfli-cityfrom,
           gs_spfli-airpfrom,
           gs_spfli-countryto,
           gs_spfli-cityto,
           gs_spfli-airpto,
           gs_spfli-fltime,
           gs_spfli-deptime,
           gs_spfli-arrtime,
           gs_spfli-distance,
           gs_spfli-distid,
           gs_spfli-fltype,
           gs_spfli-period.

    ULINE.
    SKIP.

  ENDLOOP.

ENDFORM.


FORM sflight.

  SELECT * FROM sflight
    INTO TABLE gt_sflight.

  LOOP AT gt_sflight INTO gs_sflight.

    WRITE: gs_sflight-carrid,
           gs_sflight-connid,
           gs_sflight-fldate,
           gs_sflight-price,
           gs_sflight-currency,
           gs_sflight-planetype,
           gs_sflight-seatsmax,
           gs_sflight-seatsocc,
           gs_sflight-paymentsum,
           gs_sflight-seatsmax_b,
           gs_sflight-seatsocc_b,
           gs_sflight-seatsmax_f,
           gs_sflight-seatsocc_f.

    ULINE.
    SKIP.
  ENDLOOP.

ENDFORM.
