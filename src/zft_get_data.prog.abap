*&---------------------------------------------------------------------*
*& Report ZFT_GET_DATA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_get_data.


*Erstellen Sie einen neuen Report. Definieren Sie im Report einen Parameter.
*Bitten Sie den Benutzer, eine Fluggesellschaft (carrid) einzugeben. Basierend auf
*dieser Eingabe sollen im Report aus den Datenbanktabellen SCARR, SPFLI und SFLIGHT
*alle Datensätze mit der gleichen Fluggesellschaft angezeigt werden.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

PARAMETERS: p_carrid TYPE s_carr_id.

SELECTION-SCREEN END OF BLOCK a1.


DATA: gs_scarr   TYPE scarr,
      gt_scarr   TYPE TABLE OF scarr,
      gs_spfli   TYPE spfli,
      gt_spfli   TYPE TABLE OF spfli,
      gs_sflight TYPE sflight,
      gt_sflight TYPE TABLE OF sflight.


START-OF-SELECTION.

  "Scarr table

  SELECT * FROM scarr INTO TABLE gt_scarr WHERE carrid = p_carrid.



  READ TABLE gt_scarr INTO gs_scarr INDEX 1.

  IF sy-subrc IS INITIAL.

    WRITE: ' Von der Tabelle Scarr'.

    SKIP.
    ULINE.


    WRITE: / sy-tabix,
           gs_scarr-carrid,
           gs_scarr-carrname,
           gs_scarr-currcode,
           gs_scarr-url.
    SKIP.
    ULINE.

  ENDIF.

  " spfli table

  SELECT * FROM spfli INTO TABLE gt_spfli WHERE carrid = p_carrid.

  IF sy-subrc IS INITIAL.

    WRITE: ' Von der Tabelle Spfli'.

    ULINE.
    SKIP.

    LOOP AT gt_spfli INTO gs_spfli.

      WRITE: / sy-tabix,
             gs_spfli-carrid,
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

  ENDIF.




  " Sflight table


  SELECT * FROM sflight INTO TABLE gt_sflight WHERE carrid = p_carrid.

  IF sy-subrc IS INITIAL.

    WRITE: ' Von der Tabelle Sflight'.

    ULINE.
    SKIP.

    LOOP AT gt_sflight INTO gs_sflight.

      WRITE: sy-tabix,
             gs_sflight-carrid,
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
