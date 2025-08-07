*&---------------------------------------------------------------------*
*& Report ZFT_CREATE_STRUKTUR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_create_struktur.

*Erstellen Sie ein neues Programm. Definieren Sie im Programm 10 Parameter, die jeweils einem Feld der in Übung 1
*erstellten Struktur entsprechen. Speichern Sie die von den Parametern kommenden Werte in den entsprechenden Feldern
*der Struktur ab. Erstellen Sie eine interne Tabelle mit der gleichen Zeilenstruktur wie die Struktur. Füllen Sie die
*interne Tabelle mit 10 Zeilen, wobei der vom Benutzer eingegebene Preis bei jeder Zeile um 50 EUR erhöht wird. Außerdem
*soll die Telefonfarbe bei jeder Zeile unterschiedlich sein (verwenden Sie Case-Endcase mit sy-index). Anschließend durchlaufen
*Sie die interne Tabelle mit einer Schleife und geben nur die ungeraden Zeilen aus.



PARAMETERS: p_brand  TYPE zft_de_pbrand,
            p_model  TYPE zft_de_pmodel,
            p_color  TYPE zft_de_pcolor,
            p_opsys  TYPE zft_de_opr_sys,
            p_memory TYPE zft_de_memory,
            p_screen TYPE zft_de_screen,
            p_price  TYPE zft_de_price,
            p_curr   TYPE zft_de_curr,
            p_dbsim  TYPE zft_de_dbl_sim,
            p_weight TYPE zft_de_weight.


DATA: gs_str   TYPE zft_str_001,
      gt_table TYPE TABLE OF zft_str_001.


START-OF-SELECTION.

  DO 10 TIMES.

    CASE sy-index.
      WHEN 1.
        gs_str-phone_color = p_color.
      WHEN 2.
        gs_str-phone_color = 'Mavi'.
      WHEN 3.
        gs_str-phone_color = 'Sari'.
      WHEN 4.
        gs_str-phone_color = 'Beyaz'.
      WHEN 5.
        gs_str-phone_color = 'Kirmizi'.
      WHEN 6.
        gs_str-phone_color = 'Yesil'.
      WHEN 7.
        gs_str-phone_color = 'Mor'.
      WHEN 8.
        gs_str-phone_color = 'Pembe'.
      WHEN 9.
        gs_str-phone_color = 'Turuncu'.
      WHEN 10.
        gs_str-phone_color = 'Gri'.
    ENDCASE.

    gs_str-phone_brand             = p_brand.
    gs_str-phone_model             = p_model.
    gs_str-phone_opr_system        = p_opsys.
    gs_str-phone_memory            = p_memory.
    gs_str-phone_screen            = p_screen.
    gs_str-phone_price             = p_price.
    gs_str-phone_curr              = p_curr.
    gs_str-phone_double_sim        = p_dbsim.
    gs_str-phone_weight            = p_weight.

    APPEND gs_str TO gt_table.
    CLEAR: gs_str.

    ADD 500 TO p_price.

  ENDDO.

  LOOP AT gt_table INTO gs_str.

    IF sy-tabix MOD 2 = 1.

      WRITE: sy-tabix,
             gs_str-phone_brand,
             gs_str-phone_model,
             gs_str-phone_color,
             gs_str-phone_opr_system,
             gs_str-phone_memory,
             gs_str-phone_screen,
             gs_str-phone_price,
             gs_str-phone_curr,
             gs_str-phone_double_sim,
             gs_str-phone_weight.

      SKIP.
      ULINE.

    ENDIF.

  ENDLOOP.

*BREAK-POINT. 
