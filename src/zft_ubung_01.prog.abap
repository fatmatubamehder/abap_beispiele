*&---------------------------------------------------------------------*
*& Report ZFT_ABAP_010
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*
*Erstellen Sie einen neuen Report. Definieren Sie im Report einen Parameter.
*Der Benutzer soll die Fluggesellschaft (carrid) eingeben.Basierend auf dieser
*Eingabe sollen alle Datensätze aus der Tabelle SFLIGHT gelesen werden,
*bei denen die Fluggesellschaft mit der Benutzereingabe übereinstimmt.Berechnen Sie
*die Summe der maximalen Sitzplätze (Seatsmax) und der verkauften Sitzplätze (Seatsocc)
*aller gelesenen Datensätze.Geben Sie dem Benutzer eine Informationsmeldung mit diesen Werten aus.


REPORT zft_ubung_01.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

PARAMETERS: p_carrid TYPE s_carr_id.

SELECTION-SCREEN END OF BLOCK a1.

DATA: gs_sflight TYPE sflight,
      gt_sflight TYPE TABLE OF sflight,
      g_seatmax  TYPE n LENGTH 10,
      g_seatsocc TYPE n LENGTH 10,
      gv_msg     TYPE string.


START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_sflight.


  LOOP AT gt_sflight INTO gs_sflight WHERE carrid = p_carrid.

    ADD gs_sflight-seatsmax TO g_seatmax.
    ADD gs_sflight-seatsocc TO g_seatsocc.

  ENDLOOP.

  SHIFT g_seatmax LEFT DELETING LEADING '0'.
  SHIFT g_seatsocc LEFT DELETING LEADING '0'.

  CONCATENATE 'Gesamtanzahl der Sitzplätze : ' g_seatmax 'Anzahl der verkauften Sitzplätze : ' g_seatsocc INTO gv_msg SEPARATED BY space.

  MESSAGE gv_msg TYPE 'I'.

  LOOP AT gt_sflight INTO gs_sflight WHERE carrid = p_carrid.

    WRITE: sy-tabix,
           gs_sflight-seatsmax,
           gs_sflight-seatsocc.

    SKIP.
    ULINE.
  ENDLOOP.
