*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_50
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_50.


TYPES: BEGIN OF gty_str,
         id      TYPE n LENGTH 6,
         name    TYPE c LENGTH 20,
         nname   TYPE c LENGTH 20,
         adresse TYPE c LENGTH 60,
       END OF gty_str.

DATA: gt_table TYPE TABLE OF gty_str,
      gs_str   TYPE gty_str,
      gs_str_2 TYPE gty_str.

TYPES: gtt_table TYPE TABLE OF gty_str WITH NON-UNIQUE KEY id.

START-OF-SELECTION.

  "Vor 7.40 mit Structure

  gs_str-id             = 123456.
  gs_str-name           = 'Fatma'.
  gs_str-nname          = 'Mehder'.
  gs_str-adresse        = 'Schillerstraße 14'.


  "Nach 7.40 mit Structure

  gs_str_2 = VALUE #( id             = 123456
                      name           = 'Fatma'
                      nname          = 'Mehder'
                      adresse        = 'Schillerstraße 14').




  "Nach 7.40 mit Tabelle

  gt_table = VALUE #( ( id = 123456 name = 'Fatma' nname = 'Mehder' adresse = 'Schillerstraße 14')
                      ( id = 123457 name = 'Alex' nname = 'Schmidt' adresse = 'Bäckerstraße 24')
                      ( id = 123458 name = 'Karl' nname = 'Hoffmann' adresse = 'Mutstraße 4') ).



  " Strukture mit inline Decleration

  DATA(gs_str_3) = VALUE gty_str( id = 123456 name = 'Fatma' nname = 'Mehder' adresse = 'Schillerstraße 14').


  " Tabelle mit inline Decleration

  DATA(gt_table_1) = VALUE gtt_table( ( id = 123456 name = 'Fatma' nname = 'Mehder' adresse = 'Schillerstraße 14')
                        ( id = 123457 name = 'Alex' nname = 'Schmidt' adresse = 'Bäckerstraße 24')
                        ( id = 123458 name = 'Karl' nname = 'Hoffmann' adresse = 'Mutstraße 4') ).



  BREAK-POINT.
