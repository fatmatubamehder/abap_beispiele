*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_41
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_41.


* Yeni bir rapor oluşturun ve SFLIGHT tablosunun bütün satırlarını okuyup internal tablo
*içine kaydedin. TYPE ANY TABLE komutu yardımıyla yeni bir field sembol oluşturun ve field sembolü
*kullanarak loop edin. İstediğiniz herhangi 3 kolonu ekrana yazdırın.

DATA: gt_sflight TYPE TABLE OF sflight.
DATA: gs_sflight TYPE sflight.
DATA: gv_number TYPE i VALUE 1.

FIELD-SYMBOLS: <fs_table_sflight> TYPE ANY TABLE,
               <fs_str_sflight>   TYPE any,
               <fs_field>         TYPE any.

START-OF-SELECTION.

  SELECT * FROM sflight
    INTO TABLE gt_sflight.

  ASSIGN gt_sflight TO <fs_table_sflight>.
*  ASSIGN gs_sflight TO <fs_str_sflight>.

  LOOP AT <fs_table_sflight> ASSIGNING <fs_str_sflight>.


      ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_str_sflight> TO <fs_field>.
      IF <fs_field> IS ASSIGNED.
        WRITE: <fs_field>.
      ENDIF.

      ASSIGN COMPONENT 'CONNID' OF STRUCTURE <fs_str_sflight> TO <fs_field>.
      IF <fs_field> IS ASSIGNED.
        WRITE: <fs_field>.
      ENDIF.

      ASSIGN COMPONENT 'FLDATE' OF STRUCTURE <fs_str_sflight> TO <fs_field>.
      IF <fs_field> IS ASSIGNED.
        WRITE: <fs_field>.
      ENDIF.

      SKIP.


  ENDLOOP.




  BREAK-POINT.
