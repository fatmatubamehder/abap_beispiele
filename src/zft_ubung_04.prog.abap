*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_04.

*Definieren Sie den gleichen Parameter wie in der vorherigen Übung erneut und verwenden Sie den eingegebenen Wert, um die Tabelle SCARR zu lesen.
*
*Lesen Sie anschließend mithilfe des Befehls FOR ALL ENTRIES aus der Tabelle SPFLI alle Zeilen, deren CARRID mit einem der in SCARR gelesenen CARRID-Werte übereinstimmt.
*
*Danach lesen Sie – wieder mit FOR ALL ENTRIES – aus der Tabelle SFLIGHT alle Zeilen, deren CONNID mit einem der in SPFLI gelesenen CONNID-Werte übereinstimmt.
*
*Geben Sie die Ergebnisse auf dem Bildschirm aus.



PARAMETERS: p_carrnm TYPE zft_de_sh_1.

DATA: gt_scarr   TYPE TABLE OF scarr,
*      gs_scarr   TYPE scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gs_spfli   TYPE spfli,
      gt_sflight TYPE TABLE OF sflight,
      gs_sflight TYPE sflight.

START-OF-SELECTION.

  SELECT * FROM scarr
    INTO TABLE gt_scarr
    WHERE carrname = p_carrnm.

  IF gt_scarr IS NOT INITIAL.

    SELECT * FROM spfli
      INTO TABLE gt_spfli
      FOR ALL ENTRIES IN gt_scarr
      WHERE carrid = gt_scarr-carrid.

  ELSE.

    MESSAGE 'Die eingegebene Daten wurde nicht gefunden.' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.

  IF gt_spfli IS NOT INITIAL.

    WRITE: 'Von der Tabelle Spfli'.
    ULINE.

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

  ELSE.

    MESSAGE: 'Die eingegebene Carrid wurde nicht in der Tabelle Spfli gefunden.' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.


  IF gt_spfli IS NOT INITIAL.

    SELECT * FROM sflight
      INTO TABLE gt_sflight
      FOR ALL ENTRIES IN gt_spfli
      WHERE connid = gt_spfli-connid.

    IF gt_sflight IS NOT INITIAL.

      WRITE: 'Von der Tabelle Sflight'.
      ULINE.

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

    ENDIF.

  ENDIF.

*  BREAK-POINT.
