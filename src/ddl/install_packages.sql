create or replace package email_pkg as 
  
  procedure new_template(
    p_App_ID    pls_integer, 
    p_Page_ID   pls_integer, 
    p_static_id varchar2
  );
  
  procedure new_template_automation(
    p_tis_id            template_import_status.tis_id%type,
    p_tis_annotation    template_import_status.tis_annotation%type,
    p_per_id            r_person.per_id%type,
    p_per_name          varchar2,
    p_per_email         r_person.per_email%type,
    p_tpl_id            r_templates.tpl_id%type
  );

  procedure corrected_template(
    p_App_ID    pls_integer, 
    p_Page_ID   pls_integer, 
    p_static_id varchar2
  );
  
  procedure corrected_template_automation(
    p_tis_id            template_import_status.tis_id%type,
    p_tis_annotation    template_import_status.tis_annotation%type,
    p_per_id            r_person.per_id%type,
    p_per_name          varchar2,
    p_per_email         r_person.per_email%type,
    p_tpl_id            r_templates.tpl_id%type
  );

  procedure reminder(
    p_App_ID    pls_integer, 
    p_Page_ID   pls_integer, 
    p_static_id varchar2
  );
  
  procedure reminder_automation(
    p_tis_id            template_import_status.tis_id%type,
    p_tis_annotation    template_import_status.tis_annotation%type,
    p_per_id            r_person.per_id%type,
    p_per_name          varchar2,
    p_per_email         r_person.per_email%type,
    p_tpl_id            r_templates.tpl_id%type
  );

end email_pkg;
/

create or replace package excel_gen
as

  gc_headergroup_row constant pls_integer := 4;
  gc_header_row      constant pls_integer := 5;
  gc_data_row        constant pls_integer := 6;

  gc_ids_col1 constant pls_integer := 299;
  gc_ids_col2 constant pls_integer := 300;

  procedure regenerate_invalid_rows (
    pi_tis_id in template_import_status.tis_id%type
  );
 
  procedure generate_single_file (
    pi_tis_id        in template_import_status.tis_id%type
  , pi_tpl_id        in r_templates.tpl_id%type
  , pi_tpl_name      in r_templates.tpl_name%type
  , pi_per_id        in r_person.per_id%type
  , pi_per_firstname in r_person.per_firstname%type
  , pi_per_lastname  in r_person.per_lastname%type
  , pi_invalid       in boolean default false 
  );

  function getExcelColumnName(
    p_column_count pls_integer
  ) return varchar2;

end excel_gen;
/

create or replace package file_import
as

  function remove_empty_spaces(
    pi_string in varchar2
  ) return varchar2
  ;

  procedure upload_file (
    pi_collection_name in  apex_collections.collection_name%type default 'DROPZONE_UPLOAD'
  , pi_tpl_id          in  r_templates.tpl_id%type
  , po_error_occurred  out nocopy number
  );

end file_import;
/

create or replace package master_api as  
  
  function get_faulty_id
    return r_header.hea_id%type deterministic result_cache
  ;

  function get_annotation_id
    return r_header.hea_id%type deterministic result_cache
  ;

  function get_feedback_id
    return r_header.hea_id%type deterministic result_cache
  ;

  function get_validation_id
    return r_header.hea_id%type deterministic result_cache
  ;

end master_api;
/

create or replace package p00025_api as 

  procedure create_new_template(
    pi_collection_name in  apex_collections.collection_name%type default 'CREATE_TEMPLATE'  
  );

  procedure create_preview(
    pi_collection_name in  apex_collections.collection_name%type default 'CREATE_TEMPLATE'  
  );

end p00025_api;
/

create or replace package p00027_api as 

  procedure save_header(
    pi_hea_text         in r_header.hea_text%type
  , pi_hea_xlsx_width   in r_header.hea_xlsx_width%type
  , pi_hea_val_id       in r_header.hea_val_id%type
  , pi_dropdown_values  in varchar2 
  );

end p00027_api;
/

create or replace package p00028_api as 

  procedure save_header_group(
    pi_thg_text                   in template_header_group.thg_text%type
  , pi_thg_xlsx_background_color  in template_header_group.thg_xlsx_background_color%type
  , pi_thg_xlsx_font_color        in template_header_group.thg_xlsx_font_color%type
  );

end p00028_api;
/

create or replace package p00030_api
as

  procedure generate_excel_file ( 
    pi_tpl_id in r_templates.tpl_id%type,
    pi_per_id in r_person.per_id%type    
);

  procedure send_mail(
    pi_choice       in pls_integer,
    pi_app_id       in pls_integer,
    pi_app_page_id  in pls_integer,
    pi_static_id    in varchar2
  ); 

end p00030_api;
/

create or replace package p00031_api
as

  procedure add_person(
    pi_tpl_id in r_templates.tpl_id%type
  , pi_per_id in varchar2
  );

end p00031_api;
/

create or replace package p00032_api
as

  procedure save_automation(
    pi_tpa_tpl_id  in template_automations.tpa_tpl_id%type,
    pi_tpa_enabled in template_automations.tpa_enabled%type,
    pi_tpa_days    in template_automations.tpa_days%type
  );

end p00032_api;
/

create or replace package p00041_api
as

  procedure upload_file (
    pi_collection_name in  apex_collections.collection_name%type default 'DROPZONE_UPLOAD'
  , pi_tpl_id          in  r_templates.tpl_id%type   
  , po_error_occurred  out nocopy number
  );

end p00041_api;
/

create or replace package p00051_api
as

 type t_grid_row is record (
    tid_row_id template_import_data.tid_row_id%type
  , col01      template_import_data.tid_text%type
  , col02      template_import_data.tid_text%type
  , col03      template_import_data.tid_text%type
  , col04      template_import_data.tid_text%type
  , col05      template_import_data.tid_text%type
  , col06      template_import_data.tid_text%type
  , col07      template_import_data.tid_text%type
  , col08      template_import_data.tid_text%type
  , col09      template_import_data.tid_text%type
  , col10      template_import_data.tid_text%type
  , col11      template_import_data.tid_text%type
  , col12      template_import_data.tid_text%type
  , col13      template_import_data.tid_text%type
  , col14      template_import_data.tid_text%type
  , col15      template_import_data.tid_text%type
  , col16      template_import_data.tid_text%type
  , col17      template_import_data.tid_text%type
  , col18      template_import_data.tid_text%type
  , col19      template_import_data.tid_text%type
  , col20      template_import_data.tid_text%type
  , col21      template_import_data.tid_text%type
  , col22      template_import_data.tid_text%type
  , col23      template_import_data.tid_text%type
  , col24      template_import_data.tid_text%type
  , col25      template_import_data.tid_text%type
  , col26      template_import_data.tid_text%type
  , col27      template_import_data.tid_text%type
  , col28      template_import_data.tid_text%type
  , col29      template_import_data.tid_text%type
  , col30      template_import_data.tid_text%type
  , col31      template_import_data.tid_text%type
  , col32      template_import_data.tid_text%type
  , col33      template_import_data.tid_text%type
  , col34      template_import_data.tid_text%type
  , col35      template_import_data.tid_text%type
  , col36      template_import_data.tid_text%type
  , col37      template_import_data.tid_text%type
  , col38      template_import_data.tid_text%type
  , col39      template_import_data.tid_text%type
  , col40      template_import_data.tid_text%type
  , col41      template_import_data.tid_text%type
  , col42      template_import_data.tid_text%type
  , col43      template_import_data.tid_text%type
  , col44      template_import_data.tid_text%type
  , col45      template_import_data.tid_text%type
  , faulty     template_import_data.tid_text%type   
  , annotation template_import_data.tid_text%type
  , validation template_import_data.tid_text%type
  );

  type t_grid_tab is table of t_grid_row;

  type t_tid_text_array is varray(45) of template_import_data.tid_text%type;

  type t_hea_text_array is varray(45) of r_header.hea_text%type;

  function get_grid_query (
    pi_tis_id in template_import_status.tis_id%type
  )
    return varchar2
  ;

  function get_grid_data (
    pi_tis_id in template_import_status.tis_id%type
  ) return t_grid_tab pipelined
  ;

  procedure update_answer_status(
    pi_tis_id       in template_import_status.tis_id%type
  , pi_tid_row_id   in template_import_data.tid_row_id%type
  , pi_annotation   in template_import_data.tid_text%type
  , pi_faulty       in template_import_data.tid_text%type   
  );

  procedure update_answer(
    pi_tid_text_array in t_tid_text_array
  , pi_tid_row_id     in template_import_data.tid_row_id%type
  , pi_tis_id         in template_import_data.tid_tis_id%type
  );

  procedure insert_answer(
    pi_tid_text_array in t_tid_text_array
  , pi_annotation     in template_import_data.tid_text%type
  , pi_faulty         in template_import_data.tid_text%type --number  
  , pi_tis_id         in template_import_data.tid_tis_id%type
  );

  procedure delete_answer (
    pi_tis_id     in template_import_status.tis_id%type
  , pi_tid_row_id in template_import_data.tid_row_id%type

  );
  function get_column_count (
    pi_tis_id in template_import_status.tis_id%type
  )
    return varchar2
  ;
end p00051_api;
/

create or replace package p00060_api
as

 type t_grid_row is record (
    tid_row_id template_import_data.tid_row_id%type
  , col01      template_import_data.tid_text%type
  , col02      template_import_data.tid_text%type
  , col03      template_import_data.tid_text%type
  , col04      template_import_data.tid_text%type
  , col05      template_import_data.tid_text%type
  , col06      template_import_data.tid_text%type
  , col07      template_import_data.tid_text%type
  , col08      template_import_data.tid_text%type
  , col09      template_import_data.tid_text%type
  , col10      template_import_data.tid_text%type
  , col11      template_import_data.tid_text%type
  , col12      template_import_data.tid_text%type
  , col13      template_import_data.tid_text%type
  , col14      template_import_data.tid_text%type
  , col15      template_import_data.tid_text%type
  , col16      template_import_data.tid_text%type
  , col17      template_import_data.tid_text%type
  , col18      template_import_data.tid_text%type
  , col19      template_import_data.tid_text%type
  , col20      template_import_data.tid_text%type
  , col21      template_import_data.tid_text%type
  , col22      template_import_data.tid_text%type
  , col23      template_import_data.tid_text%type
  , col24      template_import_data.tid_text%type
  , col25      template_import_data.tid_text%type
  , col26      template_import_data.tid_text%type
  , col27      template_import_data.tid_text%type
  , col28      template_import_data.tid_text%type
  , col29      template_import_data.tid_text%type
  , col30      template_import_data.tid_text%type
  , col31      template_import_data.tid_text%type
  , col32      template_import_data.tid_text%type
  , col33      template_import_data.tid_text%type
  , col34      template_import_data.tid_text%type
  , col35      template_import_data.tid_text%type
  , col36      template_import_data.tid_text%type
  , col37      template_import_data.tid_text%type
  , col38      template_import_data.tid_text%type
  , col39      template_import_data.tid_text%type
  , col40      template_import_data.tid_text%type
  , col41      template_import_data.tid_text%type
  , col42      template_import_data.tid_text%type
  , col43      template_import_data.tid_text%type
  , col44      template_import_data.tid_text%type
  , col45      template_import_data.tid_text%type
  );

  type t_grid_tab is table of t_grid_row;

  type t_tid_text_array is varray(45) of template_import_data.tid_text%type;

  type t_hea_text_array is varray(45) of r_header.hea_text%type;

  function get_grid_query (
    pi_tis_tpl_id in template_import_status.tis_tpl_id%type
  )
    return varchar2
  ;

  function get_grid_data (
    pi_tis_tpl_id in template_import_status.tis_tpl_id%type
  ) return t_grid_tab pipelined
  ;

  function get_column_count (
    pi_tis_tpl_id in template_import_status.tis_tpl_id%type
  )
    return varchar2
  ;

end p00060_api;
/

create or replace package p00085_api as 

  procedure edit_template(
    pi_tpl_id in r_templates.tpl_id%type  
  );

  procedure create_preview(
    pi_collection_name in  apex_collections.collection_name%type default 'EDIT_TEMPLATE'  
  );

end p00085_api;
/

create or replace package p00090_api
as

  procedure delete_template (
    pi_tpl_id          in  r_templates.tpl_id%type
  );

end p00090_api;
/

create or replace package validation_api as 

  function validate_data(
    p_tid_text      template_import_data.tid_text%type
  , p_val_text      r_validation.val_text%type
  ) return boolean;
  
  procedure validation (
    p_tis_id in template_import_status.tis_id%type
  );

end validation_api;
/

create or replace PACKAGE xlsx_builder_pkg
   AUTHID CURRENT_USER
IS
   /**********************************************
   **
   ** Author: Anton Scheffer
   ** Date: 19-02-2011
   ** Website: http://technology.amis.nl/blog
   ** See also: http://technology.amis.nl/blog/?p=10995
   **
   ** Changelog:
   **   Date: 21-02-2011
   **     Added Aligment, horizontal, vertical, wrapText
   **   Date: 06-03-2011
   **     Added Comments, MergeCells, fixed bug for dependency on NLS-settings
   **   Date: 16-03-2011
   **     Added bold and italic fonts
   **   Date: 22-03-2011
   **     Fixed issue with timezone's set to a region(name) instead of a offset
   **   Date: 08-04-2011
   **     Fixed issue with XML-escaping from text
   **   Date: 27-05-2011
   **     Added MIT-license
   **   Date: 11-08-2011
   **     Fixed NLS-issue with column width
   **   Date: 29-09-2011
   **     Added font color
   **   Date: 16-10-2011
   **     fixed bug in add_string
   **   Date: 26-04-2012
   **     Fixed set_autofilter (only one autofilter per sheet, added _xlnm._FilterDatabase)
   **     Added list_validation = drop-down
   **   Date: 27-08-2013
   **     Added freeze_pane
   **   Date: 01-03-2014 (MK)
   **     Changed new_sheet to function returning sheet id
   **   Date: 22-03-2014 (MK)
   **     Added function to convert Oracle Number Format to Excel Format
   **   Date: 07-04-2014 (MK)
   **     Removed references to UTL_FILE
   **     query2sheet is now function returning BLOB
   **     changed date handling to be based on 01-01-1900
   **   Date: 08-04-2014 (MK)
   **     internal function for date to excel serial conversion added
   **   Date: 01-12-2014 (AMEI)
   **     Some Naming-conventions (and renaming of elements accordingly), new FUNCTION get_sheet_id
   **     Triggered by: @SEE AMEI, 20141129 Bugfix:
   **     For concatenation operations (in particular where record fields are involved) added a lot of TO_CHAR (...)
   **     to make sure correct explicit conversion (mayby not all caught where necessary)
   **     To make this easier to recognize, inducted some naming conventions and renamed some elements.
   **   Date: 26-04-2017 (MP)
   **     Added new function "query2sheet2" which is faster.
   **     For dates used following logic:
   **       - if trunc([column])=[column], then outputed cell value is formatted to format YYYYMMDD;
   **       - otherwise, outputted cell value is formatted to format YYYYMMDDTHH24MISS;
   **   Date: 24-09-2019 (PH)
   **     Added parameter "p_hidden" to function "new_sheet" to create a hidden sheet 
   **   Date: 24-05-2021 (TH)
   **     Added parameter "p_formula" to function "cell" to add a formual into a cell 
   ******************************************************************************
   ******************************************************************************
   Copyright (C) 2011, 2012 by Anton Scheffer

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
   THE SOFTWARE.

   ******************************************************************************
   ******************************************************************************
   * @headcom
   */

   /**
   * Record with data about column alignment.
   * @param vertical   Vertical alignment.
   * @param horizontal Horizontal alignment.
   * @param wrapText   Switch to allow or disallow word wrap.
   */
   TYPE t_alignment_rec IS RECORD
   (
      vc_vertical     VARCHAR2 (11),
      vc_horizontal   VARCHAR2 (16),
      bo_wraptext     BOOLEAN
   );

   type t_bind_tab is table of varchar2(32767) index by varchar2(32767);

   type t_header_tab is table of varchar2(32767) index by pls_integer;

   /**
   * Clears the whole workbook to start fresh.
   */
   PROCEDURE clear_workbook;

   /**
   * Create a new sheet in the workbook.
   * @param p_sheetname Name Excel should display for the new worksheet.
   * @return ID of newly created worksheet.
   */
   FUNCTION new_sheet (p_sheetname VARCHAR2 := NULL, p_hidden BOOLEAN := FALSE)
      RETURN PLS_INTEGER;

   /**
   * Add a sheetprotection in the workbook.
   * @param p_ssp_hash_value Hash Value for Sheetprotection.
   * @param p_ssp_salt_value Salt Value for Sheetprotection.
   * @param p_sheet Worksheet the protection will be added.
   */
   PROCEDURE sheet_protection (p_ssp_hash_value VARCHAR2, 
                               p_ssp_salt_value VARCHAR2,
                               p_sheet     PLS_INTEGER);

   /**
   * Put a protected range to a sheet.
   * @param p_name unique name for the protected range.
   * @param p_tl_col Protected Range Column top left.
   * @param p_tl_row Protected Range Row top left.
   * @param p_br_col Protected Range Column bottom right.
   * @param p_br_row End Range Start Row bottom right.
   * @param p_sheet Worksheet the protected-range will be added.
   */
   PROCEDURE protected_range (p_name      VARCHAR2,
                              p_tl_col    PLS_INTEGER, -- top left
                              p_tl_row    PLS_INTEGER, 
                              p_br_col    PLS_INTEGER, -- bottom right
                              p_br_row    PLS_INTEGER, 
                              p_sheet     PLS_INTEGER);

   /**
   * Converts an Oracle date format to the corresponding Excel date format.
   * @param p_format The Oracle date format to convert.
   * @return Corresponding Excel date format.
   */
   FUNCTION orafmt2excel (p_format VARCHAR2 := NULL)
      RETURN VARCHAR2;

   /**
   * Converts an Oracle number format to the corresponding Excel number format.
   * @param The Oracle number format to convert.
   * @return Corresponding Excel number format.
   */
   FUNCTION oranumfmt2excel (p_format VARCHAR2)
      RETURN VARCHAR2;

   /**
   * Get ID for given number format.
   * @param p_format Wanted number formatting using Excle number format.
   *                 Use OraNumFmt2Excel to convert from Oracle to Excel.
   * @return ID for given number format.
   */
   FUNCTION get_numfmt (p_format VARCHAR2 := NULL)
      RETURN PLS_INTEGER;

   /**
   * Get ID for given font settings.
   * @param p_name
   * @param p_family
   * @param p_fontsize
   * @param p_theme
   * @param p_underline
   * @param p_italic
   * @param p_bold
   * @param p_rgb
   * @return ID for given font definition
   */
   FUNCTION get_font (p_name         VARCHAR2,
                      p_family       PLS_INTEGER := 2,
                      p_fontsize     NUMBER := 8,
                      p_theme        PLS_INTEGER := 1,
                      p_underline    BOOLEAN := FALSE,
                      p_italic       BOOLEAN := FALSE,
                      p_bold         BOOLEAN := FALSE,
                      p_rgb          VARCHAR2 := NULL                        -- this is a hex ALPHA Red Green Blue value, but RGB works also
                                                     )
      RETURN PLS_INTEGER;

   /**
   * Get ID for given cell fill
   * @param p_patternType Pattern for the fill.
   * @param p_fgRGB       Color using an ARGB or RGB hex value
   * @return ID for given cell fill.
   */
   FUNCTION get_fill (p_patterntype VARCHAR2, p_fgrgb VARCHAR2 := NULL)
      RETURN PLS_INTEGER;

   /**
   * Get ID for given border definition.
   * Possible values for all parameters:
   * none, thin, medium, dashed, dotted, thick, double, hair, mediumDashed,
   * dashDot, mediumDashDot, dashDotDot, mediumDashDotDot, slantDashDot
   * @param p_top    Style for top border
   * @param p_bottom Style for bottom border
   * @param p_left   Style for left border
   * @param p_right  Style for right border
   * @return ID for given border definition
   */
   FUNCTION get_border (p_top       VARCHAR2 := 'thin',
                        p_bottom    VARCHAR2 := 'thin',
                        p_left      VARCHAR2 := 'thin',
                        p_right     VARCHAR2 := 'thin')
      RETURN PLS_INTEGER;

   /**
   * Function to get a record holding alignment data.
   * @param p_vertical   Vertical alignment.
   *                     (bottom, center, distributed, justify, top)
   * @param p_horizontal Horizontal alignment.
   *                     (center, centerContinuous, distributed, fill, general, justify, left, right)
   * @param p_wraptext   Switch to allow or disallow text wrapping.
   * @return Record with alignment data.
   */
   FUNCTION get_alignment (p_vertical VARCHAR2 := NULL, p_horizontal VARCHAR2 := NULL, p_wraptext BOOLEAN := NULL)
      RETURN t_alignment_rec;

   /**
   * Puts a number value into a cell of the spreadsheet.
   * @param p_col       Column number where the cell is located
   * @param p_row       Row number where the cell is located
   * @param p_value     The value to put into the cell
   * @param p_numFmtId  ID of number format
   * @param p_fontId    ID of font defintion
   * @param p_fillId    ID of fill definition
   * @param p_borderId  ID of border definition
   * @param p_alignment The wanted alignment
   * @param p_sheet     Worksheet the cell is located, if omitted last worksheet is used
   */
   PROCEDURE cell (p_col          PLS_INTEGER,
                   p_row          PLS_INTEGER,
                   p_value        NUMBER,
                   p_numfmtid     PLS_INTEGER := NULL,
                   p_fontid       PLS_INTEGER := NULL,
                   p_fillid       PLS_INTEGER := NULL,
                   p_borderid     PLS_INTEGER := NULL,
                   p_alignment    t_alignment_rec := NULL,
                   p_sheet        PLS_INTEGER := NULL);

   /**
   * Puts a character value into a cell of the spreadsheet.
   * @param p_col       Column number where the cell is located
   * @param p_row       Row number where the cell is located
   * @param p_value     The value to put into the cell
   * @param p_numFmtId  ID of formatting definition
   * @param p_fontId    ID of font defintion
   * @param p_fillId    ID of fill definition
   * @param p_borderId  ID of border definition
   * @param p_alignment The wanted alignment
   * @param p_sheet     Worksheet the cell is located, if omitted last worksheet is used
   * @param p_formula   The formula to put into the cell
   */
   PROCEDURE cell (p_col          PLS_INTEGER,
                   p_row          PLS_INTEGER,
                   p_value        VARCHAR2,
                   p_numfmtid     PLS_INTEGER := NULL,
                   p_fontid       PLS_INTEGER := NULL,
                   p_fillid       PLS_INTEGER := NULL,
                   p_borderid     PLS_INTEGER := NULL,
                   p_alignment    t_alignment_rec := NULL,
                   p_sheet        PLS_INTEGER := NULL,
                   p_formula      VARCHAR2 := NULL);

   /**
   * Puts a date value into a cell of the spreadsheet.
   * @param p_col       Column number where the cell is located
   * @param p_row       Row number where the cell is located
   * @param p_value     The value to put into the cell
   * @param p_numFmtId  ID of format definition
   * @param p_fontId    ID of font defintion
   * @param p_fillId    ID of fill definition
   * @param p_borderId  ID of border definition
   * @param p_alignment The wanted alignment
   * @param p_sheet     Worksheet the cell is located, if omitted last worksheet is used
   */
   PROCEDURE cell (p_col          PLS_INTEGER,
                   p_row          PLS_INTEGER,
                   p_value        DATE,
                   p_numfmtid     PLS_INTEGER := NULL,
                   p_fontid       PLS_INTEGER := NULL,
                   p_fillid       PLS_INTEGER := NULL,
                   p_borderid     PLS_INTEGER := NULL,
                   p_alignment    t_alignment_rec := NULL,
                   p_sheet        PLS_INTEGER := NULL);

   PROCEDURE hyperlink (p_col      PLS_INTEGER,
                        p_row      PLS_INTEGER,
                        p_url      VARCHAR2,
                        p_value    VARCHAR2 := NULL,
                        p_sheet    PLS_INTEGER := NULL);

   PROCEDURE comment (p_col       PLS_INTEGER,
                      p_row       PLS_INTEGER,
                      p_text      VARCHAR2,
                      p_author    VARCHAR2 := NULL,
                      p_width     PLS_INTEGER := 150                                                                               -- pixels
                                                    ,
                      p_height    PLS_INTEGER := 100                                                                               -- pixels
                                                    ,
                      p_sheet     PLS_INTEGER := NULL);

   PROCEDURE mergecells (p_tl_col    PLS_INTEGER                                                                                 -- top left
                                                ,
                         p_tl_row    PLS_INTEGER,
                         p_br_col    PLS_INTEGER                                                                             -- bottom right
                                                ,
                         p_br_row    PLS_INTEGER,
                         p_sheet     PLS_INTEGER := NULL);

  PROCEDURE add_validation (p_type           VARCHAR2,
                             p_sqref          VARCHAR2,
                             p_style          VARCHAR2 := 'stop'                                               -- stop, warning, information
                                                                ,
                             p_formula1       VARCHAR2 := NULL,
                             p_formula2       VARCHAR2 := NULL,
                             p_title          VARCHAR2 := NULL,
                             p_prompt         VARCHAR2 := NULL,
                             p_show_error     BOOLEAN := FALSE,
                             p_error_title    VARCHAR2 := NULL,
                             p_error_txt      VARCHAR2 := NULL,
                             p_sheet          PLS_INTEGER := NULL) ;

   PROCEDURE list_validation (p_sqref_col        PLS_INTEGER,
                              p_sqref_row        PLS_INTEGER,
                              p_tl_col           PLS_INTEGER                                                                       -- top left
                                                            ,
                              p_tl_row           PLS_INTEGER,
                              p_br_col           PLS_INTEGER                                                                   -- bottom right
                                                            ,
                              p_br_row           PLS_INTEGER,
                              p_style            VARCHAR2 := 'stop'                                              -- stop, warning, information
                                                                   ,
                              p_title            VARCHAR2 := NULL,
                              p_prompt           VARCHAR2 := NULL,
                              p_show_error       BOOLEAN := FALSE,
                              p_error_title      VARCHAR2 := NULL,
                              p_error_txt        VARCHAR2 := NULL,
                              p_sheet            PLS_INTEGER := NULL,
                              p_sheet_datasource PLS_INTEGER := NULL);

   PROCEDURE list_validation (p_sqref_col       PLS_INTEGER,
                              p_sqref_row       PLS_INTEGER,
                              p_defined_name    VARCHAR2,
                              p_style           VARCHAR2 := 'stop'                                             -- stop, warning, information
                                                                  ,
                              p_title           VARCHAR2 := NULL,
                              p_prompt          VARCHAR2 := NULL,
                              p_show_error      BOOLEAN := FALSE,
                              p_error_title     VARCHAR2 := NULL,
                              p_error_txt       VARCHAR2 := NULL,
                              p_sheet           PLS_INTEGER := NULL);

   PROCEDURE defined_name (p_tl_col        PLS_INTEGER                                                                           -- top left
                                                      ,
                           p_tl_row        PLS_INTEGER,
                           p_br_col        PLS_INTEGER                                                                       -- bottom right
                                                      ,
                           p_br_row        PLS_INTEGER,
                           p_name          VARCHAR2,
                           p_sheet         PLS_INTEGER := NULL,
                           p_localsheet    PLS_INTEGER := NULL);

   PROCEDURE set_column_width (p_col PLS_INTEGER, p_width NUMBER, p_sheet PLS_INTEGER := NULL);

   PROCEDURE set_column (p_col          PLS_INTEGER,
                         p_numfmtid     PLS_INTEGER := NULL,
                         p_fontid       PLS_INTEGER := NULL,
                         p_fillid       PLS_INTEGER := NULL,
                         p_borderid     PLS_INTEGER := NULL,
                         p_alignment    t_alignment_rec := NULL,
                         p_sheet        PLS_INTEGER := NULL);

   PROCEDURE set_row (p_row          PLS_INTEGER,
                      p_numfmtid     PLS_INTEGER := NULL,
                      p_fontid       PLS_INTEGER := NULL,
                      p_fillid       PLS_INTEGER := NULL,
                      p_borderid     PLS_INTEGER := NULL,
                      p_alignment    t_alignment_rec := NULL,
                      p_sheet        PLS_INTEGER := NULL);

   PROCEDURE freeze_rows (p_nr_rows PLS_INTEGER := 1, p_sheet PLS_INTEGER := NULL);

   PROCEDURE freeze_cols (p_nr_cols PLS_INTEGER := 1, p_sheet PLS_INTEGER := NULL);

   PROCEDURE freeze_pane (p_col PLS_INTEGER, p_row PLS_INTEGER, p_sheet PLS_INTEGER := NULL);

   PROCEDURE set_autofilter (p_column_start    PLS_INTEGER := NULL,
                             p_column_end      PLS_INTEGER := NULL,
                             p_row_start       PLS_INTEGER := NULL,
                             p_row_end         PLS_INTEGER := NULL,
                             p_sheet           PLS_INTEGER := NULL);

   FUNCTION finish 
      RETURN BLOB;

   FUNCTION query2sheet (p_sql VARCHAR2, p_column_headers BOOLEAN := TRUE, p_sheet PLS_INTEGER := NULL, p_skip_header boolean := FALSE)
      RETURN BLOB;

   FUNCTION finish2 (p_clob                 IN OUT NOCOPY CLOB,
                     p_columns              PLS_INTEGER,
                     p_rows                 PLS_INTEGER,
                     p_XLSX_date_format     VARCHAR2,
                     p_XLSX_datetime_format VARCHAR2)
      RETURN BLOB;

   FUNCTION query2sheet2(p_sql                  VARCHAR2,
                         p_XLSX_date_format     VARCHAR2 := 'dd/mm/yyyy',
                         p_XLSX_datetime_format VARCHAR2 := 'dd/mm/yyyy hh24:mi:ss')
      RETURN BLOB;

   function query2sheet3
   (
     p_sql     in varchar2
   , p_binds   in t_bind_tab
   , p_headers in t_header_tab
   , p_XLSX_date_format     VARCHAR2 := 'dd/mm/yyyy'
   , p_XLSX_datetime_format VARCHAR2 := 'dd/mm/yyyy hh24:mi:ss'
   )
      return blob;

END;
/

create or replace PACKAGE zip_util_pkg
  AUTHID CURRENT_USER
AS

/**
* Purpose:      Package handles zipping and unzipping of files
*
* Remarks:      by Anton Scheffer, see http://forums.oracle.com/forums/thread.jspa?messageID=9289744#9289744
*
*               for unzipping, see http://technology.amis.nl/blog/8090/parsing-a-microsoft-word-docx-and-unzip-zipfiles-with-plsql
*               for zipping, see http://forums.oracle.com/forums/thread.jspa?threadID=1115748&tstart=0
*
* Who     Date        Description
* ------  ----------  --------------------------------
* MBR     09.01.2011  Created
* MK      16.04.2014  Removed UTL_FILE dependencies and file operations
* MK      01.07.2014  Added get_file_clob to immediately retrieve file content as a CLOB
*
* @headcom
**/

  /** List of all files within zipped file */
  TYPE t_file_list IS TABLE OF CLOB;


  FUNCTION little_endian( p_big IN NUMBER
                        , p_bytes IN pls_integer := 4
                        )
    RETURN RAW;

  FUNCTION get_file_list( p_zipped_blob IN BLOB
                        , p_encoding IN VARCHAR2 := NULL /* Use CP850 for zip files created with a German Winzip to see umlauts, etc */
                        )
    RETURN t_file_list;

  FUNCTION get_file( p_zipped_blob IN BLOB
                   , p_file_name IN VARCHAR2
                   , p_encoding IN VARCHAR2 := NULL
                   )
    RETURN BLOB;

  FUNCTION get_file_clob( p_zipped_blob IN BLOB
                        , p_file_name IN VARCHAR2
                        , p_encoding IN VARCHAR2 := NULL
                        )
    RETURN CLOB;

  PROCEDURE add_file( p_zipped_blob IN OUT NOCOPY BLOB
                    , p_name IN VARCHAR2
                    , p_content IN BLOB
                    )
  ;

  PROCEDURE add_file( p_zipped_blob IN OUT NOCOPY BLOB
                    , p_name IN VARCHAR2
                    , p_content CLOB
                    )
  ;

  PROCEDURE finish_zip( p_zipped_blob IN OUT NOCOPY BLOB);

END zip_util_pkg;
/

create or replace package body email_pkg
as

 gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';
 
  procedure new_template(
    p_App_ID    pls_integer, 
    p_Page_ID   pls_integer, 
    p_static_id varchar2
  )
  as
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'new_template';
    l_params      logger.tab_param;

    l_id          number;
    l_context      apex_exec.t_context;    
    l_emails_idx   pls_integer;
    l_names_ids    pls_integer;
    l_deadline_ids pls_integer;
    l_note_ids     pls_integer;
    l_status_ids   pls_integer;
    l_tpl_ids      pls_integer;
    l_tis_ids      pls_integer;
    l_per_ids      pls_integer;
    l_region_id    number;    
    l_deadline     varchar2(20 char);

    l_count_recipient number := 0;
  begin
      logger.log('START', l_scope, null, l_params);

      -- Get the region id for the CUSTOMERS IR region
      select region_id
        into l_region_id
        from apex_application_page_regions
       where application_id = p_App_ID
         and page_id        = p_Page_ID
         and static_id      = p_static_id;

      -- Get the query context for the New Contracts IG Region
      l_context := apex_region.open_query_context (
                          p_page_id => p_Page_ID,
                          p_region_id => l_region_id );

      -- Get the column positions for columns
      l_emails_idx    := apex_exec.get_column_position( l_context, 'PER_EMAIL' );
      l_names_ids     := apex_exec.get_column_position( l_context, 'PER_NAME' );
      l_deadline_ids  := apex_exec.get_column_position( l_context, 'TIS_DEADLINE' );
      l_note_ids      := apex_exec.get_column_position( l_context, 'TIS_ANNOTATION' );
      l_status_ids    := apex_exec.get_column_position( l_context, 'TIS_STS_ID' );
      l_tpl_ids       := apex_exec.get_column_position( l_context, 'TPL_ID' );
      l_per_ids       := apex_exec.get_column_position( l_context, 'PER_ID' );
      l_tis_ids       := apex_exec.get_column_position( l_context, 'TIS_ID' );

      -- Loop throught the query of the context
      while apex_exec.next_row( l_context ) loop        

          -- generate Excel template
          p00030_api.generate_excel_file ( 
            pi_tpl_id => apex_exec.get_number( l_context, l_tpl_ids )
          , pi_per_id => apex_exec.get_number( l_context, l_per_ids )
          );          

          select to_char(sysdate + tpl_deadline,'dd.mm.yyyy')
            into l_deadline
            from r_templates 
           where tpl_id = apex_exec.get_number( l_context, l_tpl_ids );
         
          -- prepare Email
          l_id := apex_mail.send (
          p_to                 => apex_exec.get_varchar2( l_context, l_emails_idx ),
          p_from               => APEX_UTIL.GET_EMAIL(v('APP_USER')),
          p_template_static_id => 'NEWTEMPLATE',
          p_placeholders       => '{' ||
          '    "CONTACT_PERSON":'      || apex_json.stringify( apex_exec.get_varchar2( l_context, l_names_ids )) ||
          '   ,"DEADLINE":'            || apex_json.stringify( l_deadline ) ||
          '   ,"NOTES":'               || apex_json.stringify( case when apex_exec.get_varchar2( l_context, l_note_ids ) is null then 'No comments' else apex_exec.get_varchar2( l_context, l_note_ids ) end ) ||
          '}' 
          );

          -- Anhang hinzufügen, Versandstatus setzen, Datei in DB leeren
          for rec in (
            select fil_file, fil_filename, fil_mimetype from files
              join template_import_status on fil_id = tis_fil_id
             where tis_id = apex_exec.get_number( l_context, l_tis_ids ))
          loop

          apex_mail.add_attachment(
            p_mail_id    => l_id,
            p_attachment => rec.fil_file,
            p_filename   => rec.fil_filename,
            p_mime_type  => rec.fil_mimetype);

          -- set new deadline
          update (
              select tis_deadline from template_import_status
              where tis_id = apex_exec.get_number( l_context, l_tis_ids )) tis
          set tis.tis_deadline = sysdate + (select tpl_deadline from r_templates where tpl_id = apex_exec.get_number( l_context, l_tpl_ids ));
          
          -- Versandstatus setzen - Umfrage versandt
          update (
              select tis_shipping_status from template_import_status
              where tis_id = apex_exec.get_number( l_context, l_tis_ids )) pss
          set pss.tis_shipping_status = 2;

          --Excel-Sheet leeren
          update (
                select fil_file from files
                join template_import_status on fil_id = tis_fil_id
                where tis_id = apex_exec.get_number( l_context, l_tis_ids )) fil
          set fil.fil_file = empty_blob();

          end loop;

        -- Mail senden
        apex_mail.push_queue;     

        -- Anzahl Empfänger zählen
        l_count_recipient := l_count_recipient+1;
      end loop;

      apex_exec.close( l_context );      

      if l_count_recipient = 0 then
        raise value_error;
      end if;

  exception
      when value_error then
      if l_count_recipient = 0 then
          raise_application_error(-20000,'No email recipients found!');
      end if; 
      when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
          apex_exec.close( l_context );
      raise; 
  end new_template;
  
  procedure new_template_automation(
    p_tis_id            template_import_status.tis_id%type,
    p_tis_annotation    template_import_status.tis_annotation%type,
    p_per_id            r_person.per_id%type,
    p_per_name          varchar2,
    p_per_email         r_person.per_email%type,
    p_tpl_id            r_templates.tpl_id%type   
  )
  as
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'new_template_automation';
    l_params      logger.tab_param;
    l_deadline    varchar2(20 char);    
    l_id          number;  
  begin
      logger.append_param(l_params, 'p_tis_id', p_tis_id);
      logger.append_param(l_params, 'p_tis_annotation', p_tis_annotation);
      logger.append_param(l_params, 'p_per_id', p_per_id);
      logger.append_param(l_params, 'p_per_name', p_per_name);
      logger.append_param(l_params, 'p_per_email', p_per_email);
      logger.append_param(l_params, 'p_tpl_id', p_tpl_id);
      logger.log('START', l_scope, null, l_params);

      -- generate Excel template
      p00030_api.generate_excel_file ( 
        pi_tpl_id => p_tpl_id
      , pi_per_id => p_per_id
      );          

      select to_char(sysdate + tpl_deadline,'dd.mm.yyyy')
        into l_deadline
        from r_templates 
       where tpl_id = p_tpl_id;
      
      -- prepare Email
      l_id := apex_mail.send (
      p_to                 => p_per_email,
      p_from               => APEX_UTIL.GET_EMAIL(v('APP_USER')),
      p_template_static_id => 'NEWTEMPLATE',
      p_placeholders       => '{' ||
      '    "CONTACT_PERSON":'      || apex_json.stringify( p_per_name ) ||
      '   ,"DEADLINE":'            || apex_json.stringify( l_deadline ) ||
      '   ,"NOTES":'               || apex_json.stringify( case when p_tis_annotation is null then 'No comments' else p_tis_annotation end ) ||
      '}' 
      );

      -- Anhang hinzufügen, Versandstatus setzen, Datei in DB leeren
      for rec in (
        select fil_file, fil_filename, fil_mimetype from files
          join template_import_status on fil_id = tis_fil_id
         where tis_id = p_tis_id)
      loop

      apex_mail.add_attachment(
        p_mail_id    => l_id,
        p_attachment => rec.fil_file,
        p_filename   => rec.fil_filename,
        p_mime_type  => rec.fil_mimetype);
      
      logger.log('HIER 1');  
      -- set new deadline
      update template_import_status  
         set tis_deadline = l_deadline
       where tis_id = p_tis_id;
      logger.log('HIER 2');
      -- Versandstatus setzen - Umfrage versandt
      update template_import_status
         set tis_shipping_status = 2
       where tis_id = p_tis_id;
      logger.log('HIER 3');  
      --Excel-Sheet leeren
      update (
            select fil_file from files
            join template_import_status on fil_id = tis_fil_id
            where tis_id = p_tis_id) fil
      set fil.fil_file = empty_blob();

      end loop;

      -- Mail senden
      apex_mail.push_queue;    

  exception
      when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise; 
  end new_template_automation;

  PROCEDURE corrected_template(
    p_App_ID    pls_integer, 
    p_Page_ID   pls_integer, 
    p_static_id varchar2
  )
  as
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'corrected_template';
    l_params      logger.tab_param;

    l_id          number;
    l_context     apex_exec.t_context;    
    l_emails_idx   pls_integer;
    l_names_ids    pls_integer;
    l_deadline_ids pls_integer;
    l_note_ids     pls_integer;
    l_status_ids   pls_integer;
    l_tpl_ids      pls_integer;
    l_tis_ids      pls_integer;
    l_per_ids      pls_integer;
    l_region_id    number;    
    l_deadline     varchar2(20 char);

    l_count_recipient number := 0;
  begin
      logger.log('START', l_scope, null, l_params);

      -- Get the region id for the CUSTOMERS IR region
      select region_id
        into l_region_id
        from apex_application_page_regions
       where application_id = p_App_ID
         and page_id        = p_Page_ID
         and static_id      = p_static_id;

      -- Get the query context for the New Contracts IG Region
      l_context := apex_region.open_query_context (
                          p_page_id => p_Page_ID,
                          p_region_id => l_region_id );

      -- Get the column positions for columns
      l_emails_idx    := apex_exec.get_column_position( l_context, 'PER_EMAIL' );
      l_names_ids     := apex_exec.get_column_position( l_context, 'PER_NAME' );
      l_deadline_ids  := apex_exec.get_column_position( l_context, 'TIS_DEADLINE' );
      l_note_ids      := apex_exec.get_column_position( l_context, 'TIS_ANNOTATION' );
      l_status_ids    := apex_exec.get_column_position( l_context, 'TIS_STS_ID' );
      l_tpl_ids       := apex_exec.get_column_position( l_context, 'TPL_ID' );
      l_per_ids       := apex_exec.get_column_position( l_context, 'PER_ID' );
      l_tis_ids       := apex_exec.get_column_position( l_context, 'TIS_ID' );

      -- Loop throught the query of the context
      while apex_exec.next_row( l_context ) loop        
          --l_deadline := apex_exec.get_varchar2( l_context, l_deadline_ids );
          --l_deadline := to_char(to_date(l_deadline)+14,'dd.mm.yyyy');
          
          select to_char(sysdate + tpl_deadline,'dd.mm.yyyy')
            into l_deadline
            from r_templates 
           where tpl_id = apex_exec.get_number( l_context, l_tpl_ids );

          -- Mail vorbereiten
          l_id := apex_mail.send (
          p_to                 => apex_exec.get_varchar2( l_context, l_emails_idx ),
          p_from               => APEX_UTIL.GET_EMAIL(v('APP_USER')),
          p_template_static_id => 'CORRECTION',
          p_placeholders       => '{' ||
          '    "CONTACT_PERSON":'      || apex_json.stringify( apex_exec.get_varchar2( l_context, l_names_ids )) ||
          '   ,"DEADLINE":'            || apex_json.stringify( l_deadline ) ||
          '   ,"NOTES":'               || apex_json.stringify( case when apex_exec.get_varchar2( l_context, l_note_ids ) is null then 'No comments' else apex_exec.get_varchar2( l_context, l_note_ids ) end ) ||
          '}' 
          );

          -- Anhang hinzufügen, Versandstatus setzen, Datei in DB leeren
          for rec in (
            select fil_file, fil_filename, fil_mimetype from files
              join template_import_status on fil_id = tis_fil_id
             where tis_id = apex_exec.get_number( l_context, l_tis_ids )) 
          loop

          apex_mail.add_attachment(
            p_mail_id    => l_id,
            p_attachment => rec.fil_file,
            p_filename   => rec.fil_filename,
            p_mime_type  => rec.fil_mimetype);


          -- set new deadline
          update (
              select tis_deadline from template_import_status
              where tis_id = apex_exec.get_number( l_context, l_tis_ids )) tis
          set tis.tis_deadline = sysdate + (select tpl_deadline from r_templates where tpl_id = apex_exec.get_number( l_context, l_tpl_ids ));  


          -- Versandstatus setzen - Umfrage versandt
          update (
              select tis_shipping_status from template_import_status
              where tis_id = apex_exec.get_number( l_context, l_tis_ids )) pss
          set pss.tis_shipping_status = 3;

          --Excel-Sheet leeren
          update (
                select fil_file from files
                join template_import_status on fil_id = tis_fil_id
                where tis_id = apex_exec.get_number( l_context, l_tis_ids )) fil
          set fil.fil_file = empty_blob();

          end loop;
          
        -- Mail senden
        apex_mail.push_queue;        

        -- Anzahl Empfänger zählen
        l_count_recipient := l_count_recipient+1;
      end loop;

      apex_exec.close( l_context );      

      if l_count_recipient = 0 then
        raise value_error;
      end if;

  exception
      when value_error then
      if l_count_recipient = 0 then
          raise_application_error(-20000,'No email recipients found!');
      end if; 
      when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
          apex_exec.close( l_context );
      raise; 
  end corrected_template;
  
  procedure corrected_template_automation(
    p_tis_id            template_import_status.tis_id%type,
    p_tis_annotation    template_import_status.tis_annotation%type,
    p_per_id            r_person.per_id%type,
    p_per_name          varchar2,
    p_per_email         r_person.per_email%type,
    p_tpl_id            r_templates.tpl_id%type   
  )
  as
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'corrected_template_automation';
    l_params      logger.tab_param;
    l_deadline    varchar2(20 char);    
    l_id          number;  
  begin
      logger.append_param(l_params, 'p_tis_id', p_tis_id);
      logger.append_param(l_params, 'p_tis_annotation', p_tis_annotation);
      logger.append_param(l_params, 'p_per_id', p_per_id);
      logger.append_param(l_params, 'p_per_name', p_per_name);
      logger.append_param(l_params, 'p_per_email', p_per_email);
      logger.append_param(l_params, 'p_tpl_id', p_tpl_id);
      logger.log('START', l_scope, null, l_params);

      select to_char(sysdate + tpl_deadline,'dd.mm.yyyy')
        into l_deadline
        from r_templates 
       where tpl_id = p_tpl_id;
      
      -- prepare Email
      l_id := apex_mail.send (
      p_to                 => p_per_email,
      p_from               => APEX_UTIL.GET_EMAIL(v('APP_USER')),
      p_template_static_id => 'CORRECTION',
      p_placeholders       => '{' ||
      '    "CONTACT_PERSON":'      || apex_json.stringify( p_per_name ) ||
      '   ,"DEADLINE":'            || apex_json.stringify( l_deadline ) ||
      '   ,"NOTES":'               || apex_json.stringify( case when p_tis_annotation is null then 'No comments' else p_tis_annotation end ) ||
      '}' 
      );

      -- Anhang hinzufügen, Versandstatus setzen, Datei in DB leeren
      for rec in (
        select fil_file, fil_filename, fil_mimetype from files
          join template_import_status on fil_id = tis_fil_id
         where tis_id = p_tis_id)
      loop

      apex_mail.add_attachment(
        p_mail_id    => l_id,
        p_attachment => rec.fil_file,
        p_filename   => rec.fil_filename,
        p_mime_type  => rec.fil_mimetype);
      
      -- set new deadline
      update template_import_status  
         set tis_deadline = l_deadline
       where tis_id = p_tis_id;

      -- Versandstatus setzen - Umfrage versandt
      update template_import_status
         set tis_shipping_status = 3
       where tis_id = p_tis_id;
 
      --Excel-Sheet leeren
      update (
            select fil_file from files
            join template_import_status on fil_id = tis_fil_id
            where tis_id = p_tis_id) fil
      set fil.fil_file = empty_blob();

      end loop;

      -- Mail senden
      apex_mail.push_queue;    

  exception
      when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise; 
  end corrected_template_automation;

procedure reminder(
    p_App_ID    pls_integer, 
    p_Page_ID   pls_integer, 
    p_static_id varchar2
  )
  as
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'reminder';
    l_params      logger.tab_param;

    l_id          number;
    l_context     apex_exec.t_context;    
    l_emails_idx   pls_integer;
    l_names_ids    pls_integer;
    l_deadline_ids pls_integer;
    l_note_ids     pls_integer;
    l_status_ids   pls_integer;
    l_tpl_ids      pls_integer;
    l_tis_ids      pls_integer;
    l_per_ids      pls_integer;
    l_aspkvids     pls_integer;
    l_region_id    number;    
    l_deadline     varchar2(20 char);

    l_count_recipient number := 0;
  begin
      logger.log('START', l_scope, null, l_params);

      -- Get the region id for the CUSTOMERS IR region
      select region_id
        into l_region_id
        from apex_application_page_regions
       where application_id = p_App_ID
         and page_id        = p_Page_ID
         and static_id      = p_static_id;

      -- Get the query context for the New Contracts IG Region
      l_context := apex_region.open_query_context (
                          p_page_id => p_Page_ID,
                          p_region_id => l_region_id );

      -- Get the column positions for columns
      l_emails_idx    := apex_exec.get_column_position( l_context, 'PER_EMAIL' );
      l_names_ids     := apex_exec.get_column_position( l_context, 'PER_NAME' );
      l_deadline_ids  := apex_exec.get_column_position( l_context, 'TIS_DEADLINE' );
      l_note_ids      := apex_exec.get_column_position( l_context, 'TIS_ANNOTATION' );
      l_status_ids    := apex_exec.get_column_position( l_context, 'TIS_STS_ID' );
      l_tpl_ids       := apex_exec.get_column_position( l_context, 'TPL_ID' );
      l_per_ids       := apex_exec.get_column_position( l_context, 'PER_ID' );
      l_tis_ids       := apex_exec.get_column_position( l_context, 'TIS_ID' );

      -- Loop throught the query of the context
      while apex_exec.next_row( l_context ) loop        

          -- Excel Umfragen erstellen          
          p00030_api.generate_excel_file ( 
            pi_tpl_id => apex_exec.get_number( l_context, l_tpl_ids )
          , pi_per_id => apex_exec.get_number( l_context, l_per_ids )
          ); 

          select to_char(sysdate + tpl_deadline,'dd.mm.yyyy')
            into l_deadline
            from r_templates 
           where tpl_id = apex_exec.get_number( l_context, l_tpl_ids );

          -- Mail vorbereiten
          l_id := apex_mail.send (
          p_to                 => apex_exec.get_varchar2( l_context, l_emails_idx ),
          p_from               => APEX_UTIL.GET_EMAIL(v('APP_USER')),
          p_template_static_id => 'REMINDER',
          p_placeholders       => '{' ||
          '    "CONTACT_PERSON":'      || apex_json.stringify( apex_exec.get_varchar2( l_context, l_names_ids )) ||
          '   ,"DEADLINE":'            || apex_json.stringify( l_deadline ) ||
          '   ,"NOTES":'               || apex_json.stringify( case when apex_exec.get_varchar2( l_context, l_note_ids ) is null then 'No comments' else apex_exec.get_varchar2( l_context, l_note_ids ) end ) ||
          '}' 
          );

          -- Anhang hinzufügen, Versandstatus setzen, Datei in DB leeren
          for rec in (
            select fil_file, fil_filename, fil_mimetype from files
              join template_import_status on fil_id = tis_fil_id
             where tis_id = apex_exec.get_number( l_context, l_tis_ids ))
          loop

          apex_mail.add_attachment(
            p_mail_id    => l_id,
            p_attachment => rec.fil_file,
            p_filename   => rec.fil_filename,
            p_mime_type  => rec.fil_mimetype);


          -- set new deadline
          update (
              select tis_deadline from template_import_status
              where tis_id = apex_exec.get_number( l_context, l_tis_ids )) tis
          set tis.tis_deadline = sysdate + (select tpl_deadline from r_templates where tpl_id = apex_exec.get_number( l_context, l_tpl_ids ));


          -- Versandstatus setzen - Umfrage versandt
          update (
              select tis_shipping_status from template_import_status
              where tis_id = apex_exec.get_number( l_context, l_tis_ids )) pss
          set pss.tis_shipping_status = 4;

          --Excel-Sheet leeren
          update (
                select fil_file from files
                join template_import_status on fil_id = tis_fil_id
                where tis_id = apex_exec.get_number( l_context, l_tis_ids )) fil
          set fil.fil_file = empty_blob();

          end loop;
          
        -- Mail senden
        apex_mail.push_queue;        

        -- Anzahl Empfänger zählen
        l_count_recipient := l_count_recipient+1;
      end loop;

      apex_exec.close( l_context );      

      if l_count_recipient = 0 then
        raise value_error;
      end if;

  exception
      when value_error then
      if l_count_recipient = 0 then
          raise_application_error(-20000,'No email recipients found!');
      end if; 
      when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
          apex_exec.close( l_context );
      raise; 
  end reminder;
  
  procedure reminder_automation(
    p_tis_id            template_import_status.tis_id%type,
    p_tis_annotation    template_import_status.tis_annotation%type,
    p_per_id            r_person.per_id%type,
    p_per_name          varchar2,
    p_per_email         r_person.per_email%type,
    p_tpl_id            r_templates.tpl_id%type   
  )
  as
    l_scope       logger_logs.scope%type := gc_scope_prefix || 'reminder_automation';
    l_params      logger.tab_param;
    l_deadline    varchar2(20 char);    
    l_id          number;  
  begin
      logger.append_param(l_params, 'p_tis_id', p_tis_id);
      logger.append_param(l_params, 'p_tis_annotation', p_tis_annotation);
      logger.append_param(l_params, 'p_per_id', p_per_id);
      logger.append_param(l_params, 'p_per_name', p_per_name);
      logger.append_param(l_params, 'p_per_email', p_per_email);
      logger.append_param(l_params, 'p_tpl_id', p_tpl_id);
      logger.log('START', l_scope, null, l_params);

      -- generate Excel template
      p00030_api.generate_excel_file ( 
        pi_tpl_id => p_tpl_id
      , pi_per_id => p_per_id
      );          

      select to_char(sysdate + tpl_deadline,'dd.mm.yyyy')
        into l_deadline
        from r_templates 
       where tpl_id = p_tpl_id;
      
      -- prepare Email
      l_id := apex_mail.send (
      p_to                 => p_per_email,
      p_from               => APEX_UTIL.GET_EMAIL(v('APP_USER')),
      p_template_static_id => 'REMINDER',
      p_placeholders       => '{' ||
      '    "CONTACT_PERSON":'      || apex_json.stringify( p_per_name ) ||
      '   ,"DEADLINE":'            || apex_json.stringify( l_deadline ) ||
      '   ,"NOTES":'               || apex_json.stringify( case when p_tis_annotation is null then 'No comments' else p_tis_annotation end ) ||
      '}' 
      );

      -- Anhang hinzufügen, Versandstatus setzen, Datei in DB leeren
      for rec in (
        select fil_file, fil_filename, fil_mimetype from files
          join template_import_status on fil_id = tis_fil_id
         where tis_id = p_tis_id)
      loop

      apex_mail.add_attachment(
        p_mail_id    => l_id,
        p_attachment => rec.fil_file,
        p_filename   => rec.fil_filename,
        p_mime_type  => rec.fil_mimetype);
      
      -- set new deadline
      update template_import_status  
         set tis_deadline = l_deadline
       where tis_id = p_tis_id;
      
      -- Versandstatus setzen - Umfrage versandt
      update template_import_status
         set tis_shipping_status = 4
       where tis_id = p_tis_id;
      
      --Excel-Sheet leeren
      update (
            select fil_file from files
            join template_import_status on fil_id = tis_fil_id
            where tis_id = p_tis_id) fil
      set fil.fil_file = empty_blob();

      end loop;

      -- Mail senden
      apex_mail.push_queue;    

  exception
      when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise; 
  end reminder_automation;

end email_pkg;
/

create or replace package body excel_gen
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';
  
  -- get index of last excel column depending on number of columns
  function getExcelColumnName(
    p_column_count pls_integer
  ) return varchar2
  as
    l_dividend pls_integer := p_column_count;
    l_columnName varchar2(5) := '';
    l_modulo pls_integer;
  begin
    while (l_dividend > 0)
    loop
        l_modulo := mod(l_dividend - 1, 26);
        l_columnName := chr(65 + l_modulo) || l_columnName;
        l_dividend := (l_dividend - l_modulo) / 26;
    end loop;

    return l_columnName;

  end getExcelColumnName;  

  function get_number_of_rows(
    pi_tpl_id   r_templates.tpl_id%type
  ) return r_templates.tpl_number_of_rows%type
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_number_of_rows';
    l_params logger.tab_param;
    
    l_number_of_rows r_templates.tpl_number_of_rows%type;
  begin  
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.log('START', l_scope, null, l_params);
    
    select tpl_number_of_rows
      into l_number_of_rows
      from r_templates
     where tpl_id = pi_tpl_id; 
    
    return l_number_of_rows;
    
    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_number_of_rows;
    
  procedure generate_abfragen (
    pi_tpl_id    in r_templates.tpl_id%type
  , pi_sheet_num in pls_integer
  , pi_invalid   in boolean
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_abfragen';
    l_params logger.tab_param;

    l_annotation_id     r_header.hea_id%type := master_api.get_annotation_id;
    l_error_id          r_header.hea_id%type := master_api.get_faulty_id;
    l_validation_id     r_header.hea_id%type := master_api.get_validation_id;

    l_max_sort_order pls_integer;

    l_columnName varchar2(5);
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_sheet_num', pi_sheet_num);
    logger.log('START', l_scope, null, l_params);

    l_max_sort_order := 0;    

    for rec in (
      select tph_sort_order
           , hea_text
           , tph_xlsx_font_color
           , tph_xlsx_background_color
           , hea_xlsx_width
        from template_header
        join r_header 
          on hea_id = tph_hea_id
       where tph_tpl_id = pi_tpl_id
         and tph_hea_id not in (l_annotation_id, l_error_id, l_validation_id)         
       order by tph_sort_order
    )
    loop
      xlsx_builder_pkg.cell(
        p_col => rec.tph_sort_order  
      , p_row => gc_header_row
      , p_value => rec.hea_text
      , p_fontid => xlsx_builder_pkg.get_font(p_name => 'Arial', p_rgb => rec.tph_xlsx_font_color)
      , p_fillid => xlsx_builder_pkg.get_fill('solid', rec.tph_xlsx_background_color)
      , p_borderid => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')
      , p_alignment => xlsx_builder_pkg.get_alignment( p_wraptext => true, p_vertical => 'top', p_horizontal => 'center')
      , p_sheet => pi_sheet_num
      );

      xlsx_builder_pkg.set_column_width(     
        p_col   => rec.tph_sort_order          
      , p_width => rec.hea_xlsx_width
      , p_sheet => pi_sheet_num
      );

      l_max_sort_order := l_max_sort_order + 1;
    end loop;

    if pi_invalid then
      for rec in (
        select hea_text
             , tph_xlsx_font_color
             , tph_xlsx_background_color
             , hea_xlsx_width
           from template_header
           join r_header
             on hea_id = tph_hea_id
        where tph_tpl_id = pi_tpl_id
          and tph_hea_id = l_validation_id
        order by tph_sort_order
      )
      loop
        xlsx_builder_pkg.cell(
          p_col       => l_max_sort_order + 1  
        , p_row       => gc_header_row
        , p_value     => rec.hea_text
        , p_fontid    => xlsx_builder_pkg.get_font(p_name => 'Arial', p_rgb => rec.tph_xlsx_font_color)
        , p_fillid    => xlsx_builder_pkg.get_fill('solid', rec.tph_xlsx_background_color)
        , p_borderid  => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')  
        , p_alignment => xlsx_builder_pkg.get_alignment( p_wraptext => true, p_vertical => 'top', p_horizontal => 'center') 
        , p_sheet     => pi_sheet_num
        );

        xlsx_builder_pkg.set_column_width(
          p_col   => l_max_sort_order + 1 
        , p_width => rec.hea_xlsx_width
        , p_sheet => pi_sheet_num
        );
      end loop;

      for rec in (
        select hea_text
             , tph_xlsx_font_color
             , tph_xlsx_background_color
             , hea_xlsx_width
           from template_header
           join r_header
             on hea_id = tph_hea_id
        where tph_tpl_id = pi_tpl_id
          and tph_hea_id = l_annotation_id
        order by tph_sort_order
      )
      loop
        xlsx_builder_pkg.cell(
          p_col       => l_max_sort_order + 2  
        , p_row       => gc_header_row
        , p_value     => rec.hea_text
        , p_fontid    => xlsx_builder_pkg.get_font(p_name => 'Arial', p_rgb => rec.tph_xlsx_font_color)
        , p_fillid    => xlsx_builder_pkg.get_fill('solid', rec.tph_xlsx_background_color)
        , p_borderid  => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')  
        , p_alignment => xlsx_builder_pkg.get_alignment( p_wraptext => true, p_vertical => 'top', p_horizontal => 'center') 
        , p_sheet     => pi_sheet_num
        );

        xlsx_builder_pkg.set_column_width(
          p_col   => l_max_sort_order + 2 
        , p_width => rec.hea_xlsx_width
        , p_sheet => pi_sheet_num
        );     
      end loop;
    end if;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_abfragen;

  procedure generate_abfragegruppen (
    pi_tpl_id    in r_templates.tpl_id%type
  , pi_sheet_num in pls_integer
  , pi_invalid   in boolean
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_abfragegruppen';
    l_params logger.tab_param;

    l_max_sort_order    pls_integer;
    l_last_thg_id       template_header_group.thg_id%type;
    l_first_colnr_group pls_integer;
    l_thg_text          template_header_group.thg_text%type;
    l_tph_sort_order    template_header.tph_sort_order%type;

    l_count             pls_integer := 0;
    c_alignment         constant xlsx_builder_pkg.t_alignment_rec := xlsx_builder_pkg.get_alignment(
      p_wraptext   => true
    , p_vertical   => 'top'
    , p_horizontal => 'center'
    );
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_sheet_num', pi_sheet_num);
    logger.append_param(l_params, 'pi_invalid', pi_invalid);
    logger.log('START', l_scope, null, l_params);

    for rec in (
      select thg_id
           , tph_sort_order
           , thg_text
           , thg_xlsx_font_color
           , thg_xlsx_background_color
        from template_header_group
        join template_header
          on tph_thg_id = thg_id
         and tph_tpl_id = pi_tpl_id
       order by tph_sort_order
    )
    loop
      l_count := l_count + 1;
      l_tph_sort_order := rec.tph_sort_order;

      -- set Rahmen
      xlsx_builder_pkg.cell (
         p_col       => l_tph_sort_order
       , p_row       => gc_headergroup_row
       , p_sheet     => pi_sheet_num
       , p_borderid  => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')
       , p_fontid    => xlsx_builder_pkg.get_font(p_name => 'Arial', p_rgb => rec.thg_xlsx_font_color)
       , p_fillid    => xlsx_builder_pkg.get_fill('solid', rec.thg_xlsx_background_color)
       , p_alignment => c_alignment
       , p_value     => ''
      );

      -- get last col nr
      select min(tph_sort_order), max(tph_sort_order)
        into l_first_colnr_group, l_max_sort_order
        from template_header_group
        join template_header
          on tph_thg_id = thg_id
         and tph_tpl_id = pi_tpl_id
         and thg_id = rec.thg_id
      ; 

      -- if first group
      if l_tph_sort_order != l_max_sort_order then

        -- write group text
        xlsx_builder_pkg.cell (
          p_col       => l_tph_sort_order
        , p_row       => gc_headergroup_row
        , p_value     => rec.thg_text
        , p_fontid    => xlsx_builder_pkg.get_font(p_name => 'Arial', p_rgb => rec.thg_xlsx_font_color)
        , p_fillid    => xlsx_builder_pkg.get_fill('solid', rec.thg_xlsx_background_color)
        , p_alignment => c_alignment
        , p_sheet     => pi_sheet_num
        , p_borderid  => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')
        );
      else

        xlsx_builder_pkg.cell (
          p_col       => l_tph_sort_order
        , p_row       => gc_headergroup_row
        , p_value     => rec.thg_text
        , p_fontid    => xlsx_builder_pkg.get_font(p_name => 'Arial', p_rgb => rec.thg_xlsx_font_color)
        , p_fillid    => xlsx_builder_pkg.get_fill('solid', rec.thg_xlsx_background_color)
        , p_alignment => c_alignment
        , p_sheet     => pi_sheet_num
        , p_borderid  => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')
        );

        -- merge old ones
        xlsx_builder_pkg.mergecells (
          p_tl_col => l_first_colnr_group
        , p_tl_row => gc_headergroup_row
        , p_br_col => l_tph_sort_order
        , p_br_row => gc_headergroup_row
        , p_sheet  => pi_sheet_num
        );

      end if;
    end loop;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_abfragegruppen;
  
  procedure generate_answers (
    pi_tis_id    in template_import_status.tis_id%type
  , pi_sheet_num in pls_integer
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_answers';
    l_params logger.tab_param;

    l_annotation_id      r_header.hea_id%type := master_api.get_annotation_id;
    l_faulty_id          r_header.hea_id%type := master_api.get_faulty_id;
    l_validation_id      r_header.hea_id%type := master_api.get_validation_id;

    l_max_sort_order  template_header.tph_sort_order%type;
    l_annotation      template_import_data.tid_text%type;

    l_last_row pls_integer;
    l_rownum   pls_integer := 0;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    select max(tph_sort_order)
      into l_max_sort_order
      from template_header
      join template_import_data
        on tid_tph_id = tph_id
       and tid_tis_id = pi_tis_id
     where tph_hea_id not in (l_annotation_id, l_faulty_id, l_validation_id)
    ;

    -- generate answers
    for rec in (
      select tid_row_id, tph_sort_order, tid_text
        from template_import_data
        join template_header
          on tid_tph_id = tph_id
        join r_header
          on tph_hea_id = hea_id
       where tid_tis_id = pi_tis_id
         and tph_hea_id not in (l_annotation_id, l_faulty_id, l_validation_id)
         and tid_row_id in (
             select tid_row_id
               from template_import_data
               join template_header
                 on tid_tph_id = tph_id
              where tid_tis_id = pi_tis_id
                and tph_hea_id = l_faulty_id
                and tid_text   = '1'
         )
       order by tid_row_id, tph_sort_order
    )
    loop
      if l_last_row is null or rec.tid_row_id != l_last_row then
        l_last_row := rec.tid_row_id;
        l_rownum := l_rownum + 1;

        -- Validation
        for i in (
        select tid_text
          from template_import_data 
          join template_header
            on tid_tph_id = tph_id
           and tph_hea_id = l_validation_id
           and tid_row_id = rec.tid_row_id
         where tid_tis_id = pi_tis_id 
        )    
        loop

        xlsx_builder_pkg.cell (
          p_col       => l_max_sort_order + 1  
        , p_row       => l_rownum + gc_header_row
        , p_value     => i.tid_text
        , p_sheet     => pi_sheet_num
        , p_borderid => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')    
        );

        end loop;

        -- Annotation
        for i in (
        select tid_text
          from template_import_data 
          join template_header
            on tid_tph_id = tph_id
           and tph_hea_id = l_annotation_id
           and tid_row_id = rec.tid_row_id
         where tid_tis_id = pi_tis_id 
        )
        loop

        xlsx_builder_pkg.cell (
          p_col       => l_max_sort_order + 2  
        , p_row       => l_rownum + gc_header_row
        , p_value     => i.tid_text
        , p_sheet     => pi_sheet_num
        , p_borderid => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')    
        );

        end loop;

      end if;

      -- generate each answer cell
      xlsx_builder_pkg.cell (
        p_col       => rec.tph_sort_order  
      , p_row       => l_rownum + gc_header_row
      , p_value     => rec.tid_text
      , p_sheet     => pi_sheet_num
      , p_borderid  => xlsx_builder_pkg.get_border(p_top => 'thin', p_bottom => 'thin', p_left => 'thin', p_right => 'thin')            
      );
    end loop;

    -- generate hidden rownrs to match answers at the import
    for rec in (
      select tid_row_id, rownum
        from (
             select tid_row_id
               from template_import_data
               join template_header
                 on tid_tph_id = tph_id
              where tid_tis_id = pi_tis_id
                and tph_hea_id = l_faulty_id
                and tid_text   = '1'                
            )
           order by tid_row_id
    )
    loop
      xlsx_builder_pkg.cell (
        p_col       => gc_ids_col1
      , p_row       => rec.rownum + gc_header_row
      , p_value     => rec.tid_row_id
      , p_sheet     => pi_sheet_num
      );
    end loop;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_answers;

  procedure generate_hidden_ids (
    pi_per_id    in r_person.per_id%type
  , pi_tis_id    in template_import_status.tis_id%type  
  , pi_sheet_num in pls_integer
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_hidden_ids';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'pi_per_id', pi_per_id);
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.append_param(l_params, 'pi_sheet_num', pi_sheet_num);
    logger.log('START', l_scope, null, l_params);

    -- per_nr
    xlsx_builder_pkg.cell(
      p_col => gc_ids_col1
    , p_row => 1
    , p_value => pi_per_id
    , p_sheet => pi_sheet_num
    );

    xlsx_builder_pkg.set_column_width(
      p_col   => gc_ids_col1
    , p_width => 0
    , p_sheet => pi_sheet_num
    );    

    -- tis_id
    xlsx_builder_pkg.cell(
      p_col => gc_ids_col2
    , p_row => 1
    , p_value => pi_tis_id
    , p_sheet => pi_sheet_num
    );

    xlsx_builder_pkg.set_column_width(
      p_col   => gc_ids_col2
    , p_width => 0
    , p_sheet => pi_sheet_num
    );   

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_hidden_ids;

 procedure generate_validations (
    pi_tpl_id    in r_templates.tpl_id%type
  , pi_tis_id    in template_import_status.tis_id%type
  , pi_sheet_num in pls_integer
  , pi_invalid   in boolean
  , pi_number_of_rows in r_templates.tpl_number_of_rows%type 
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_validation';
    l_params logger.tab_param;

    l_annotation_id     r_header.hea_id%type := master_api.get_annotation_id;
    l_error_id          r_header.hea_id%type := master_api.get_faulty_id;
    l_validation_id     r_header.hea_id%type := master_api.get_validation_id;

    l_columnName   varchar2(5 char);
    l_formula_row  number;
    l_formula      varchar2(2000 char);
    l_invalid_rows pls_integer;
    l_columnNumber pls_integer;
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_sheet_num', pi_sheet_num);
    logger.append_param(l_params, 'pi_number_of_rows', pi_number_of_rows);
    logger.log('START', l_scope, null, l_params);    
      
    for rec in (
      select tph_sort_order
           , hea_text
           , tph_xlsx_font_color
           , tph_xlsx_background_color
           , hea_xlsx_width
           , val_text      
           , val_message           
           , thv_formula1  
           , thv_formula2  
           , case when val_text = 'date' then to_date(thv_formula1 , 'dd-mm-yyyy') - to_date('30.12.1899','dd-mm-yyyy') end as thv_formula1_date
           , case when val_text = 'date' then to_date(thv_formula2 , 'dd-mm-yyyy') - to_date('30.12.1899','dd-mm-yyyy') end as thv_formula2_date
        from template_header
        join r_header 
          on hea_id = tph_hea_id
        join r_validation
          on hea_val_id = val_id
        left join template_header_validations
          on thv_tph_id = tph_id  
       where tph_tpl_id = pi_tpl_id
         and tph_hea_id not in (l_annotation_id, l_error_id, l_validation_id)         
       order by tph_sort_order
    )
    loop
      --if date add validation
      if rec.val_text = 'date' then

        -- get excel column name
        l_columnName := getExcelColumnName(rec.tph_sort_order);

        -- add validation 
        for i in 1..pi_number_of_rows
        loop
            xlsx_builder_pkg.add_validation (
              p_type => 'date'
            , p_sqref => l_columnName || TO_CHAR (gc_header_row + i)
            , p_formula1 => rec.thv_formula1_date
            , p_formula2 => rec.thv_formula2_date
            , p_title => initcap(rec.val_text)
            , p_prompt => rec.thv_formula1 || ' - ' || rec.thv_formula2
            , p_show_error => true
            , p_error_txt => rec.val_message
            , p_sheet => pi_sheet_num
            );
        end loop;
      end if;

      --if number add validation  
      if rec.val_text = 'number' then

        -- get excel column name
        l_columnName := getExcelColumnName(rec.tph_sort_order);

        -- add validation 
        for i in 1..pi_number_of_rows
        loop
            xlsx_builder_pkg.add_validation (
              p_type => 'decimal'
            , p_sqref => l_columnName || TO_CHAR (gc_header_row + i)
            , p_formula1 => rec.thv_formula1
            , p_formula2 => rec.thv_formula2
            , p_title => initcap(rec.val_text)
            , p_prompt => rec.thv_formula1 ||' - ' || rec.thv_formula2
            , p_show_error => true
            , p_error_txt => rec.val_message
            , p_sheet => pi_sheet_num
            );
        end loop;
      end if;  
      
      --if email add validation  
      if rec.val_text = 'email' then

        -- get excel column name
        l_columnName := getExcelColumnName(rec.tph_sort_order);

        -- add validation
        for i in 1..pi_number_of_rows
        loop
            xlsx_builder_pkg.add_validation (
              p_type => 'custom'
            , p_sqref => l_columnName || TO_CHAR (gc_header_row + i)
            , p_formula1 => 'ISNUMBER(MATCH("*@*.?*",' || l_columnName || TO_CHAR (gc_header_row + i) ||',0))'
            , p_title => initcap(rec.val_text)
            , p_prompt => '-'
            , p_show_error => true
            , p_error_txt => rec.val_message
            , p_sheet => pi_sheet_num
            );
        end loop;
      end if;  
      
      --if formula add validation  
      if rec.val_text = 'formula' then

        -- get excel column name
        l_columnName := getExcelColumnName(rec.tph_sort_order);

        -- add validation
        if not pi_invalid then
          for i in 1..pi_number_of_rows
          loop
              l_formula_row := to_char(gc_header_row + i);
              
              l_columnNumber := rec.tph_sort_order;
              l_formula := replace(rec.thv_formula1,'#',l_formula_row);

              xlsx_builder_pkg.cell (
                p_col => l_columnNumber
              , p_row => gc_header_row + i
              , p_sheet => pi_sheet_num
              , p_formula => l_formula
              , p_value => 'n/a'
              );
          end loop;
        else
          select count(distinct tid_row_id)
            into l_invalid_rows
            from template_import_data
            join template_header
              on tid_tph_id = tph_id
            join r_header
              on tph_hea_id = hea_id
           where tid_tis_id = pi_tis_id
             and tph_hea_id not in (l_annotation_id, l_error_id, l_validation_id)
             and tid_row_id in (
                 select tid_row_id
                   from template_import_data
                   join template_header
                     on tid_tph_id = tph_id
                   where tid_tis_id = pi_tis_id
                     and tph_hea_id = l_error_id
                     and tid_text   = '1'
            );         
         
          for i in 1..l_invalid_rows
          loop
              l_formula_row := to_char(gc_header_row + i);
              
              l_columnNumber := rec.tph_sort_order;
              l_formula := replace(rec.thv_formula1,'#',l_formula_row);

              xlsx_builder_pkg.cell (
                p_col => l_columnNumber
              , p_row => gc_header_row + i
              , p_sheet => pi_sheet_num
              , p_formula => l_formula
              , p_value => 'n/a'
              );
          end loop;
        end if;    
      end if; 
     
    end loop;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_validations;
 
 procedure generate_dropdowns (
    pi_tpl_id         in r_templates.tpl_id%type
  , pi_sheet_num_main in pls_integer
  , pi_sheet_num_data in pls_integer  
  , pi_invalid        in boolean
  , pi_number_of_rows in r_templates.tpl_number_of_rows%type       
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_dropdowns';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_sheet_num_main', pi_sheet_num_main);
    logger.append_param(l_params, 'pi_sheet_num_data', pi_sheet_num_data);
    logger.append_param(l_params, 'pi_number_of_rows', pi_number_of_rows);
    logger.log('START', l_scope, null, l_params);

    -- iterate dropdowns for the current template
    for dds_group in (
      select hea_id, tph_sort_order, rownum, count
        from (
          select hea_id, tph_sort_order
            as tph_sort_order, count(*) as count
            from r_dropdowns
            join r_header
              on dds_hea_id = hea_id
            join template_header
              on tph_hea_id = hea_id
             and tph_tpl_id = pi_tpl_id
          group by hea_id, tph_sort_order
          order by tph_sort_order
      )
    )
    loop
      -- iterate options for the current dropdown
      for dds_option in (
        select dds_text, rownum
         from r_dropdowns
        where dds_hea_id = dds_group.hea_id
        order by dds_text
      )
      loop
        -- write options into the hidden file
        xlsx_builder_pkg.cell(
          p_col   => dds_group.rownum
        , p_row   => dds_option.rownum
        , p_value => dds_option.dds_text
        , p_sheet => pi_sheet_num_data
        );
      end loop;

      -- create dropdowns
      for i in 1..pi_number_of_rows
      loop
        xlsx_builder_pkg.list_validation (
          p_sqref_col => dds_group.tph_sort_order
        , p_sqref_row => gc_header_row + i
        , p_tl_col    => dds_group.rownum
        , p_tl_row    => 1
        , p_br_col    => dds_group.rownum
        , p_br_row    => dds_group.count
        , p_show_error => true
        , p_sheet     => pi_sheet_num_main
        , p_sheet_datasource => pi_sheet_num_data
        );
      end loop;
    end loop;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_dropdowns; 

 procedure generate_single_file (
    pi_tis_id        in template_import_status.tis_id%type
  , pi_tpl_id        in r_templates.tpl_id%type
  , pi_tpl_name      in r_templates.tpl_name%type
  , pi_per_id        in r_person.per_id%type
  , pi_per_firstname in r_person.per_firstname%type
  , pi_per_lastname  in r_person.per_lastname%type
  , pi_invalid       in boolean default false 
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_single_file';
    l_params logger.tab_param;

    l_blob                  blob;
    l_sheetname             varchar2(200 char);
    l_filename              files.fil_filename%type;
    l_fil_id                files.fil_id%type;
    l_tpl_ssp_id            r_templates.tpl_ssp_id%type;
    l_ssp_hash_value        r_spreadsheet_protection.ssp_hash_value%type; 
    l_ssp_salt_value        r_spreadsheet_protection.ssp_salt_value%type;

    l_sheet_num_main   pls_integer;
    l_sheet_num_hidden pls_integer;

    l_column_count pls_integer;
    l_number_of_rows pls_integer;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_tpl_name', pi_tpl_name);
    logger.append_param(l_params, 'pi_per_id', pi_per_id);
    logger.append_param(l_params, 'pi_per_firstname', pi_per_firstname);
    logger.append_param(l_params, 'pi_per_lastname', pi_per_lastname);
    logger.append_param(l_params, 'pi_invalid', pi_invalid);
    logger.log('START', l_scope, null, l_params);

    -- get number of rows
    l_number_of_rows := get_number_of_rows(pi_tpl_id);
    
    if pi_invalid then    
      l_filename := pi_tpl_name || '_' || pi_per_firstname  || '_' || pi_per_lastname || '_correction';
    else
      l_filename := pi_tpl_name || '_' || pi_per_firstname  || '_' || pi_per_lastname;
    end if;
    
    l_filename := replace(l_filename, ' ', '_') || '.xlsx';

    l_sheetname := pi_tpl_name;
    l_sheetname := replace(l_sheetname, ' ', '_');

    -- initially clear workbook
    xlsx_builder_pkg.clear_workbook;

    -- add sheets to workbook
    l_sheet_num_main   := xlsx_builder_pkg.new_sheet(l_sheetname);
    l_sheet_num_hidden := xlsx_builder_pkg.new_sheet('Dropdown Data', true);

    -- add sheetprotction to workbook
    select tpl_ssp_id 
      into l_tpl_ssp_id
      from r_templates
     where tpl_id = pi_tpl_id; 

    if l_tpl_ssp_id is not null then
      select ssp_hash_value, ssp_salt_value
        into l_ssp_hash_value, l_ssp_salt_value
        from r_spreadsheet_protection
       where ssp_id = l_tpl_ssp_id;

      --determine number of editable columns
      select count(distinct tph_sort_order)
        into l_column_count
        from template_header
       where tph_tpl_id = pi_tpl_id; 

      xlsx_builder_pkg.sheet_protection(p_ssp_hash_value => l_ssp_hash_value, 
                                        p_ssp_salt_value => l_ssp_salt_value,
                                        p_sheet          => l_sheet_num_main);

      xlsx_builder_pkg.protected_range(p_name     => 'range1', 
                                       p_tl_col   => 1,
                                       p_tl_row   => gc_data_row, 
                                       p_br_col   => l_column_count,
                                       p_br_row   => gc_data_row+l_number_of_rows, 
                                       p_sheet    => l_sheet_num_main);                                                             
    end if;

    xlsx_builder_pkg.cell(
      p_col => 1
    , p_row => 1
    , p_value => 'Template: ' || pi_tpl_name
    , p_fontid => xlsx_builder_pkg.get_font(p_name => 'Arial', p_fontsize => 10, p_rgb => 'ff000000', p_bold => true)
    , p_sheet => l_sheet_num_main
    );

    xlsx_builder_pkg.cell(
      p_col => 1
    , p_row => 2
    , p_value => 'Contact: ' || pi_per_firstname || ' ' || pi_per_lastname
    , p_fontid => xlsx_builder_pkg.get_font(p_name => 'Arial', p_fontsize => 10, p_rgb => 'ff000000', p_bold => true)
    , p_sheet => l_sheet_num_main
    );

    generate_abfragen (
      pi_tpl_id    => pi_tpl_id
    , pi_sheet_num => l_sheet_num_main
    , pi_invalid   => pi_invalid
    );
    
    generate_abfragegruppen (
      pi_tpl_id    => pi_tpl_id
    , pi_sheet_num => l_sheet_num_main
    , pi_invalid   => pi_invalid
    );
    
    generate_validations (
      pi_tpl_id    => pi_tpl_id
    , pi_tis_id    => pi_tis_id  
    , pi_sheet_num => l_sheet_num_main
    , pi_invalid   => pi_invalid
    , pi_number_of_rows => l_number_of_rows
    );

    generate_hidden_ids (
      pi_per_id    => pi_per_id
    , pi_tis_id    => pi_tis_id
    , pi_sheet_num => l_sheet_num_main
    );

    if pi_invalid then
      generate_answers (
        pi_tis_id    => pi_tis_id
      , pi_sheet_num => l_sheet_num_main
      );
    end if;

    generate_dropdowns (
      pi_tpl_id         => pi_tpl_id
    , pi_sheet_num_main => l_sheet_num_main
    , pi_sheet_num_data => l_sheet_num_hidden    
    , pi_invalid        => pi_invalid
    , pi_number_of_rows => l_number_of_rows
    );

    l_blob := xlsx_builder_pkg.finish();

    insert into files (
      fil_file
    , fil_filename
    , fil_mimetype
    , fil_session
    , fil_import_export
    ) values (
      l_blob
    , l_filename
    , 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    , apex_application.g_instance
    , 1
    ) returning fil_id into l_fil_id;

    if pi_tis_id > 0 then
        update template_import_status
           set tis_fil_id = l_fil_id
         where tis_id = pi_tis_id
        ;
    end if;

    if pi_invalid then
        update template_import_status
           set tis_shipping_status = 2
         where tis_id = pi_tis_id
        ;
    end if;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_single_file;

  procedure regenerate_invalid_rows (
    pi_tis_id in template_import_status.tis_id%type
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'regenerate_invalid_rows';
    l_params logger.tab_param;

    l_tpl_id        r_templates.tpl_id%type;
    l_tpl_name      r_templates.tpl_name%type;
    l_per_id        r_person.per_id%type;
    l_per_firstname r_person.per_firstname%type;
    l_per_lastname  r_person.per_lastname%type;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    -- query relevant data
    select tpl_id
         , tpl_name
         , per_id
         , per_firstname
         , per_lastname
      into l_tpl_id
         , l_tpl_name
         , l_per_id
         , l_per_firstname
         , l_per_lastname
      from template_import_status
      join r_person
        on tis_per_id = per_id
      join r_templates
        on tis_tpl_id = tpl_id
     where tis_id = pi_tis_id
    ;

    generate_single_file (
      pi_tis_id        => pi_tis_id
    , pi_tpl_id        => l_tpl_id
    , pi_tpl_name      => l_tpl_name
    , pi_per_id        => l_per_id
    , pi_per_firstname => l_per_firstname
    , pi_per_lastname  => l_per_lastname
    , pi_invalid       => true
    );

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end regenerate_invalid_rows;

end excel_gen;
/

create or replace package body file_import 
as 
 
  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.'; 

  type t_sheet_data_varray     is varray(300) of varchar2(4000); 
  type t_survey_answers_tab    is table of template_import_data%rowtype index by pls_integer; 

  cursor ref_cur is 
      select * 
      from table ( 
        apex_data_parser.parse ( 
          p_content         => (select fil_file from files where fil_id = 1) 
        ) 
      ) 
    ; 

  /* put each excel row in a varray which is iteratable and acessible over varray(i) */ 
  function get_varray ( 
    pi_r in ref_cur%rowtype 
  ) return t_sheet_data_varray 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_varray'; 
    l_params logger.tab_param; 

    l_varray_col_values t_sheet_data_varray; 
  begin 
    logger.log('START', l_scope, null, l_params); 

    l_varray_col_values := t_sheet_data_varray(  
      pi_r.col001, pi_r.col002, pi_r.col003, pi_r.col004, pi_r.col005, pi_r.col006, pi_r.col007, pi_r.col008 
    , pi_r.col009, pi_r.col010, pi_r.col011, pi_r.col012, pi_r.col013, pi_r.col014, pi_r.col015, pi_r.col016 
    , pi_r.col017, pi_r.col018, pi_r.col019, pi_r.col020, pi_r.col021, pi_r.col022, pi_r.col023, pi_r.col024 
    , pi_r.col025, pi_r.col026, pi_r.col027, pi_r.col028, pi_r.col029, pi_r.col030, pi_r.col031, pi_r.col032 
    , pi_r.col033, pi_r.col034, pi_r.col035, pi_r.col036, pi_r.col037, pi_r.col038, pi_r.col039, pi_r.col040 
    , pi_r.col041, pi_r.col042, pi_r.col043, pi_r.col044, pi_r.col045, pi_r.col046, pi_r.col047, pi_r.col048 
    , pi_r.col049, pi_r.col050, pi_r.col051, pi_r.col052, pi_r.col053, pi_r.col054, pi_r.col055, pi_r.col056 
    , pi_r.col057, pi_r.col058, pi_r.col059, pi_r.col060, pi_r.col061, pi_r.col062, pi_r.col063, pi_r.col064 
    , pi_r.col065, pi_r.col066, pi_r.col067, pi_r.col068, pi_r.col069, pi_r.col070, pi_r.col071, pi_r.col072 
    , pi_r.col073, pi_r.col074, pi_r.col075, pi_r.col076, pi_r.col077, pi_r.col078, pi_r.col079, pi_r.col080 
    , pi_r.col081, pi_r.col082, pi_r.col083, pi_r.col084, pi_r.col085, pi_r.col086, pi_r.col087, pi_r.col088 
    , pi_r.col089, pi_r.col090, pi_r.col091, pi_r.col092, pi_r.col093, pi_r.col094, pi_r.col095, pi_r.col096 
    , pi_r.col097, pi_r.col098, pi_r.col099, pi_r.col100, pi_r.col101, pi_r.col102, pi_r.col103, pi_r.col104 
    , pi_r.col105, pi_r.col106, pi_r.col107, pi_r.col108, pi_r.col109, pi_r.col110, pi_r.col111, pi_r.col112 
    , pi_r.col113, pi_r.col114, pi_r.col115, pi_r.col116, pi_r.col117, pi_r.col118, pi_r.col119, pi_r.col120 
    , pi_r.col121, pi_r.col122, pi_r.col123, pi_r.col124, pi_r.col125, pi_r.col126, pi_r.col127, pi_r.col128 
    , pi_r.col129, pi_r.col130, pi_r.col131, pi_r.col132, pi_r.col133, pi_r.col134, pi_r.col135, pi_r.col136 
    , pi_r.col137, pi_r.col138, pi_r.col139, pi_r.col140, pi_r.col141, pi_r.col142, pi_r.col143, pi_r.col144 
    , pi_r.col145, pi_r.col146, pi_r.col147, pi_r.col148, pi_r.col149, pi_r.col150, pi_r.col151, pi_r.col152 
    , pi_r.col153, pi_r.col154, pi_r.col155, pi_r.col156, pi_r.col157, pi_r.col158, pi_r.col159, pi_r.col160 
    , pi_r.col161, pi_r.col162, pi_r.col163, pi_r.col164, pi_r.col165, pi_r.col166, pi_r.col167, pi_r.col168 
    , pi_r.col169, pi_r.col170, pi_r.col171, pi_r.col172, pi_r.col173, pi_r.col174, pi_r.col175, pi_r.col176 
    , pi_r.col177, pi_r.col178, pi_r.col179, pi_r.col180, pi_r.col181, pi_r.col182, pi_r.col183, pi_r.col184 
    , pi_r.col185, pi_r.col186, pi_r.col187, pi_r.col188, pi_r.col189, pi_r.col190, pi_r.col191, pi_r.col192 
    , pi_r.col193, pi_r.col194, pi_r.col195, pi_r.col196, pi_r.col197, pi_r.col198, pi_r.col199, pi_r.col200 
    , pi_r.col201, pi_r.col202, pi_r.col203, pi_r.col204, pi_r.col205, pi_r.col206, pi_r.col207, pi_r.col208 
    , pi_r.col209, pi_r.col210, pi_r.col211, pi_r.col212, pi_r.col213, pi_r.col214, pi_r.col215, pi_r.col216 
    , pi_r.col217, pi_r.col218, pi_r.col219, pi_r.col220, pi_r.col221, pi_r.col222, pi_r.col223, pi_r.col224 
    , pi_r.col225, pi_r.col226, pi_r.col227, pi_r.col228, pi_r.col229, pi_r.col230, pi_r.col231, pi_r.col232 
    , pi_r.col233, pi_r.col234, pi_r.col235, pi_r.col236, pi_r.col237, pi_r.col238, pi_r.col239, pi_r.col240 
    , pi_r.col241, pi_r.col242, pi_r.col243, pi_r.col244, pi_r.col245, pi_r.col246, pi_r.col247, pi_r.col248 
    , pi_r.col249, pi_r.col250, pi_r.col251, pi_r.col252, pi_r.col253, pi_r.col254, pi_r.col255, pi_r.col256 
    , pi_r.col257, pi_r.col258, pi_r.col259, pi_r.col260, pi_r.col261, pi_r.col262, pi_r.col263, pi_r.col264 
    , pi_r.col265, pi_r.col266, pi_r.col267, pi_r.col268, pi_r.col269, pi_r.col270, pi_r.col271, pi_r.col272 
    , pi_r.col273, pi_r.col274, pi_r.col275, pi_r.col276, pi_r.col277, pi_r.col278, pi_r.col279, pi_r.col280 
    , pi_r.col281, pi_r.col282, pi_r.col283, pi_r.col284, pi_r.col285, pi_r.col286, pi_r.col287, pi_r.col288 
    , pi_r.col289, pi_r.col290, pi_r.col291, pi_r.col292, pi_r.col293, pi_r.col294, pi_r.col295, pi_r.col296 
    , pi_r.col297, pi_r.col298, pi_r.col299, pi_r.col300 
    ); 

    logger.log('END', l_scope); 

    return l_varray_col_values; 
  exception 
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end get_varray; 

  function remove_empty_spaces( 
    pi_string in varchar2 
  ) return varchar2 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'remove_empty_spaces'; 
    l_params logger.tab_param; 

    l_return varchar2(4000 char); 
  begin 
    l_return := replace( 
                  replace ( 
                    replace (pi_string, CHR(13)) 
                  , CHR(10) 
                  ) 
                  , ' ' 
    ); 

    return l_return; 
  exception 
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end; 

  procedure log_processing_error ( 
    pi_message  in import_errors.ier_message%type 
  , pi_filename in import_errors.ier_filename%type 
  , pi_row_id   in import_errors.ier_row_id%type   default null 
  , pi_header   in import_errors.ier_header%type  default null 
  ) 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'log_processing_error'; 
    l_params logger.tab_param; 
  begin 
    logger.append_param(l_params, 'pi_message', pi_message); 
    logger.append_param(l_params, 'pi_filename', pi_filename); 
    logger.append_param(l_params, 'pi_row_id', pi_row_id); 
    logger.append_param(l_params, 'pi_header', pi_header); 
    logger.log('START', l_scope, null, l_params); 

    insert into import_errors ( 
      ier_message 
    , ier_filename 
    , ier_row_id 
    , ier_header 
    , ier_session 
    ) values ( 
      pi_message 
    , pi_filename 
    , pi_row_id 
    , pi_header 
    , apex_application.g_instance 
    ); 

    logger.log_warn(pi_message, l_scope, null, l_params); 

    logger.log('END', l_scope); 
  exception 
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end log_processing_error; 


  procedure validate_required_ids ( 
    pi_per_id          in r_person.per_id%type 
  , pi_tis_id          in template_import_status.tis_id%type 
  , pi_filename        in import_errors.ier_filename%type 
  , pi_row_id          in import_errors.ier_row_id%type 
  , pio_error_occurred in out nocopy boolean  
  ) 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'validate_required_ids'; 
    l_params logger.tab_param; 
  begin 
    logger.append_param(l_params, 'pi_per_id', pi_per_id); 
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id); 
    logger.append_param(l_params, 'pi_filename', pi_filename); 
    logger.append_param(l_params, 'pi_row_id', pi_row_id); 
    logger.log('START', l_scope, null, l_params); 

    if pi_per_id is null then 
      pio_error_occurred := true; 
      log_processing_error( 
        pi_message  => 'Person ID can not imported' 
      , pi_filename => pi_filename 
      , pi_row_id   => pi_row_id 
      ); 
    end if; 

    if pi_tis_id is null then 
      pio_error_occurred := true; 
      log_processing_error( 
        pi_message  => 'template_import_status ID can not imported' 
      , pi_filename => pi_filename 
      , pi_row_id   => pi_row_id 
      ); 
    end if; 

    logger.log('END', l_scope); 
  exception 
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end validate_required_ids; 


  procedure get_tis_id ( 
    pi_tpl_id          in r_templates.tpl_id%type 
  , pi_per_id          in r_person.per_id%type 
  , pi_filename        in import_errors.ier_filename%type 
  , po_tis_id          out nocopy template_import_status.tis_id%type 
  , pio_error_occurred in out nocopy boolean 
  ) 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_tis_id'; 
    l_params logger.tab_param; 
    l_count_no_data_found number;
  begin 
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id); 
    logger.append_param(l_params, 'pi_per_id', pi_per_id); 
    logger.append_param(l_params, 'pi_filename', pi_filename); 
    logger.log('START', l_scope, null, l_params); 

    -- validate input parameters not null 
    if    pi_tpl_id is null  
       or pi_per_id is null  
    then 
      pio_error_occurred := true; 
      log_processing_error( 
        pi_message  => 'Required values Survey ID or contact person ID not available' 
      , pi_filename => pi_filename 
      ); 
    else 
      l_count_no_data_found := 1;

        -- get tis_id 
        select tis_id 
          into po_tis_id 
          from template_import_status 
         where tis_per_id = pi_per_id 
           and tis_tpl_id = pi_tpl_id
        ; 

        -- validate tis_id not null 
        if po_tis_id is null then 
          pio_error_occurred := true; 
          log_processing_error( 
            pi_message  => 'Survey for contact persons could not be found' 
          , pi_filename => pi_filename 
          ); 
        end if; 
    end if; 

    logger.log('END', l_scope); 
  exception 
    when no_data_found then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);          
        if l_count_no_data_found = 1 then    
          raise_application_error(-20002,'Survey for contact persons could not be found!');
        end if;
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end get_tis_id; 


  procedure prepare_answer_write ( 
    pi_answer                in template_import_data.tid_text%type 
  , pi_header                in r_header.hea_text%type 
  , pi_tis_id                in template_import_status.tis_id%type 
  , pi_row_id                in template_import_data.tid_row_id%type 
  , pi_tpl_id                in r_templates.tpl_id%type 
  , pi_filename              in import_errors.ier_filename%type 
  , pio_error_occurred       in out nocopy boolean 
  , po_survey_answers_row    out nocopy template_import_data%rowtype 
  , pi_column_nr             in number
  ) 
  as 
    l_scope logger_logs.scope%type := gc_scope_prefix || 'prepare_answer_write'; 
    l_params logger.tab_param; 

    l_tph_id template_header.tph_id%type; 
    l_count pls_integer; 
    l_answer template_import_data.tid_text%type;

    l_column_nr number;
  begin 
    logger.append_param(l_params, 'pi_answer', pi_answer); 
    logger.append_param(l_params, 'pi_header', pi_header); 
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id); 
    logger.append_param(l_params, 'pi_row_id', pi_row_id); 
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id); 
    logger.append_param(l_params, 'pi_filename', pi_filename); 
    logger.append_param(l_params, 'pi_column_nr', pi_column_nr); 
    logger.log('START', l_scope, null, l_params); 

    if pi_header = 'Validation' then
        l_column_nr := 282;
    elsif pi_header = 'Annotation' then     
        l_column_nr := 280;
    else 
        l_column_nr := pi_column_nr;
    end if;    


    select count(*) 
      into l_count 
      from template_header 
      join r_header  
        on hea_id = tph_hea_id 
       and remove_empty_spaces(hea_text) = remove_empty_spaces(pi_header) 
       and tph_sort_order = l_column_nr
     where tph_tpl_id = pi_tpl_id 
    ; 

    if l_count = 1 then 
      select tph_id 
        into l_tph_id
        from template_header 
        join r_header  
          on hea_id = tph_hea_id 
         and remove_empty_spaces(hea_text) = remove_empty_spaces(pi_header) 
         and tph_sort_order = l_column_nr
       where tph_tpl_id = pi_tpl_id 
      ; 

      l_answer := pi_answer;

      po_survey_answers_row.tid_row_id := pi_row_id; 
      po_survey_answers_row.tid_tis_id := pi_tis_id; 
      po_survey_answers_row.tid_tph_id := l_tph_id; 
      po_survey_answers_row.tid_text   := l_answer; 
    else 
        pio_error_occurred := true; 
        log_processing_error( 
          pi_message  => 'r_header could not be found => ' || pi_header 
        , pi_filename => pi_filename 
        , pi_row_id   => pi_row_id 
        , pi_header   => pi_header 
        ); 
    end if; 

    logger.log('END', l_scope); 
  exception 
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end prepare_answer_write; 


  procedure read_file( 
    pi_tpl_id         in  r_templates.tpl_id%type 
  , pi_fil_id         in  files.fil_id%type 
  , pi_filename       in  files.fil_filename%type 
  , po_error_occurred out nocopy boolean 
  ) 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'read_file'; 
    l_params logger.tab_param; 

    l_per_id r_person.per_id%type; 
    l_tis_id template_import_status.tis_id%type; 

    l_header_row  t_sheet_data_varray; 
    l_current_row t_sheet_data_varray; 

    l_row_id pls_integer; 
    l_row_count pls_integer; 

    l_current_answer   template_import_data.tid_text%type; 
    l_current_question r_header.hea_text%type; 

    l_error_occurred        boolean := false; 

    l_insert_count          pls_integer := 1; 
    l_update_count          pls_integer := 1; 
    l_column_count          pls_integer := 1; 
    l_check_korrektur       varchar2(100);
    l_column                varchar2(100); 

    l_insert_tab t_survey_answers_tab; 
    l_update_tab t_survey_answers_tab; 
    l_update_fehlerhaft_tph_id template_import_data.tid_text%type; 
    l_count_update_error_tph_id number; 
  begin 
    logger.append_param(l_params, 'pi_filename', pi_filename); 
    logger.append_param(l_params, 'pi_fil_id', pi_fil_id); 
    logger.log('START', l_scope, null, l_params); 

    -- Zelleninhalt A8 auslesen um prüfen zu können ob es eine Korrekturdatei ist  
    select col001
      into l_check_korrektur
      from table ( 
        apex_data_parser.parse ( 
          p_content         => (select fil_file from files where fil_id = pi_fil_id) 
        , p_add_headers_row => 'N' 
        , p_xlsx_sheet_name => 'sheet1.xml' 
        , p_max_rows        => 500 
        , p_file_name       => pi_filename  
        ) 
      )
      where line_number = excel_gen.gc_header_row;    

    select listagg(tph_sort_order, ':') within group (order by tph_sort_order)  
      into l_column   
      from template_header
      join r_header 
        on hea_id = tph_hea_id
      join r_validation
        on hea_val_id = val_id
      left join template_header_validations
             on thv_tph_id = tph_id  
     where tph_tpl_id = pi_tpl_id 
       and val_id = 4       
    order by tph_sort_order;
  
 for rec in ( 
   select * 
   from table ( 
  apex_data_parser.parse ( 
    p_content         => (select fil_file from files where fil_id = pi_fil_id) 
  , p_add_headers_row => 'N' 
  , p_xlsx_sheet_name => 'sheet1.xml' 
  , p_max_rows        => 500 
  , p_file_name       => pi_filename 
  ) 
   )  
   where not (line_number > excel_gen.gc_header_row and
  case when 1  in (select column_value from apex_string.split(l_column,':')) then null else col001 end ||
  case when 2  in (select column_value from apex_string.split(l_column,':')) then null else col002 end ||
  case when 3  in (select column_value from apex_string.split(l_column,':')) then null else col003 end ||
  case when 4  in (select column_value from apex_string.split(l_column,':')) then null else col004 end ||
  case when 5  in (select column_value from apex_string.split(l_column,':')) then null else col005 end ||
  case when 6  in (select column_value from apex_string.split(l_column,':')) then null else col006 end ||
  case when 7  in (select column_value from apex_string.split(l_column,':')) then null else col007 end ||
  case when 8  in (select column_value from apex_string.split(l_column,':')) then null else col008 end ||
  case when 9  in (select column_value from apex_string.split(l_column,':')) then null else col009 end ||
  case when 10 in (select column_value from apex_string.split(l_column,':')) then null else col010 end ||
  case when 11 in (select column_value from apex_string.split(l_column,':')) then null else col011 end ||
  case when 12 in (select column_value from apex_string.split(l_column,':')) then null else col012 end ||
  case when 13 in (select column_value from apex_string.split(l_column,':')) then null else col013 end ||
  case when 14 in (select column_value from apex_string.split(l_column,':')) then null else col014 end ||
  case when 15 in (select column_value from apex_string.split(l_column,':')) then null else col015 end ||
  case when 16 in (select column_value from apex_string.split(l_column,':')) then null else col016 end ||
  case when 17 in (select column_value from apex_string.split(l_column,':')) then null else col017 end ||
  case when 18 in (select column_value from apex_string.split(l_column,':')) then null else col018 end ||
  case when 19 in (select column_value from apex_string.split(l_column,':')) then null else col019 end ||
  case when 20 in (select column_value from apex_string.split(l_column,':')) then null else col020 end ||
  case when 21 in (select column_value from apex_string.split(l_column,':')) then null else col021 end ||
  case when 22 in (select column_value from apex_string.split(l_column,':')) then null else col022 end ||
  case when 23 in (select column_value from apex_string.split(l_column,':')) then null else col023 end ||
  case when 24 in (select column_value from apex_string.split(l_column,':')) then null else col024 end ||
  case when 25 in (select column_value from apex_string.split(l_column,':')) then null else col025 end ||
  case when 26 in (select column_value from apex_string.split(l_column,':')) then null else col026 end ||
  case when 27 in (select column_value from apex_string.split(l_column,':')) then null else col027 end ||
  case when 28 in (select column_value from apex_string.split(l_column,':')) then null else col028 end ||
  case when 29 in (select column_value from apex_string.split(l_column,':')) then null else col029 end ||
  case when 30 in (select column_value from apex_string.split(l_column,':')) then null else col030 end ||
  case when 31 in (select column_value from apex_string.split(l_column,':')) then null else col031 end ||
  case when 32 in (select column_value from apex_string.split(l_column,':')) then null else col032 end ||
  case when 33 in (select column_value from apex_string.split(l_column,':')) then null else col033 end ||
  case when 34 in (select column_value from apex_string.split(l_column,':')) then null else col034 end ||
  case when 35 in (select column_value from apex_string.split(l_column,':')) then null else col035 end ||
  case when 36 in (select column_value from apex_string.split(l_column,':')) then null else col036 end ||
  case when 37 in (select column_value from apex_string.split(l_column,':')) then null else col037 end ||
  case when 38 in (select column_value from apex_string.split(l_column,':')) then null else col038 end ||
  case when 39 in (select column_value from apex_string.split(l_column,':')) then null else col039 end ||
  case when 40 in (select column_value from apex_string.split(l_column,':')) then null else col040 end ||
  case when 41 in (select column_value from apex_string.split(l_column,':')) then null else col041 end ||
  case when 42 in (select column_value from apex_string.split(l_column,':')) then null else col042 end ||
  case when 43 in (select column_value from apex_string.split(l_column,':')) then null else col043 end ||
  case when 44 in (select column_value from apex_string.split(l_column,':')) then null else col044 end ||
  case when 45 in (select column_value from apex_string.split(l_column,':')) then null else col045 end is null)     
 ) 
 loop 
      l_column_count := 1;   
   case  
  when rec.line_number = 1 then 
    l_current_row := get_varray(rec); 

    l_per_id := l_current_row(excel_gen.gc_ids_col1); 
    logger.log_info('imported per_id =>' || l_per_id); 

    l_tis_id := l_current_row(excel_gen.gc_ids_col2); 
    logger.log_info('imported tis_id =>' || l_tis_id); 

    validate_required_ids ( 
      pi_per_id          => l_per_id 
    , pi_tis_id          => l_tis_id  
    , pi_filename        => pi_filename 
    , pi_row_id          => rec.line_number 
    , pio_error_occurred => l_error_occurred 
    ); 

  update (
   select tis_deadline from template_import_status
       join r_person on tis_per_id = per_id
       join r_templates on tis_tpl_id = tpl_id
      where tis_id = l_tis_id) pss
        set pss.tis_deadline = NULL;

  update (
   select tis_sts_id from template_import_status
     join r_person on tis_per_id = per_id
     join r_templates on tis_tpl_id = tpl_id
    where tis_id = l_tis_id) pss  
      set pss.tis_sts_id = 2;

        update (
     select tis_shipping_status from template_import_status
       join r_person on tis_per_id = per_id
       join r_templates on tis_tpl_id = tpl_id
      where tis_id = l_tis_id) pss 
        set pss.tis_shipping_status = 2;

  when rec.line_number = excel_gen.gc_header_row then 
    l_header_row := get_varray(rec); 
  when rec.line_number > excel_gen.gc_header_row then 
    l_current_row := get_varray(rec); 
    if l_current_row(excel_gen.gc_ids_col1) is null then 
   l_row_id := tid_row_seq.nextval; 
    end if; 

    for i in 1..l_current_row.last 
    loop 
   if l_header_row(i) is not null then 
     -- hidden id to match corrected answer  
     if l_current_row(excel_gen.gc_ids_col1) is not null then 
    prepare_answer_write ( 
      pi_answer                => l_current_row(i) 
    , pi_header                => l_header_row(i) 
    , pi_tis_id                => l_tis_id 
    , pi_row_id                => l_current_row(excel_gen.gc_ids_col1) 
    , pi_tpl_id                => pi_tpl_id 
    , pi_filename              => pi_filename 
    , pio_error_occurred       => l_error_occurred 
    , po_survey_answers_row    => l_update_tab(l_update_count)
    , pi_column_nr             => l_column_count    
    ); 
    l_column_count := l_column_count +1;

    l_update_count := l_update_count + 1; 
     else 
    prepare_answer_write ( 
      pi_answer                => l_current_row(i) 
    , pi_header               => l_header_row(i) 
    , pi_tis_id                => l_tis_id 
    , pi_row_id                => l_row_id 
    , pi_tpl_id                => pi_tpl_id 
    , pi_filename              => pi_filename 
    , pio_error_occurred       => l_error_occurred 
    , po_survey_answers_row    => l_insert_tab(l_insert_count) 
    , pi_column_nr             => l_column_count    
    ); 
    l_column_count := l_column_count +1;
    l_insert_count := l_insert_count + 1; 
     end if;  
   end if; 
    end loop;           
  else 
    null;   
      end case;           
 end loop;     

    -- insert / update only when file has no errors 
    if not l_error_occurred then 
      -- merge into unfortunately not possible from plsql table       
      forall i in 1..l_insert_tab.count 
        insert into template_import_data values l_insert_tab(i)         
      ; 

      forall i in 1..l_update_tab.count 

        update template_import_data  
           set tid_text   = l_update_tab(i).tid_text 
         where tid_tis_id = l_update_tab(i).tid_tis_id 
           and tid_tph_id = l_update_tab(i).tid_tph_id 
           and tid_row_id = l_update_tab(i).tid_row_id 
      ; 

      for i in 1..l_update_tab.count loop

      select count(tid_tph_id) into l_count_update_error_tph_id from template_import_data 
        join template_header on tid_tph_id = tph_id 
      where tid_text = '1' 
        and tid_tis_id = l_update_tab(i).tid_tis_id 
        and tid_row_id = l_update_tab(i).tid_row_id 
        and tph_hea_id = 9999; 

      if l_count_update_error_tph_id = 1 then 

      -- Status zurücksetzen 
      select tid_tph_id into l_update_fehlerhaft_tph_id from template_import_data 
        join template_header on tid_tph_id = tph_id 
      where tid_text = '1' 
        and tid_tis_id = l_update_tab(i).tid_tis_id 
        and tid_row_id = l_update_tab(i).tid_row_id 
        and tph_hea_id = 9999; 

      update template_import_data  
        set tid_text = '0'
      where tid_tis_id = l_update_tab(i).tid_tis_id 
        and tid_tph_id = l_update_fehlerhaft_tph_id 
        and tid_row_id = l_update_tab(i).tid_row_id; 

      end if; 

      end loop;     

    -- Plausibilitaetspruefung starten
    validation_api.validation(l_tis_id); 

    end if; 

    <<end_case>>
    null;  

    po_error_occurred := l_error_occurred;

    logger.log('END', l_scope); 
  exception 
    when others then 
      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end read_file; 


  procedure upload_file ( 
    pi_collection_name in  apex_collections.collection_name%type default 'DROPZONE_UPLOAD' 
  , pi_tpl_id          in  r_templates.tpl_id%type 
  , po_error_occurred  out nocopy number 
  ) 
  as 
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'upload_file'; 
    l_params logger.tab_param; 

    l_fil_id files.fil_id%type; 

    l_file_error_occurred boolean; 
    l_any_error_occurred  boolean; 
  begin 
    logger.append_param(l_params, 'pi_collection_name', pi_collection_name); 
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id); 
    logger.log('START', l_scope, null, l_params); 

    for rec in ( 
      select c001                        as fil_filename 
           , c002                        as fil_mimetype 
           , apex_application.g_instance as fil_session 
           , blob001                     as fil_file 
           , 0                           as fil_import_export 
        from apex_collections 
       where collection_name = pi_collection_name 
    ) 
    loop 
      insert into files (  
        fil_filename 
      , fil_mimetype 
      , fil_session 
      , fil_file 
      , fil_import_export 
      , fil_import_completed    
      ) values (  
        rec.fil_filename 
      , rec.fil_mimetype 
      , rec.fil_session 
      , rec.fil_file 
      , rec.fil_import_export 
      , 0    
      ) returning fil_id into l_fil_id 
      ; 

      read_file( 
        pi_tpl_id         => pi_tpl_id 
      , pi_fil_id         => l_fil_id 
      , pi_filename       => rec.fil_filename 
      , po_error_occurred => l_file_error_occurred 
      ); 

      if l_file_error_occurred then 
        l_any_error_occurred := true; 
      else
        update files
           set fil_import_completed = 1
         where fil_id = l_fil_id;  
      end if; 
    end loop; 

    -- delete files from collection after insert 
    apex_collection.truncate_collection ( 
      p_collection_name => pi_collection_name 
    ); 

    if l_any_error_occurred then 
      po_error_occurred := 1; 
    else 
      po_error_occurred := 0; 
    end if; 

    logger.log('END', l_scope); 
  exception 
    when others then 
      apex_collection.truncate_collection ( 
        p_collection_name => pi_collection_name 
      ); 

      logger.log_error('Unhandled Exception', l_scope, null, l_params); 
      raise; 
  end upload_file; 

end file_import;
/

create or replace package body master_api as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  function get_faulty_id
    return r_header.hea_id%type deterministic result_cache
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_faulty_id';
    l_params logger.tab_param;

    l_faulty_id r_header.hea_id%type;
  begin
    select hea_id
      into l_faulty_id
      from r_header
     where hea_text = 'Faulty'
    ;

    return l_faulty_id;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_faulty_id;

  function get_annotation_id
    return r_header.hea_id%type deterministic result_cache
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_annotation_id';
    l_params logger.tab_param;

    l_annotation_id r_header.hea_id%type;
  begin
    select hea_id
      into l_annotation_id
      from r_header
     where hea_text = 'Annotation'
    ;

    return l_annotation_id;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_annotation_id;

  function get_feedback_id
    return r_header.hea_id%type deterministic result_cache
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_feedback_id';
    l_params logger.tab_param;

    l_feedback_id r_header.hea_id%type;
  begin
    select hea_id
      into l_feedback_id
      from r_header
     where hea_text = 'Feedback'
    ;

    return l_feedback_id;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_feedback_id;

  function get_validation_id
    return r_header.hea_id%type deterministic result_cache
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_validation_id';
    l_params logger.tab_param;

    l_validation_id r_header.hea_id%type;
  begin
    select hea_id
      into l_validation_id
      from r_header
     where hea_text = 'Validation'
    ;

    return l_validation_id;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_validation_id;

end master_api;
/  

create or replace package body p00025_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure create_new_template (
    pi_collection_name in  apex_collections.collection_name%type default 'CREATE_TEMPLATE'       
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'create_new_template';
    l_params logger.tab_param;
    l_tpl_id r_templates.tpl_id%type;
    l_tph_id template_header.tph_id%type;
  begin
    logger.append_param(l_params, 'pi_collection_name', pi_collection_name);
    logger.log('START', l_scope, null, l_params);

    for rec in ( 
        select seq_id as tph_sort_order, c001 as tpl_name, c002 as tph_hea_id, 
               c003 as hea_text, replace(c004,'#','ff') as tph_xlsx_font_color, replace(c005,'#','ff') as tph_xlsx_background_color,
               c006 as tpl_deadline, c007 as tpl_number_of_rows, c008 as tph_thg_id, c009 as thv_formula1, c010 as thv_formula2,
               c011 as ssp_id
          from apex_collections 
         where collection_name = 'CREATE_TEMPLATE' 
      order by seq_id
    ) 
    loop 

    if l_tpl_id is null then
        insert into r_templates 
        (tpl_name, tpl_deadline, tpl_number_of_rows, tpl_ssp_id) 
        VALUES (rec.tpl_name, nvl(rec.tpl_deadline,7), nvl(rec.tpl_number_of_rows,100), rec.ssp_id)
        RETURNING tpl_id into l_tpl_id;
        
        insert into template_automations
        (tpa_tpl_id, tpa_enabled)
        VALUES (l_tpl_id, 0);
    end if;

    insert into template_header 
    (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order, tph_thg_id)
    VALUES (l_tpl_id, rec.tph_hea_id, rec.tph_xlsx_background_color, rec.tph_xlsx_font_color, rec.tph_sort_order, rec.tph_thg_id)
    RETURNING tph_id into l_tph_id;
    
    if rec.thv_formula1 is not null or rec.thv_formula2 is not null then
        insert into template_header_validations
        (thv_tph_id, thv_formula1, thv_formula2)
        VALUES (l_tph_id, rec.thv_formula1, rec.thv_formula2);
    end if;

    end loop;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end create_new_template;

  procedure create_preview (
    pi_collection_name in  apex_collections.collection_name%type default 'CREATE_TEMPLATE'       
  )
  as
    l_scope     logger_logs.scope%type := gc_scope_prefix || 'create_preview';
    l_params    logger.tab_param;
    l_tpl_id    r_templates.tpl_id%type;
    l_tpl_name  r_templates.tpl_name%type;
    l_tph_id    template_header.tph_id%type;
  begin
    logger.append_param(l_params, 'pi_collection_name', pi_collection_name);
    logger.log('START', l_scope, null, l_params);

    for rec in ( 
        select seq_id as tph_sort_order, c001 as tpl_name, c002 as tph_hea_id, 
               c003 as hea_text, replace(c004,'#','ff') as tph_xlsx_font_color, replace(c005,'#','ff') as tph_xlsx_background_color,
               c006 as tpl_deadline, c007 as tpl_number_of_rows, c008 as tph_thg_id, c009 as thv_formula1, c010 as thv_formula2,
               c011 as ssp_id
          from apex_collections 
         where collection_name = 'CREATE_TEMPLATE' 
      order by seq_id
    ) 
    loop 

    if l_tpl_id is null then
        insert into r_templates 
        (tpl_name, tpl_deadline, tpl_number_of_rows, tpl_ssp_id) 
        VALUES (rec.tpl_name, nvl(rec.tpl_deadline,7), nvl(rec.tpl_number_of_rows,100), rec.ssp_id)
        RETURNING tpl_id, tpl_name into l_tpl_id, l_tpl_name;
        
        insert into template_automations
        (tpa_tpl_id, tpa_enabled)
        VALUES (l_tpl_id, 0);
    end if;

    insert into template_header 
    (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order, tph_thg_id)
    VALUES (l_tpl_id, rec.tph_hea_id, rec.tph_xlsx_background_color, rec.tph_xlsx_font_color, rec.tph_sort_order, rec.tph_thg_id)
    RETURNING tph_id into l_tph_id;
    
    if rec.thv_formula1 is not null or rec.thv_formula2 is not null then
        insert into template_header_validations
        (thv_tph_id, thv_formula1, thv_formula2)
        VALUES (l_tph_id, rec.thv_formula1, rec.thv_formula2);
    end if;  

    end loop;

    excel_gen.generate_single_file (
      pi_tis_id         => 0
    , pi_tpl_id         => l_tpl_id
    , pi_tpl_name       => l_tpl_name
    , pi_per_id         => 123456789
    , pi_per_firstname  => 'sample'
    , pi_per_lastname   => 'file'
    );

    -- delete preview data
    delete template_automations where tpa_tpl_id = l_tpl_id;
    delete template_header_validations where thv_tph_id in (select tph_id from template_header where tph_tpl_id = l_tpl_id);
    delete template_header where tph_tpl_id = l_tpl_id;
    delete r_templates where tpl_id = l_tpl_id;
    
    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end create_preview;    

end p00025_api;
/

create or replace package body p00027_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure save_header (
    pi_hea_text         in r_header.hea_text%type
  , pi_hea_xlsx_width   in r_header.hea_xlsx_width%type
  , pi_hea_val_id       in r_header.hea_val_id%type
  , pi_dropdown_values  in varchar2        
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'save_header';
    l_params logger.tab_param;
    l_hea_id r_header.hea_id%type;
  begin
    logger.append_param(l_params, 'pi_hea_text', pi_hea_text);
    logger.append_param(l_params, 'pi_hea_xlsx_width', pi_hea_xlsx_width);
    logger.append_param(l_params, 'pi_hea_val_id', pi_hea_val_id);
    logger.append_param(l_params, 'pi_dropdown_values', pi_dropdown_values);
    logger.log('START', l_scope, null, l_params);

    insert into r_header (HEA_TEXT, HEA_XLSX_WIDTH, HEA_VAL_ID)
    values (pi_hea_text, pi_hea_xlsx_width, pi_hea_val_id)
    returning hea_id into l_hea_id;

    insert into r_dropdowns (DDS_HEA_ID, DDS_TEXT)
    select l_hea_id, column_value From TABLE(apex_string.split(pi_dropdown_values,':'));

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end save_header;
  
end p00027_api;
/

create or replace package body p00028_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure save_header_group (
    pi_thg_text                   in template_header_group.thg_text%type
  , pi_thg_xlsx_background_color  in template_header_group.thg_xlsx_background_color%type
  , pi_thg_xlsx_font_color        in template_header_group.thg_xlsx_font_color%type      
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'save_header';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'pi_thg_text', pi_thg_text);
    logger.append_param(l_params, 'pi_thg_xlsx_background_color', pi_thg_xlsx_background_color);
    logger.append_param(l_params, 'pi_thg_xlsx_font_color', pi_thg_xlsx_font_color);
    logger.log('START', l_scope, null, l_params);

    insert into template_header_group (thg_text, thg_xlsx_background_color, thg_xlsx_font_color)
    values (pi_thg_text, replace(pi_thg_xlsx_background_color,'#','ff'), replace(pi_thg_xlsx_font_color,'#','ff'));

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end save_header_group;
  
end p00028_api;
/

create or replace package body p00030_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure generate_excel_file ( 
    pi_tpl_id in r_templates.tpl_id%type
  , pi_per_id in r_person.per_id%type    
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'generate_excel_file';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_per_id', pi_per_id);
    logger.log('START', l_scope, null, l_params);

    -- remove old files
      update template_import_status
         set tis_fil_id = null
       where tis_fil_id in (      
        select tis_fil_id
          from template_import_status
         where tis_fil_id is not null
           and tis_tpl_id = pi_tpl_id
           and tis_per_id = pi_per_id 
      );

      logger.log_info('update => ' || sql%rowcount);

      delete from files where fil_id not in (
        select distinct tis_fil_id
          from template_import_status
      );

      logger.log_info('delete => ' || sql%rowcount);

    for rec in (
      select tis_id
           , tpl_id
           , tpl_name
           , per_id
           , per_firstname
           , per_lastname
        from template_import_status
        join r_templates
          on tis_tpl_id = tpl_id
        join r_person
          on tis_per_id = per_id
       where tis_tpl_id = pi_tpl_id
         and per_id = pi_per_id
    )
    loop    
      excel_gen.generate_single_file (
        pi_tis_id        => rec.tis_id
      , pi_tpl_id        => rec.tpl_id
      , pi_tpl_name      => rec.tpl_name
      , pi_per_id        => rec.per_id
      , pi_per_firstname => rec.per_firstname
      , pi_per_lastname  => rec.per_lastname
      );

    end loop;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end generate_excel_file;

  procedure send_mail(
    pi_choice       in pls_integer,
    pi_app_id       in pls_integer,
    pi_app_page_id  in pls_integer,
    pi_static_id    in varchar2
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'send_mail';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'pi_choice', pi_choice);
    logger.log('START', l_scope, null, l_params);

    if pi_choice = 1 then

      email_pkg.new_template(
        p_App_ID    => pi_app_id, 
        p_Page_ID   => pi_app_page_id, 
        p_static_id => pi_static_id
      );

    elsif pi_choice = 2 then

      email_pkg.corrected_template(
        p_App_ID    => pi_app_id, 
        p_Page_ID   => pi_app_page_id, 
        p_static_id => pi_static_id
      );

    elsif pi_choice = 3 then

      email_pkg.reminder(
        p_App_ID    => pi_app_id, 
        p_Page_ID   => pi_app_page_id, 
        p_static_id => pi_static_id
      );

    end if;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end send_mail;

end p00030_api;
/

create or replace package body p00031_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure add_person(
    pi_tpl_id in r_templates.tpl_id%type
  , pi_per_id in varchar2
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'add_person';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.append_param(l_params, 'pi_per_id', pi_per_id);
    logger.log('START', l_scope, null, l_params);

    for rec in (
      select COLUMN_VALUE as per_id
        from apex_string.split(pi_per_id,':')
    )
    loop
      insert into template_import_status
      (tis_tpl_id, tis_per_id, tis_sts_id, tis_shipping_status)
      values
      (pi_tpl_id, rec.per_id, 1, 1);
    end loop;    

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end add_person;

end p00031_api;
/

create or replace package body p00032_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure save_automation(
    pi_tpa_tpl_id      in template_automations.tpa_tpl_id%type,
    pi_tpa_enabled in template_automations.tpa_enabled%type,
    pi_tpa_days    in template_automations.tpa_days%type
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'save_automation';
    l_params logger.tab_param;
  begin
    logger.append_param(l_params, 'pi_tpa_tpl_id', pi_tpa_tpl_id);
    logger.append_param(l_params, 'pi_tpa_enabled', pi_tpa_enabled);
    logger.append_param(l_params, 'pi_tpa_days', pi_tpa_days);
    logger.log('START', l_scope, null, l_params);

    update template_automations
       set tpa_enabled = pi_tpa_enabled,
           tpa_days = pi_tpa_days
     where tpa_tpl_id = pi_tpa_tpl_id;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end save_automation;

end p00032_api;
/

create or replace package body p00041_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure upload_file (
    pi_collection_name in  apex_collections.collection_name%type default 'DROPZONE_UPLOAD'
  , pi_tpl_id          in  r_templates.tpl_id%type       
  , po_error_occurred  out nocopy number
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'upload_file';
    l_params logger.tab_param;

  begin
    logger.append_param(l_params, 'pi_collection_name', pi_collection_name);
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.log('START', l_scope, null, l_params);

    file_import.upload_file (
      pi_collection_name => pi_collection_name
    , pi_tpl_id          => pi_tpl_id    
    , po_error_occurred  => po_error_occurred
    );

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end;

end p00041_api;
/

create or replace package body p00051_api
as
  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';
  function format_colnr (
    pi_colnr in pls_integer
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'format_colnr';
    l_params logger.tab_param;

    l_colnr varchar2(100 char);
  begin
    logger.append_param(l_params, 'pi_colnr', pi_colnr);
    logger.log('START', l_scope, null, l_params);

    l_colnr := 'col' || lpad(pi_colnr, 2, '0');

    logger.log('END', l_scope);
    return l_colnr;
    exception
      when others then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);
        raise;
  end format_colnr;


  function fill_columns (
    pi_count in pls_integer
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'fill_columns';
    l_params logger.tab_param;
    l_fill_columns varchar2(700 char);
  begin
    logger.append_param(l_params, 'pi_count', pi_count);
    logger.log('START', l_scope, null, l_params);

    for i in pi_count..45
    loop
      l_fill_columns := l_fill_columns || ''''' as ' || format_colnr(i) || ', ';
    end loop;

    logger.log('END', l_scope);
    return l_fill_columns;
    exception
      when others then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);
        raise;
  end fill_columns;


  function get_pivot_columns (
    pi_tis_id in template_import_status.tis_id%type
  )
    return varchar2
  as
    c_annotation constant varchar2(30 char) := 'Annotation';    
    c_faulty constant varchar2(11 char) := 'Faulty';
    c_validation constant varchar2(11 char) := 'Validation';

    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_pivot_columns';
    l_params logger.tab_param;

    l_annotation_id  r_header.hea_id%type;
    l_faulty_id r_header.hea_id%type;
    l_validation_id r_header.hea_id%type;

    l_count pls_integer := 0;
    l_tpl_id r_templates.tpl_id%type;

    l_new_col varchar2(100 char);
    l_pivot_columns varchar2(1000 char) := '';
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    select hea_id
      into l_annotation_id
      from r_header
     where hea_text = c_annotation
    ;

    select hea_id
      into l_faulty_id
      from r_header
     where hea_text = c_faulty
    ;

    select hea_id
      into l_validation_id
      from r_header
     where hea_text = c_validation
    ;

    select tpl_id
      into l_tpl_id
      from r_templates
      join template_import_status
        on tis_tpl_id = tpl_id
     where tis_id = pi_tis_id
    ;

    for rec in (
      select tph_hea_id, rownum
        from (
          select tph_hea_id
            from template_header
            join r_header
              on tph_hea_id = hea_id
           where tph_tpl_id = l_tpl_id
             and hea_id not in (l_faulty_id, l_annotation_id, l_validation_id)
           order by tph_sort_order
        )
    )
    loop
      l_count         := l_count + 1;
      l_new_col       := rec.tph_hea_id || rec.rownum || ' as ' || format_colnr(rec.rownum);
      l_pivot_columns := l_pivot_columns || l_new_col  || ', ';
    end loop;

    -- fill columns to static col count
    l_pivot_columns := l_pivot_columns || fill_columns(l_count + 1);

    -- add column_nr to identify the column and sort_order
    for rec in (
      select distinct tph_hea_id
        from (
          select tph_hea_id
            from template_header
            join r_header
              on tph_hea_id = hea_id
            join template_import_data
              on tid_tph_id = tph_id
           where tph_tpl_id = l_tpl_id
             and hea_id in (l_faulty_id, l_annotation_id,l_validation_id)
        ) order by tph_hea_id
    )
    loop
    if rec.tph_hea_id = l_annotation_id then  
        l_annotation_id      := l_annotation_id || (l_count+1) || 00;        
    elsif rec.tph_hea_id = l_faulty_id then  
        l_faulty_id     := l_faulty_id || (l_count+2) || 00;  
    elsif rec.tph_hea_id = l_validation_id then  
        l_validation_id     := l_validation_id || (l_count+3) || 00;      
    end if;    
    end loop;

    -- add faulty, annotation
    l_pivot_columns := l_pivot_columns || l_faulty_id || ' as faulty, ' || l_annotation_id || ' as annotation, ' || l_validation_id || ' as validation ';

    logger.log('END', l_scope);
    return l_pivot_columns ;
     exception
      when others then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);
        raise;
  end get_pivot_columns;


  function get_grid_query (
    pi_tis_id in template_import_status.tis_id%type
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_grid_query';
    l_params logger.tab_param;

    l_pivot_columns varchar2(1000 char);
    l_sql varchar2(32000 char);
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    l_pivot_columns := get_pivot_columns(pi_tis_id);

    l_sql :=
    ' select  tid_row_id
            , col01
            , col02
            , col03
            , col04
            , col05
            , col06
            , col07
            , col08
            , col09
            , col10
            , col11
            , col12
            , col13
            , col14
            , col15
            , col16
            , col17
            , col18
            , col19
            , col20
            , col21
            , col22
            , col23
            , col24
            , col25
            , col26
            , col27
            , col28
            , col29
            , col30
            , col31
            , col32
            , col33
            , col34
            , col35
            , col36
            , col37
            , col38
            , col39
            , col40
            , col41
            , col42
            , col43
            , col44
            , col45
            , nvl(faulty,0) as faulty
            , annotation
            , validation
        from (
        select tid_text
             , tid_row_id 
             , case when tph_hea_id not in (master_api.get_annotation_id,master_api.get_faulty_id,master_api.get_validation_id)  then
                tph_hea_id || ROW_NUMBER() OVER (PARTITION BY tid_row_id ORDER BY tid_id)
                else
                tph_hea_id || ROW_NUMBER() OVER (PARTITION BY tid_row_id ORDER BY tph_sort_order, tid_id) || 00
                end as tph_hea_id
          from template_import_status
          join template_import_data
            on tis_id = tid_tis_id
          join template_header
            on tid_tph_id = tph_id
         where tis_id =  ' || pi_tis_id || '
      ) pivot (
        max(tid_text)
        for tph_hea_id in ( ' || l_pivot_columns || ' )
      ) 
      order by tid_row_id';

    logger.log('SQL: '|| l_sql, l_scope, null, l_params);

    logger.log('END', l_scope);
    return l_sql;
        exception
      when others then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);
        raise;
  end get_grid_query;


  function get_grid_data (
    pi_tis_id in template_import_status.tis_id%type
  ) return t_grid_tab pipelined
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_grid_data';
    l_params logger.tab_param;

    l_query varchar2(4000 char);

    l_grid_tab t_grid_tab;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    l_query := get_grid_query(pi_tis_id);
    logger.log_info(l_query, l_scope, null, l_params);

    execute immediate l_query
    bulk collect into l_grid_tab;

    for i in 1..l_grid_tab.count
    loop
      pipe row(l_grid_tab(i));
    end loop;

    logger.log('END', l_scope);
  end get_grid_data;


  procedure update_answer_status (
    pi_tis_id         in template_import_status.tis_id%type
  , pi_tid_row_id     in template_import_data.tid_row_id%type
  , pi_annotation     in template_import_data.tid_text%type
  , pi_faulty         in template_import_data.tid_text%type
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'update_answer_status';
    l_params logger.tab_param;

    l_tpl_id r_templates.tpl_id%type;

    l_count             pls_integer;
    l_annotation_id     r_header.hea_id%type := master_api.get_annotation_id;
    l_faulty_id         r_header.hea_id%type := master_api.get_faulty_id;
    l_validation_id     r_header.hea_id%type := master_api.get_validation_id;

    l_annotation_tph_id  template_header.tph_id%type;
    l_faulty_tph_id      template_header.tph_id%type;
    l_validation_tph_id  template_header.tph_id%type;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.append_param(l_params, 'pi_tid_row_id', pi_tid_row_id);
    logger.append_param(l_params, 'pi_annotation', pi_annotation);
    logger.append_param(l_params, 'pi_faulty', pi_faulty);
    logger.log('START', l_scope, null, l_params);

    select tis_tpl_id
      into l_tpl_id
      from template_import_status
     where tis_id = pi_tis_id
    ;

    -- check if annotation and faulty are already in abfrage
    select count(*)
      into l_count
      from template_header
     where tph_hea_id = l_annotation_id
       and tph_tpl_id = l_tpl_id
    ;

    if l_count = 0 then
      insert into template_header
        (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order)
      values
        (l_tpl_id, l_annotation_id, 'ff4000', 'ff000000', 280)
      returning tph_id into l_annotation_tph_id;
    else
      select tph_id
        into l_annotation_tph_id
        from template_header
       where tph_hea_id = l_annotation_id
         and tph_tpl_id = l_tpl_id
      ;
    end if;

    select count(*)
      into l_count
      from template_header
     where tph_hea_id = l_faulty_id
       and tph_tpl_id = l_tpl_id
    ;

    if l_count = 0 then
      insert into template_header
        (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order)
      values
        (l_tpl_id, l_faulty_id, 'ff4000', 'ff000000', 281)
      returning tph_id into l_faulty_tph_id;
    else
      select tph_id
        into l_faulty_tph_id
        from template_header
       where tph_hea_id = l_faulty_id
         and tph_tpl_id = l_tpl_id
       ;
    end if;

    select count(*)
      into l_count
      from template_header
     where tph_hea_id = l_validation_id
       and tph_tpl_id = l_tpl_id
    ;

    if l_count = 0 then
      insert into template_header
        (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order)
      values
        (l_tpl_id, l_validation_id, 'ff4000', 'ff000000', 281)
      returning tph_id into l_validation_tph_id;
    else
      select tph_id
        into l_validation_tph_id
        from template_header
       where tph_hea_id = l_validation_id
         and tph_tpl_id = l_tpl_id
       ;
    end if;

    -- merge annotation
    -- merge because it's unknown if there already exists an answer for that
    merge into template_import_data dest
      using (
        select pi_annotation       as tid_text
             , pi_tis_id          as tid_tis_id
             , l_annotation_tph_id as tid_tph_id
             , pi_tid_row_id      as tid_row_id
          from dual
      ) src
      on (
            dest.tid_tis_id = src.tid_tis_id
        and dest.tid_row_id = src.tid_row_id
        and dest.tid_tph_id = src.tid_tph_id
      )
      when matched then
        update
          set dest.tid_text = src.tid_text
      when not matched then
         insert (dest.tid_tis_id, dest.tid_row_id, dest.tid_tph_id, dest.tid_text)
         values (src.tid_tis_id, src.tid_row_id, src.tid_tph_id, src.tid_text)
      ;

    -- merge faulty
    -- merge because it's unknown if there already exists an answer for that
    merge into template_import_data dest
      using (
        select pi_faulty       as tid_text              
             , pi_tis_id           as tid_tis_id
             , l_faulty_tph_id as tid_tph_id
             , pi_tid_row_id       as tid_row_id
          from dual
      ) src
      on (
            dest.tid_tis_id = src.tid_tis_id
        and dest.tid_row_id = src.tid_row_id
        and dest.tid_tph_id = src.tid_tph_id
      )
      when matched then
        update
          set dest.tid_text = src.tid_text 
      when not matched then
         insert (dest.tid_tis_id, dest.tid_row_id, dest.tid_tph_id, dest.tid_text)
         values (src.tid_tis_id, src.tid_row_id, src.tid_tph_id, src.tid_text)
      ;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end update_answer_status;

  procedure update_answer(
    pi_tid_text_array in t_tid_text_array
  , pi_tid_row_id     in template_import_data.tid_row_id%type
  , pi_tis_id         in template_import_data.tid_tis_id%type
  )
  as
    l_tpl_id r_templates.tpl_id%type;
    l_hea_id r_header.hea_id%type; 
    l_tph_id template_header.tph_id%type;

    l_hea_text_array t_hea_text_array;

    l_scope  logger_logs.scope%type := gc_scope_prefix || 'update_answer';
    l_params logger.tab_param;

    l_rownum pls_integer := 0; 
  begin
    logger.append_param(l_params, 'pi_tid_row_id', pi_tid_row_id);
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    -- get umfrage
    select tis_tpl_id
      into l_tpl_id
      from template_import_status
     where tis_id = pi_tis_id;

    -- get headers
    select text bulk collect
    into l_hea_text_array
    from
    (
      select hea_text as text, tis_id
      from template_import_status
      join template_header
      on tis_tpl_id = tph_tpl_id
      join r_header
      on tph_hea_id = hea_id
      order by tph_sort_order
    )
    where tis_id = pi_tis_id;

    -- update columns
    for counter in 1..l_hea_text_array.count
    loop
      l_rownum := l_rownum +1;
      -- get abfrage
      select hea_id  
      into l_hea_id
      from r_header
      where hea_text = l_hea_text_array(counter);

      if l_hea_id not in (master_api.get_faulty_id, master_api.get_annotation_id, master_api.get_validation_id)
      then
          -- get umfrage_abfrage
          select tph_id
          into l_tph_id
          from template_header
          where tph_tpl_id = l_tpl_id
          and tph_hea_id = l_hea_id
          and tph_sort_order = l_rownum;

          -- update row
          update template_import_data
          set  tid_text = pi_tid_text_array(counter)
          where tid_row_id = pi_tid_row_id
          and tid_tph_id = l_tph_id;

      end if;

    end loop;

  end update_answer;

  procedure insert_answer(
    pi_tid_text_array in t_tid_text_array
  , pi_annotation     in template_import_data.tid_text%type
  , pi_faulty         in template_import_data.tid_text%type
  , pi_tis_id         in template_import_data.tid_tis_id%type
  )
  as
    l_tid_row_id     template_import_data.tid_row_id%type;

    l_tpl_id r_templates.tpl_id%type;
    l_hea_id r_header.hea_id%type; 
    l_tph_id template_header.tph_id%type;

    l_hea_text_array t_hea_text_array;

    l_rownum pls_integer := 0; 
  begin

    -- get umfrage
    select tis_tpl_id
    into l_tpl_id
    from template_import_status
    where tis_id = pi_tis_id;

    -- get headers
    select text bulk collect
    into l_hea_text_array
    from
    (
      select hea_text as text, tis_id
      from template_import_status
      join template_header
      on tis_tpl_id = tph_tpl_id
      join r_header
      on tph_hea_id = hea_id
      order by tph_sort_order
    )
    where tis_id = pi_tis_id;

    l_tid_row_id := tid_row_seq.nextval;

    -- insert columns
    for counter in 1..l_hea_text_array.count
    loop
      l_rownum := l_rownum +1;

      -- get abfrage
      select hea_id
      into l_hea_id
      from r_header
      where hea_text = l_hea_text_array(counter);

      if l_hea_id not in (master_api.get_faulty_id,master_api.get_annotation_id,master_api.get_validation_id)
      then
        -- get umfrage_abfrage
        select tph_id
        into l_tph_id
        from template_header
        where tph_tpl_id = l_tpl_id
        and tph_hea_id = l_hea_id
        and tph_sort_order = l_rownum;

        -- insert row
        insert into template_import_data (tid_tph_id, tid_text, tid_tis_id, tid_row_id)
        values (l_tph_id, pi_tid_text_array(counter), pi_tis_id, l_tid_row_id);          
      end if;

      -- insert annotation column
      if l_hea_id = master_api.get_annotation_id and pi_annotation is not null
      then
          -- get umfrage_abfrage
          select tph_id
          into l_tph_id
          from template_header
          where tph_tpl_id = l_tpl_id
          and tph_hea_id = l_hea_id;

          -- insert row
          insert into template_import_data (tid_tph_id, tid_text, tid_tis_id, tid_row_id)
          values (l_tph_id, pi_annotation, pi_tis_id, l_tid_row_id);     
      end if;

      -- insert faulty column
      if l_hea_id = master_api.get_faulty_id and pi_faulty is not null
      then
        -- get umfrage_abfrage
        select tph_id
        into l_tph_id
        from template_header
        where tph_tpl_id = l_tpl_id
        and tph_hea_id = l_hea_id;

        -- insert row
        insert into template_import_data (tid_tph_id, tid_text, tid_tis_id, tid_row_id)
          values (l_tph_id, pi_faulty, pi_tis_id, l_tid_row_id);      
      end if;   

  end loop;

  end insert_answer;

  procedure delete_answer (
    pi_tis_id     in template_import_status.tis_id%type
  , pi_tid_row_id in template_import_data.tid_row_id%type
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'delete_answer';
    l_params logger.tab_param;
    type NumberArray is table of number index by binary_integer;
    tid_array NumberArray;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.append_param(l_params, 'pi_tid_row_id', pi_tid_row_id);
    logger.log('START', l_scope, null, l_params);

    Select tid_id bulk collect
      into tid_array 
      from template_import_data
     where tid_tis_id = pi_tis_id
       and tid_row_id = pi_tid_row_id;

    FOR i IN tid_array.FIRST..tid_array.LAST LOOP
       delete from template_import_data where tid_id = tid_array(i);
    END LOOP;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end delete_answer;

  function get_column_count(
    pi_tis_id in template_import_status.tis_id%type
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_column_count';
    l_params logger.tab_param;

    l_tph_tpl_id template_header.tph_tpl_id%type;
    l_count number;

    l_annotation_id  r_header.hea_id%type := master_api.get_annotation_id;
    l_faulty_id r_header.hea_id%type := master_api.get_faulty_id;
    l_validation_id r_header.hea_id%type := master_api.get_validation_id;
  begin
    logger.append_param(l_params, 'pi_tis_id', pi_tis_id);
    logger.log('START', l_scope, null, l_params);

    select count(*)
      into l_count
      from template_header
      join template_import_status
        on tph_tpl_id = tis_tpl_id
     where tis_id = pi_tis_id
       and tph_hea_id not in (l_annotation_id, l_faulty_id, l_validation_id);

    logger.log('END', l_scope);
    return l_count;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_column_count;

end p00051_api;
/

create or replace package body p00060_api
as
  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';
  
  function format_colnr (
    pi_colnr in pls_integer
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'format_colnr';
    l_params logger.tab_param;

    l_colnr varchar2(100 char);
  begin
    logger.append_param(l_params, 'pi_colnr', pi_colnr);
    logger.log('START', l_scope, null, l_params);

    l_colnr := 'col' || lpad(pi_colnr, 2, '0');

    logger.log('END', l_scope);
    return l_colnr;
    exception
      when others then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);
        raise;
  end format_colnr;


  function fill_columns (
    pi_count in pls_integer
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'fill_columns';
    l_params logger.tab_param;
    l_fill_columns varchar2(700 char);
  begin
    logger.append_param(l_params, 'pi_count', pi_count);
    logger.log('START', l_scope, null, l_params);

    for i in pi_count..45
    loop
      l_fill_columns := l_fill_columns || ''''' as ' || format_colnr(i) || ', ';
    end loop;   

    logger.log('END', l_scope);
    return l_fill_columns;
    exception
      when others then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);
        raise;
  end fill_columns;


  function get_pivot_columns (
    pi_tis_tpl_id in template_import_status.tis_tpl_id%type
  )
    return varchar2
  as
    c_annotation constant varchar2(30 char) := 'Annotation';    
    c_faulty constant varchar2(11 char) := 'Faulty';
    c_validation constant varchar2(11 char) := 'Validation';

    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_pivot_columns';
    l_params logger.tab_param;

    l_annotation_id  r_header.hea_id%type;
    l_faulty_id r_header.hea_id%type;
    l_validation_id r_header.hea_id%type;

    l_count pls_integer := 0;

    l_new_col varchar2(100 char);
    l_pivot_columns varchar2(1000 char) := '';
  begin
    logger.append_param(l_params, 'pi_tis_tpl_id', pi_tis_tpl_id);
    logger.log('START', l_scope, null, l_params);

    select hea_id
      into l_annotation_id
      from r_header
     where hea_text = c_annotation
    ;

    select hea_id
      into l_faulty_id
      from r_header
     where hea_text = c_faulty
    ;
    
    select hea_id
      into l_validation_id
      from r_header
     where hea_text = c_validation
    ;

    for rec in (
      select tph_hea_id, rownum
        from (
          select tph_hea_id
            from template_header
            join r_header
              on tph_hea_id = hea_id
           where tph_tpl_id = pi_tis_tpl_id
             and hea_id not in (l_faulty_id, l_annotation_id, l_validation_id)
           order by tph_sort_order
        )
    )
    loop      
      l_count         := l_count + 1;
      logger.log('l_count: ' || l_count);
      l_new_col       := rec.tph_hea_id || ' as ' || format_colnr(rec.rownum);
      l_pivot_columns := l_pivot_columns || l_new_col  || ', ';
      logger.log('l_pivot_columns: ' || l_pivot_columns);
    end loop;

    -- fill columns to static col count
    l_pivot_columns := l_pivot_columns || fill_columns(l_count + 1);
    
    -- delete last comma
    l_pivot_columns := substr(l_pivot_columns,0,length(l_pivot_columns)-2);

    logger.log('END', l_scope);
    return l_pivot_columns ;
     exception
      when others then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);
        raise;
  end get_pivot_columns;


  function get_grid_query (
    pi_tis_tpl_id in template_import_status.tis_tpl_id%type
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_grid_query';
    l_params logger.tab_param;

    l_pivot_columns varchar2(1000 char);
    l_sql varchar2(32000 char);
  begin
    logger.append_param(l_params, 'pi_tis_tpl_id', pi_tis_tpl_id);
    logger.log('START', l_scope, null, l_params);

    l_pivot_columns := get_pivot_columns(pi_tis_tpl_id);

    l_sql :=
    ' select  tid_row_id
            , col01
            , col02
            , col03
            , col04
            , col05
            , col06
            , col07
            , col08
            , col09
            , col10
            , col11
            , col12
            , col13
            , col14
            , col15
            , col16
            , col17
            , col18
            , col19
            , col20
            , col21
            , col22
            , col23
            , col24
            , col25
            , col26
            , col27
            , col28
            , col29
            , col30
            , col31
            , col32
            , col33
            , col34
            , col35
            , col36
            , col37
            , col38
            , col39
            , col40
            , col41
            , col42
            , col43
            , col44
            , col45
        from (
        select tid_text
             , tid_row_id 
             , tph_hea_id
          from template_import_status
          join template_import_data
            on tis_id = tid_tis_id
          join template_header
            on tid_tph_id = tph_id
         where tis_sts_id = 3
           and tis_tpl_id =  ' || pi_tis_tpl_id || '
      ) pivot (
        max(tid_text)
        for tph_hea_id in ( ' || l_pivot_columns || ' )
      ) 
      order by tid_row_id';

    logger.log('SQL: '|| l_sql, l_scope, null, l_params);

    logger.log('END', l_scope);
    return l_sql;
        exception
      when others then
        logger.log_error('Unhandled Exception', l_scope, null, l_params);
        raise;
  end get_grid_query;


  function get_grid_data (
    pi_tis_tpl_id in template_import_status.tis_tpl_id%type
  ) return t_grid_tab pipelined
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_grid_data';
    l_params logger.tab_param;

    l_query varchar2(4000 char);

    l_grid_tab t_grid_tab;
  begin
    logger.append_param(l_params, 'pi_tis_tpl_id', pi_tis_tpl_id);
    logger.log('START', l_scope, null, l_params);

    l_query := get_grid_query(pi_tis_tpl_id);
    logger.log_info(l_query, l_scope, null, l_params);

    execute immediate l_query
    bulk collect into l_grid_tab;

    for i in 1..l_grid_tab.count
    loop
      pipe row(l_grid_tab(i));
    end loop;

    logger.log('END', l_scope);
  end get_grid_data;


  function get_column_count(
    pi_tis_tpl_id in template_import_status.tis_tpl_id%type
  )
    return varchar2
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'get_column_count';
    l_params logger.tab_param;

    l_tph_tpl_id template_header.tph_tpl_id%type;
    l_count number;

    l_annotation_id  r_header.hea_id%type := master_api.get_annotation_id;
    l_faulty_id r_header.hea_id%type := master_api.get_faulty_id;
    l_validation_id r_header.hea_id%type := master_api.get_validation_id;
  begin
    logger.append_param(l_params, 'pi_tis_tpl_id', pi_tis_tpl_id);
    logger.log('START', l_scope, null, l_params);

    select count(*)
      into l_count
      from template_header
      join r_templates
        on tph_tpl_id = tpl_id
     where tpl_id = pi_tis_tpl_id
       and tph_hea_id not in (l_annotation_id, l_faulty_id, l_validation_id);

    logger.log('END', l_scope);
    return l_count;
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end get_column_count;

end p00060_api;
/

create or replace package body p00085_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure edit_template (
    pi_tpl_id in r_templates.tpl_id%type       
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'edit_template';
    l_params logger.tab_param;
    l_tpl_id r_templates.tpl_id%type;
    l_tph_id template_header.tph_id%type;
  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.log('START', l_scope, null, l_params);

    for rec in ( 
        select distinct
               c001 as tpl_id, 
               c006 as tpl_deadline, 
               c007 as tpl_number_of_rows, 
               c011 as tpl_ssp_id
          from apex_collections 
         where collection_name = 'EDIT_TEMPLATE' 
           and c001 is not null
    ) 
    loop
        update r_templates 
          set tpl_deadline = rec.tpl_deadline,
              tpl_number_of_rows = rec.tpl_number_of_rows,
              tpl_ssp_id = rec.tpl_ssp_id
        where tpl_id = rec.tpl_id
        returning tpl_id INTO l_tpl_id;
        
        if l_tpl_id is not null then
            delete template_header_validations
            where thv_tph_id in (select tph_id from template_header where tph_tpl_id = l_tpl_id);
            
            delete template_header
            where tph_tpl_id = l_tpl_id;             
        end if;
    end loop;

    if l_tpl_id is not null then
        for rec in ( 
            select seq_id as tph_sort_order, c001 as tpl_id, c002 as tph_hea_id, 
                  c003 as hea_text, replace(c004,'#','ff') as tph_xlsx_font_color, replace(c005,'#','ff') as tph_xlsx_background_color,
                  c006 as tpl_deadline, c007 as tpl_number_of_rows, c008 as tph_thg_id, c009 as thv_formula1, c010 as thv_formula2,
                  c011 as tpl_ssp_id
              from apex_collections 
            where collection_name = 'EDIT_TEMPLATE' 
          order by seq_id
        ) 
        loop 
            insert into template_header 
            (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order, tph_thg_id)
            VALUES (l_tpl_id, rec.tph_hea_id, rec.tph_xlsx_background_color, rec.tph_xlsx_font_color, rec.tph_sort_order, rec.tph_thg_id)
            RETURNING tph_id into l_tph_id;
            
            if rec.thv_formula1 is not null or rec.thv_formula2 is not null then
                insert into template_header_validations
                (thv_tph_id, thv_formula1, thv_formula2)
                VALUES (l_tph_id, rec.thv_formula1, rec.thv_formula2);
            end if;
        end loop;
    end if;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end edit_template;

  procedure create_preview (
    pi_collection_name in  apex_collections.collection_name%type default 'EDIT_TEMPLATE'       
  )
  as
    l_scope     logger_logs.scope%type := gc_scope_prefix || 'create_preview';
    l_params    logger.tab_param;
    l_tpl_id    r_templates.tpl_id%type;
    l_tpl_name  r_templates.tpl_name%type;
    l_tph_id    template_header.tph_id%type;
  begin
    logger.append_param(l_params, 'pi_collection_name', pi_collection_name);
    logger.log('START', l_scope, null, l_params);
    
    select tpl_name 
      into l_tpl_name
      from r_templates
     where tpl_id = (select distinct c001 as tpl_id 
                       from apex_collections 
                      where collection_name = 'EDIT_TEMPLATE' 
                        and c001 is not null);    
    
    for rec in ( 
        select seq_id as tph_sort_order, c001 as tpl_id, c002 as tph_hea_id, 
               c003 as hea_text, replace(c004,'#','ff') as tph_xlsx_font_color, replace(c005,'#','ff') as tph_xlsx_background_color,
               c006 as tpl_deadline, c007 as tpl_number_of_rows, c008 as tph_thg_id, c009 as thv_formula1, c010 as thv_formula2,
               c011 as ssp_id
          from apex_collections 
         where collection_name = 'EDIT_TEMPLATE' 
      order by seq_id
    ) 
    loop   
    
        if l_tpl_id is null then
            insert into r_templates 
            (tpl_id, tpl_name, tpl_deadline, tpl_number_of_rows, tpl_ssp_id) 
            VALUES (0, 'preview', nvl(rec.tpl_deadline,7), nvl(rec.tpl_number_of_rows,100), rec.ssp_id)
            RETURNING tpl_id into l_tpl_id;
        end if;

        insert into template_header 
        (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order, tph_thg_id)
        VALUES (l_tpl_id, rec.tph_hea_id, rec.tph_xlsx_background_color, rec.tph_xlsx_font_color, rec.tph_sort_order, rec.tph_thg_id)
        RETURNING tph_id into l_tph_id;
        
        if rec.thv_formula1 is not null or rec.thv_formula2 is not null then
            insert into template_header_validations
            (thv_tph_id, thv_formula1, thv_formula2)
            VALUES (l_tph_id, rec.thv_formula1, rec.thv_formula2);
        end if;  

        end loop;

        excel_gen.generate_single_file (
          pi_tis_id         => 0
        , pi_tpl_id         => l_tpl_id
        , pi_tpl_name       => l_tpl_name
        , pi_per_id         => 123456789
        , pi_per_firstname  => 'sample'
        , pi_per_lastname   => 'file'
        );

        -- delete preview data
        delete template_header_validations where thv_tph_id in (select tph_id from template_header where tph_tpl_id = l_tpl_id);
        delete template_header where tph_tpl_id = l_tpl_id;
        delete r_templates where tpl_id = l_tpl_id;
   
    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end create_preview;    

end p00085_api;
/

create or replace package body p00090_api
as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

  procedure delete_template (
    pi_tpl_id          in  r_templates.tpl_id%type
  )
  as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'delete_template';
    l_params logger.tab_param;

  begin
    logger.append_param(l_params, 'pi_tpl_id', pi_tpl_id);
    logger.log('START', l_scope, null, l_params);

    -- delete template data
    delete template_import_data where tid_tis_id in (select tis_id from template_import_status where tis_tpl_id = pi_tpl_id);
    delete template_import_status where tis_tpl_id = pi_tpl_id;
    delete template_automations where tpa_tpl_id = pi_tpl_id;
    delete template_header_validations where thv_tph_id in (select tph_id from template_header where tph_tpl_id = pi_tpl_id);
    delete template_header where tph_tpl_id = pi_tpl_id;
    delete r_templates where tpl_id = pi_tpl_id;

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end;

end p00090_api;
/

create or replace package body validation_api
as 

    gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';

 function validate_data(
    p_tid_text      template_import_data.tid_text%type,
    p_val_text      r_validation.val_text%type
 ) return boolean
 as
    l_scope  logger_logs.scope%type := gc_scope_prefix || 'validate_data';
    l_params logger.tab_param;
    
    l_validate_data boolean default false;
    l_email_count   pls_integer;
 begin
    logger.append_param(l_params, 'p_tid_text', p_tid_text);
    logger.append_param(l_params, 'p_val_text', p_val_text);
    logger.log('START', l_scope, null, l_params);
       
    -- check number validation
    if VALIDATE_CONVERSION(p_tid_text AS NUMBER) = 0 and p_val_text = 'number' then            
        l_validate_data := true;               
    -- check date validation
    elsif VALIDATE_CONVERSION(p_tid_text AS DATE, 'yyyy-mm-dd') = 0 and p_val_text = 'date' then            
        l_validate_data := true;
    -- check email validation
    elsif p_val_text = 'email' then           
        select count(column_value) 
          into l_email_count
          from table(apex_string_util.find_email_addresses(p_tid_text));

        if l_email_count = 0 then                  
            l_validate_data := true;
        end if;
    end if;
    
    logger.log('Return -> ' || logger.tochar(l_validate_data), l_scope);
    return l_validate_data;
    
    logger.log('END', l_scope);
 exception
   when others then
     logger.log_error('Unhandled Exception', l_scope, null, l_params);
     raise;
 end validate_data;   
 
 procedure validation (
      p_tis_id in template_import_status.tis_id%type
 )
 as
        l_scope  logger_logs.scope%type := gc_scope_prefix || 'validation';
        l_params logger.tab_param;

        l_count                  pls_integer;
        l_email_count            pls_integer;
        l_is_unique              pls_integer;
        l_validate_data          boolean;
        l_tis_tpl_id             template_import_status.tis_tpl_id%type;

        l_annotation_id          r_header.hea_id%type := master_api.get_annotation_id;
        l_faulty_id              r_header.hea_id%type := master_api.get_faulty_id;
        l_validation_id          r_header.hea_id%type := master_api.get_validation_id;

        l_annotation_tph_id      template_header.tph_id%type;
        l_faulty_tph_id          template_header.tph_id%type;
        l_validation_tph_id      template_header.tph_id%type;         
 begin
        logger.append_param(l_params, 'p_tis_id', p_tis_id);
        logger.log('START', l_scope, null, l_params);

        select tis_tpl_id 
          into l_tis_tpl_id
          from template_import_status
         where tis_id = p_tis_id; 

        -- Set Faulty to 0 where is no annotation
        for rec in (
            select tid_row_id, tid_tph_id, tid_text  
              from template_import_data sva
             where tid_tis_id = p_tis_id 
               and tid_row_id in (select tid_row_id from template_import_data where tid_val_id > 0)
               and tid_tph_id in (select tph_id from template_header where tph_hea_id in (l_faulty_id, l_annotation_id) and tph_tpl_id = l_tis_tpl_id)
               and trim(both from tid_text) is null
        )
        loop
            update template_import_data
               set tid_text = 0
             where tid_row_id = rec.tid_row_id
               and tid_tph_id = (select tph_id from template_header where tph_hea_id in (l_faulty_id) and tph_tpl_id = l_tis_tpl_id);
        end loop;   

        -- Set Validation to 0
        update template_import_data
           set tid_val_id = 0
         where tid_tis_id = p_tis_id;

        -- reset validation
        for i in ( 
            select distinct tid_tph_id
              from template_import_data 
             where tid_tis_id = p_tis_id 
               and tid_tph_id in (select tph_id from template_header where tph_hea_id in (l_validation_id) and tph_tpl_id = l_tis_tpl_id)
        )
        loop

        update template_import_data
           set tid_text = ''
         where tid_tis_id = p_tis_id
           and tid_tph_id = i.tid_tph_id;

        end loop;

        --Step 1 select data which have to validate
        for i in (
          select  c.tpl_id, e.tid_id, e.tid_text, a.hea_val_id, b.val_text, b.val_message,e.tid_tis_id, d.tph_id, d.tph_hea_id, e.tid_row_id
            from  r_header a,
                  r_validation b,
                  r_templates c,
                  template_header d,
                  template_import_data e         
           where  a.hea_id = d.tph_hea_id 
             and  a.hea_val_id = b.val_id
             and  c.tpl_id = d.tph_tpl_id
             and  d.tph_id = e.tid_tph_id
             and  a.hea_val_id is not null
             and  d.tph_tpl_id = l_tis_tpl_id
        )
        loop
            l_validate_data := false;
            
            -- Check if template header for annotation, faulty and validation exists        
            select count(*)
              into l_count
              from template_header
             where tph_hea_id = l_annotation_id
               and tph_tpl_id = i.tpl_id;

            if l_count = 0 then
              insert into template_header
                (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order)
              values
                (i.tpl_id, l_annotation_id, 'ff4000', 'ff000000', 280)
              returning tph_id into l_annotation_tph_id;
            else
              select tph_id
                into l_annotation_tph_id
                from template_header
               where tph_hea_id = l_annotation_id
                 and tph_tpl_id = i.tpl_id
              ;
            end if;

            select count(*)
              into l_count
              from template_header
             where tph_hea_id = l_faulty_id
               and tph_tpl_id = i.tpl_id
            ;

            if l_count = 0 then
              insert into template_header
                (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order)
              values
                (i.tpl_id, l_faulty_id, 'ff4000', 'ff000000', 281)
              returning tph_id into l_faulty_tph_id;
            else
              select tph_id
                into l_faulty_tph_id
                from template_header
               where tph_hea_id = l_faulty_id
                 and tph_tpl_id = i.tpl_id
               ;
            end if; 

            select count(*)
              into l_count
              from template_header
             where tph_hea_id = l_validation_id
               and tph_tpl_id = i.tpl_id
            ;

            if l_count = 0 then
              insert into template_header
                (tph_tpl_id, tph_hea_id, tph_xlsx_background_color, tph_xlsx_font_color, tph_sort_order)
              values
                (i.tpl_id, l_validation_id, 'ff4000', 'ff000000', 282)
              returning tph_id into l_validation_tph_id;
            else
              select tph_id
                into l_validation_tph_id
                from template_header
               where tph_hea_id = l_validation_id
                 and tph_tpl_id = i.tpl_id
               ;
            end if; 

            -- get true if text data is invalid
            l_validate_data := validate_data(i.tid_text, i.val_text);
            
            -- set faulty, annotation and validation data for invalid data
            if l_validate_data = true then

              update template_import_data
                 set tid_val_id = i.hea_val_id
               where tid_tis_id = i.tid_tis_id
                 and tid_row_id = i.tid_row_id
                 and tid_tph_id = i.tph_id;

              select count(distinct template_header.tph_tpl_id)
                into l_count
                from template_header join template_import_data on tph_id = tid_tph_id
               where tph_hea_id = l_faulty_tph_id
                 and tph_hea_id = l_validation_tph_id
                 and tph_hea_id = l_annotation_tph_id
                 and tph_tpl_id = i.tpl_id
                 and tid_tis_id = i.tid_tis_id
                 and tid_row_id = i.tid_row_id
               ;

              if l_count = 0 then

                  select count(*)  
                  into l_is_unique
                  from template_import_data 
                  where tid_tis_id = i.tid_tis_id
                  and   tid_tph_id = l_annotation_tph_id
                  and   tid_row_id = i.tid_row_id;

                  if l_is_unique = 0 then

                  insert into template_import_data (
                    tid_tph_id
                   ,tid_text
                   ,tid_tis_id
                   ,tid_row_id
                   ) values (
                    l_annotation_tph_id
                   ,' '
                   ,i.tid_tis_id
                   ,i.tid_row_id);

                  end if;

                  select count(*)  
                  into l_is_unique
                  from template_import_data 
                  where tid_tis_id = i.tid_tis_id
                  and   tid_tph_id = l_faulty_tph_id
                  and   tid_row_id = i.tid_row_id;

                  if l_is_unique = 0 then

                  insert into template_import_data (
                    tid_tph_id
                   ,tid_text
                   ,tid_tis_id
                   ,tid_row_id
                   ) values (
                    l_faulty_tph_id
                   ,'1'
                   ,i.tid_tis_id
                   ,i.tid_row_id);

                  else

                  update template_import_data 
                  set    tid_text = 1
                  where  tid_tph_id = l_faulty_tph_id
                  and tid_tis_id = i.tid_tis_id
                  and tid_row_id = i.tid_row_id;

                  end if;

                  select count(*)  
                  into l_is_unique
                  from template_import_data 
                  where tid_tis_id = i.tid_tis_id
                  and   tid_tph_id = l_validation_tph_id
                  and   tid_row_id = i.tid_row_id;

                  if l_is_unique = 0 then

                  insert into template_import_data (
                    tid_tph_id
                   ,tid_text
                   ,tid_tis_id
                   ,tid_row_id  
                   ) values (
                    l_validation_tph_id
                   ,i.val_message
                   ,i.tid_tis_id
                   ,i.tid_row_id);

                  else

                  update template_import_data 
                  set    tid_text = tid_text || case when tid_text not like '%' || i.val_message || '%' or tid_text is null then case when tid_text is not null then ', ' end || i.val_message end
                  where  tid_tph_id = l_validation_tph_id
                  and tid_tis_id = i.tid_tis_id
                  and tid_row_id = i.tid_row_id;

                  end if;

              -- Step 1.2.2 Retoure und Anmerkung Antwort aktualisieren
              else 
               for rec2 in (
                 select tid_tph_id 
                   from r_templates c,
                        template_header d,
                        template_import_data e
                  where c.tpl_id = d.tph_tpl_id
                    and d.tph_id = e.tid_tph_id
                    and e.tid_tis_id = i.tid_tis_id
                    and e.tid_row_id = i.tid_row_id
                    and (e.tid_tph_id in (select tph_id from template_header where tph_tpl_id = l_tis_tpl_id and tph_hea_id in (l_validation_id)))
                )
                loop
                    -- Systempruefung schreiben
                    update template_import_data 
                       set tid_text = tid_text || case when tid_text not like '%' || i.val_message || '%' or tid_text is null then case when tid_text is not null then ', ' end || i.val_message end
                     where tid_tph_id = l_validation_tph_id
                       and tid_tis_id = i.tid_tis_id
                       and tid_row_id = i.tid_row_id;
                end loop;
              end if;
            end if;
        end loop;
        
        logger.log('END', l_scope);
    exception
    when others then
          logger.log_error('Unhandled Exception', l_scope, null, l_params);
          raise;
    end validation;

end validation_api;
/

create or replace PACKAGE BODY xlsx_builder_pkg
IS
   /* Some Naming-conventions
   Prefixes for Datatypes in defined Records-Type-Elements
   vc   VARCHAR2
   nv   NVARCHAR2
   ch   CHAR
   nc   NCHAR
   nn   NUMBER
   pi   PLS_INTEGER
   bi   BINARY_INTEGER
   dt   DATE
   bo   BOOLEAN
   bf   BFILE
   bl   BLOB
   cl   CLOB
   nl   NCLOB
   lo   LONG
   tl   TIMESTAMP (fractional_seconds_precision) WITH LOCAL TIME ZONE
   ts   TIMESTAMP (fractional_seconds_precision)
   tz   TIMESTAMP (fractional_seconds_precision) WITH TIME ZONE
   iv   INTERVAL
        Sample: vc_name VARCHAR2 (10)
   Types-Prefixes
   t_... TYPE
   Types-Suffixes
   ..._rec record
   ..._tab PL/SQL-Table
   */

   /* Types */
   TYPE t_xf_fmt_rec IS RECORD
   (
      pi_numfmtid     PLS_INTEGER,
      pi_fontid       PLS_INTEGER,
      pi_fillid       PLS_INTEGER,
      pi_borderid     PLS_INTEGER,
      alignment_rec   t_alignment_rec
   );

   TYPE t_col_fmts_tab IS TABLE OF t_xf_fmt_rec
      INDEX BY PLS_INTEGER;

   TYPE t_row_fmts_tab IS TABLE OF t_xf_fmt_rec
      INDEX BY PLS_INTEGER;

   TYPE t_widths_tab IS TABLE OF NUMBER
      INDEX BY PLS_INTEGER;

   TYPE t_cell_rec IS RECORD
   (
      nn_value_id    NUMBER,
      vc_style_def   VARCHAR2 (50),
      formula        VARCHAR2 (32767 CHAR) := NULL
   );

   TYPE t_cells_tab IS TABLE OF t_cell_rec
      INDEX BY PLS_INTEGER;

   TYPE t_rows_tab IS TABLE OF t_cells_tab
      INDEX BY PLS_INTEGER;

   TYPE t_autofilter_rec IS RECORD
   (
      pi_column_start   PLS_INTEGER,
      pi_column_end     PLS_INTEGER,
      pi_row_start      PLS_INTEGER,
      pi_row_end        PLS_INTEGER
   );

   TYPE t_autofilters_tab IS TABLE OF t_autofilter_rec
      INDEX BY PLS_INTEGER;

   TYPE t_hyperlink_rec IS RECORD
   (
      vc_cell   VARCHAR2 (10),
      vc_url    VARCHAR2 (1000)
   );

   TYPE t_hyperlinks_tab IS TABLE OF t_hyperlink_rec
      INDEX BY PLS_INTEGER;

   SUBTYPE st_author IS VARCHAR2 (32767 CHAR);

   TYPE t_authors_tab IS TABLE OF PLS_INTEGER
      INDEX BY st_author;

   gv_authors_tab                         t_authors_tab;

   TYPE t_comment_rec IS RECORD
   (
      vc_text        VARCHAR2 (32767 CHAR),
      vc_author      st_author,
      pi_row_nr      PLS_INTEGER,
      pi_column_nr   PLS_INTEGER,
      pi_width       PLS_INTEGER,
      pi_height      PLS_INTEGER
   );

   TYPE t_comments_tab IS TABLE OF t_comment_rec
      INDEX BY PLS_INTEGER;

   TYPE t_mergecells_tab IS TABLE OF VARCHAR2 (21)
      INDEX BY PLS_INTEGER;

   TYPE t_validation_rec IS RECORD
   (
      vc_validation_type    VARCHAR2 (10),
      vc_errorstyle         VARCHAR2 (32),
      bo_showinputmessage   BOOLEAN,
      vc_prompt             VARCHAR2 (32767 CHAR),
      vc_title              VARCHAR2 (32767 CHAR),
      vc_error_title        VARCHAR2 (32767 CHAR),
      vc_error_txt          VARCHAR2 (32767 CHAR),
      bo_showerrormessage   BOOLEAN,
      vc_formula1           VARCHAR2 (32767 CHAR),
      vc_formula2           VARCHAR2 (32767 CHAR),
      bo_allowblank         BOOLEAN,
      vc_sqref              VARCHAR2 (32767 CHAR)
   );

   TYPE t_validations_tab IS TABLE OF t_validation_rec
      INDEX BY PLS_INTEGER;

   TYPE t_protection_rec IS RECORD
   (
      vc_name               VARCHAR2 (200 CHAR),
      vc_tl_col             VARCHAR2 (20 CHAR),
      vc_tl_row             VARCHAR2 (20 CHAR), 
      vc_br_col             VARCHAR2 (20 CHAR),
      vc_br_row             VARCHAR2 (20 CHAR) 
   );

   TYPE t_protection_tab IS TABLE OF t_protection_rec
      INDEX BY PLS_INTEGER;   

   TYPE t_sheet_rec IS RECORD
   (
      sheet_rows_tab    t_rows_tab,
      widths_tab_tab    t_widths_tab,
      vc_sheet_name     VARCHAR2 (31 CHAR),
      pi_freeze_rows    PLS_INTEGER,
      pi_freeze_cols    PLS_INTEGER,
      autofilters_tab   t_autofilters_tab,
      hyperlinks_tab    t_hyperlinks_tab,
      col_fmts_tab      t_col_fmts_tab,
      row_fmts_tab      t_row_fmts_tab,
      comments_tab      t_comments_tab,
      mergecells_tab    t_mergecells_tab,
      validations_tab   t_validations_tab,
      protection_tab    t_protection_tab,
      hidden            boolean,
      hash_value        VARCHAR2(200 CHAR),
      salt_value        VARCHAR2(200 CHAR)
   );

   TYPE t_sheets_tab IS TABLE OF t_sheet_rec
      INDEX BY PLS_INTEGER;

   TYPE t_numfmt_rec IS RECORD
   (
      pi_numfmtid     PLS_INTEGER,
      vc_formatcode   VARCHAR2 (100)
   );

   TYPE t_numfmts_tab IS TABLE OF t_numfmt_rec
      INDEX BY PLS_INTEGER;

   TYPE t_fill_rec IS RECORD
   (
      vc_patterntype   VARCHAR2 (30),
      vc_fgrgb         VARCHAR2 (8)
   );

   TYPE t_fills_tab IS TABLE OF t_fill_rec
      INDEX BY PLS_INTEGER;

   TYPE t_cellxfs_tab IS TABLE OF t_xf_fmt_rec
      INDEX BY PLS_INTEGER;

   TYPE t_font_rec IS RECORD
   (
      vc_font_name   VARCHAR2 (100),
      pi_family      PLS_INTEGER,
      nn_fontsize    NUMBER,
      pi_theme       PLS_INTEGER,
      vc_rgb         VARCHAR2 (8),
      bo_underline   BOOLEAN,
      bo_italic      BOOLEAN,
      bo_bold        BOOLEAN
   );

   TYPE t_fonts_tab IS TABLE OF t_font_rec
      INDEX BY PLS_INTEGER;

   TYPE t_border_rec IS RECORD
   (
      vc_top_border      VARCHAR2 (17),
      vc_bottom_border   VARCHAR2 (17),
      vc_left_border     VARCHAR2 (17),
      vc_right_border    VARCHAR2 (17)
   );

   TYPE t_borders_tab IS TABLE OF t_border_rec
      INDEX BY PLS_INTEGER;

   TYPE t_numfmtindexes_tab IS TABLE OF PLS_INTEGER
      INDEX BY PLS_INTEGER;

   TYPE t_strings_tab IS TABLE OF PLS_INTEGER
      INDEX BY VARCHAR2 (32767 CHAR);

   TYPE t_str_ind_tab IS TABLE OF VARCHAR2 (32767 CHAR)
      INDEX BY PLS_INTEGER;

   TYPE t_defined_name_rec IS RECORD
   (
      vc_defined_name   VARCHAR2 (32767 CHAR),
      vc_defined_ref    VARCHAR2 (32767 CHAR),
      pi_sheet          PLS_INTEGER
   );

   TYPE t_defined_names_tab IS TABLE OF t_defined_name_rec
      INDEX BY PLS_INTEGER;

   TYPE t_book_rec IS RECORD
   (
      sheets_tab          t_sheets_tab,
      strings_tab         t_strings_tab,
      str_ind_tab         t_str_ind_tab,
      pi_str_cnt          PLS_INTEGER:= 0,
      fonts_tab           t_fonts_tab,
      fills_tab           t_fills_tab,
      borders_tab         t_borders_tab,
      numfmts_tab         t_numfmts_tab,
      cellxfs_tab         t_cellxfs_tab,
      numfmtindexes_tab   t_numfmtindexes_tab,
      defined_names_tab   t_defined_names_tab
   );

   /* Globals */
   -- the only global variable (objekt) without prefix and suffix
   workbook                               t_book_rec;

   --
   FUNCTION get_workbook
      RETURN t_book_rec
   AS
   BEGIN
      RETURN workbook;
   END get_workbook;

   /* Private API */
   /**
   * Procedure concatenates a VARCHAR2 to an CLOB.
   * It uses another VARCHAR2 as a buffer until it reaches 32767 characters.
   * Then it flushes the current buffer to the CLOB and resets the buffer using
   * the actual VARCHAR2 to add.
   * Your final call needs to be done setting p_eof to TRUE in order to
   * flush everything to the CLOB.
   *
   * @param p_clob        The CLOB you want to append to.
   * @param p_vc_buffer   The intermediate VARCHAR2 buffer. (must be VARCHAR2(32767))
   * @param p_vc_addition The VARCHAR2 value you want to append.
   * @param p_eof         Indicates if complete buffer should be flushed to CLOB.
   */
   PROCEDURE clob_vc_concat( p_clob IN OUT NOCOPY CLOB
                           , p_vc_buffer IN OUT NOCOPY VARCHAR2
                           , p_vc_addition IN VARCHAR2
                           , p_eof IN BOOLEAN DEFAULT FALSE
                           )
   AS
   BEGIN 
     -- Standard Flow
     IF NVL(LENGTHB(p_vc_buffer), 0) + NVL(LENGTHB(p_vc_addition), 0) < 32767 THEN
       p_vc_buffer := p_vc_buffer || p_vc_addition;
     ELSE
       IF p_clob IS NULL THEN
         dbms_lob.createtemporary(p_clob, TRUE);
       END IF;
       dbms_lob.writeappend(p_clob, LENGTH(p_vc_buffer), p_vc_buffer);
       p_vc_buffer := p_vc_addition;
     END IF;

     -- Full Flush requested
     IF p_eof THEN
       IF p_clob IS NULL THEN
         p_clob := p_vc_buffer;
       ELSE
         dbms_lob.writeappend(p_clob, LENGTH(p_vc_buffer), p_vc_buffer);
       END IF;
     p_vc_buffer := NULL;
     END IF;
   END clob_vc_concat;

   FUNCTION get_sheet_id (p_sheet IN PLS_INTEGER)
      RETURN PLS_INTEGER
   AS
   BEGIN
      RETURN NVL (p_sheet, workbook.sheets_tab.COUNT);
   END get_sheet_id;


   FUNCTION alfan_col (p_col PLS_INTEGER)
      RETURN VARCHAR2
   AS
   BEGIN
      RETURN CASE
                WHEN p_col > 702
                THEN
                      CHR (64 + TRUNC ( (p_col - 27) / 676))
                   || CHR (65 + MOD (TRUNC ( (p_col - 1) / 26) - 1, 26))
                   || CHR (65 + MOD (p_col - 1, 26))
                WHEN p_col > 26
                THEN
                   CHR (64 + TRUNC ( (p_col - 1) / 26)) || CHR (65 + MOD (p_col - 1, 26))
                ELSE
                   CHR (64 + p_col)
             END;
   END alfan_col;

   FUNCTION col_alfan (p_col VARCHAR2)
      RETURN PLS_INTEGER
   AS
   BEGIN
      RETURN   ASCII (SUBSTR (p_col, -1))
             - 64
             + NVL ( (ASCII (SUBSTR (p_col, -2, 1)) - 64) * 26, 0)
             + NVL ( (ASCII (SUBSTR (p_col, -3, 1)) - 64) * 676, 0);
   END col_alfan;

   -- EMORKLE (2014/02/24): Moved to top, allowing usage in new_sheet
   FUNCTION add_string (p_string VARCHAR2)
      RETURN PLS_INTEGER
   AS
      t_cnt   PLS_INTEGER;
   BEGIN
      -- MKLEIN (2014/02/24): Fix to handle NULL values
      IF p_string IS NULL AND workbook.strings_tab.COUNT > 0
      THEN
         RETURN 0;
      END IF;

      -- END Fix
      IF workbook.strings_tab.EXISTS (p_string)
      THEN
         t_cnt := workbook.strings_tab (p_string);
      ELSE
         t_cnt := workbook.strings_tab.COUNT;
         workbook.str_ind_tab (t_cnt) := p_string;
         workbook.strings_tab (NVL (p_string, '')) := t_cnt;
      END IF;

      workbook.pi_str_cnt := workbook.pi_str_cnt + 1;
      RETURN t_cnt;
   END add_string;

   PROCEDURE clear_workbook
   IS
      t_row_ind   PLS_INTEGER;
   BEGIN
      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         t_row_ind := workbook.sheets_tab (s).sheet_rows_tab.FIRST;

         WHILE t_row_ind IS NOT NULL
         LOOP
            workbook.sheets_tab (s).sheet_rows_tab (t_row_ind).delete;
            t_row_ind := workbook.sheets_tab (s).sheet_rows_tab.NEXT (t_row_ind);
         END LOOP;

         workbook.sheets_tab (s).sheet_rows_tab.delete;
         workbook.sheets_tab (s).widths_tab_tab.delete;
         workbook.sheets_tab (s).autofilters_tab.delete;
         workbook.sheets_tab (s).hyperlinks_tab.delete;
         workbook.sheets_tab (s).col_fmts_tab.delete;
         workbook.sheets_tab (s).row_fmts_tab.delete;
         workbook.sheets_tab (s).comments_tab.delete;
         workbook.sheets_tab (s).mergecells_tab.delete;
         workbook.sheets_tab (s).validations_tab.delete;
         workbook.sheets_tab (s).protection_tab.delete;
      END LOOP;

      workbook.strings_tab.delete;
      workbook.str_ind_tab.delete;
      workbook.fonts_tab.delete;
      workbook.fills_tab.delete;
      workbook.borders_tab.delete;
      workbook.numfmts_tab.delete;
      workbook.cellxfs_tab.delete;
      workbook.defined_names_tab.delete;
      workbook := NULL;
   END;

   --
   FUNCTION new_sheet (p_sheetname VARCHAR2 := NULL, p_hidden BOOLEAN := FALSE)
      RETURN PLS_INTEGER
   AS
      t_nr    PLS_INTEGER := workbook.sheets_tab.COUNT + 1;
      t_ind   PLS_INTEGER;
   BEGIN
      workbook.sheets_tab (t_nr).vc_sheet_name :=
         -- PHARTENFELLER(2019/09/18): Cut sheetname when too long (max 31 chars)
         COALESCE (
            SUBSTR( DBMS_XMLGEN.CONVERT (TRANSLATE (p_sheetname, 'a/\[]*:?', 'a')), 1, 31 )
         , 'Sheet' || TO_CHAR (t_nr)
         );

      workbook.sheets_tab (t_nr).hidden := p_hidden;

      IF workbook.strings_tab.COUNT = 0
      THEN
         workbook.pi_str_cnt := 0;
         -- MKLEIN (2014/02/24): Insert NULL into strings on known position
         t_ind := add_string (NULL);
      END IF;

      IF workbook.fonts_tab.COUNT = 0
      THEN
         t_ind := get_font ('Arial');
      END IF;

      IF workbook.fills_tab.COUNT = 0
      THEN
         t_ind := get_fill ('none');
         t_ind := get_fill ('gray125');
      END IF;

      IF workbook.borders_tab.COUNT = 0
      THEN
         t_ind :=
            get_border ('',
                        '',
                        '',
                        '');
      END IF;

      RETURN t_nr;
   END new_sheet;

   PROCEDURE sheet_protection (p_ssp_hash_value VARCHAR2, 
                               p_ssp_salt_value VARCHAR2,
                               p_sheet          PLS_INTEGER)
   AS
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab (t_sheet).hash_value := p_ssp_hash_value;
      workbook.sheets_tab (t_sheet).salt_value := p_ssp_salt_value;
   END sheet_protection;  

   PROCEDURE protected_range (p_name      VARCHAR2,
                              p_tl_col    PLS_INTEGER, -- top left
                              p_tl_row    PLS_INTEGER, 
                              p_br_col    PLS_INTEGER, -- bottom right
                              p_br_row    PLS_INTEGER, 
                              p_sheet     PLS_INTEGER)
   AS                            
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet); 
      t_ind := workbook.sheets_tab (t_sheet).protection_tab.COUNT + 1;
      workbook.sheets_tab (t_sheet).protection_tab (t_ind).vc_name   := p_name;
      workbook.sheets_tab (t_sheet).protection_tab (t_ind).vc_tl_col := alfan_col(p_tl_col);
      workbook.sheets_tab (t_sheet).protection_tab (t_ind).vc_tl_row := to_char(p_tl_row);
      workbook.sheets_tab (t_sheet).protection_tab (t_ind).vc_br_col := alfan_col(p_br_col);
      workbook.sheets_tab (t_sheet).protection_tab (t_ind).vc_br_row := to_char(p_br_row); 
   END protected_range;

   PROCEDURE set_col_width (p_sheet PLS_INTEGER, p_col PLS_INTEGER, p_format VARCHAR2)
   AS
      t_width    NUMBER;
      t_nr_chr   PLS_INTEGER;
   BEGIN
      IF p_format IS NULL
      THEN
         RETURN;
      END IF;

      IF INSTR (p_format, ';') > 0
      THEN
         t_nr_chr := LENGTH (TRANSLATE (SUBSTR (p_format, 1, INSTR (p_format, ';') - 1), 'a\"', 'a'));
      ELSE
         t_nr_chr := LENGTH (TRANSLATE (p_format, 'a\"', 'a'));
      END IF;

      t_width := TRUNC ( (t_nr_chr * 7 + 5) / 7 * 256) / 256;                                             -- assume default 11 point Calibri

      IF workbook.sheets_tab (p_sheet).widths_tab_tab.EXISTS (p_col)
      THEN
         workbook.sheets_tab (p_sheet).widths_tab_tab (p_col) := GREATEST (workbook.sheets_tab (p_sheet).widths_tab_tab (p_col), t_width);
      ELSE
         workbook.sheets_tab (p_sheet).widths_tab_tab (p_col) := GREATEST (t_width, 8.43);
      END IF;
   END set_col_width;


   FUNCTION orafmt2excel (p_format VARCHAR2 := NULL)
      RETURN VARCHAR2
   AS
      t_format   VARCHAR2 (1000) := LOWER (SUBSTR (p_format, 1, 1000));
   BEGIN
      t_format := REPLACE (REPLACE (REPLACE (t_format, 'HH', 'hh'), 'hh24', 'hh'), 'hh12', 'hh');
      t_format := REPLACE (REPLACE (t_format, 'MI', 'mi'), 'mi', 'mm');
      t_format := REPLACE (REPLACE (REPLACE (t_format, 'AM', '~~'), 'PM', '~~'), '~~', 'AM/PM');
      t_format := REPLACE (REPLACE (REPLACE (t_format, 'am', '~~'), 'pm', '~~'), '~~', 'AM/PM');
      t_format := REPLACE (REPLACE (t_format, 'day', 'DAY'), 'DAY', 'dddd');
      t_format := REPLACE (REPLACE (t_format, 'dy', 'DY'), 'DAY', 'ddd');
      t_format := REPLACE (REPLACE (t_format, 'rr', 'RR'), 'RR', 'YY');
      t_format := REPLACE (REPLACE (t_format, 'month', 'MONTH'), 'MONTH', 'mmmm');
      t_format := REPLACE (REPLACE (t_format, 'mon', 'MON'), 'MON', 'mmm');
      RETURN t_format;
   END orafmt2excel;

   FUNCTION oradatetoexcel (p_value IN DATE)
      RETURN NUMBER
   AS
      l_date_diff   NUMBER := 0;
   BEGIN
      IF TRUNC (p_value) >= TO_DATE ('01-01-1900', 'MM-DD-YYYY')
      THEN
         l_date_diff := 2;
      END IF;

      RETURN ( ( p_value - TO_DATE ('01-01-1900', 'MM-DD-YYYY') ) + l_date_diff );
   END oradatetoexcel;

   FUNCTION oranumfmt2excel (p_format VARCHAR2)
      RETURN VARCHAR2
   AS
      l_mso_fmt   VARCHAR2 (255);
   BEGIN
      IF INSTR (p_format, 'D') > 0
      THEN
         l_mso_fmt := '.' || REPLACE (SUBSTR (p_format, INSTR (p_format, 'D') + 1), '9', '0');
      END IF;

      IF INSTR (p_format, 'G') > 0
      THEN
         l_mso_fmt := '#,##0' || l_mso_fmt;
      ELSE
         l_mso_fmt := '0' || l_mso_fmt;
      END IF;

      RETURN l_mso_fmt;
   END oranumfmt2excel;

   FUNCTION get_numfmt (p_format VARCHAR2 := NULL)
      RETURN PLS_INTEGER
   AS
      t_cnt        PLS_INTEGER;
      t_numfmtid   PLS_INTEGER;
   BEGIN
      IF p_format IS NULL
      THEN
         RETURN 0;
      END IF;

      t_cnt := workbook.numfmts_tab.COUNT;

      FOR i IN 1 .. t_cnt
      LOOP
         IF workbook.numfmts_tab (i).vc_formatcode = p_format
         THEN
            t_numfmtid := workbook.numfmts_tab (i).pi_numfmtid;
            EXIT;
         END IF;
      END LOOP;

      IF t_numfmtid IS NULL
      THEN
         t_numfmtid := CASE WHEN t_cnt = 0 THEN 164 ELSE workbook.numfmts_tab (t_cnt).pi_numfmtid + 1 END;
         t_cnt := t_cnt + 1;
         workbook.numfmts_tab (t_cnt).pi_numfmtid := t_numfmtid;
         workbook.numfmts_tab (t_cnt).vc_formatcode := p_format;
         workbook.numfmtindexes_tab (t_numfmtid) := t_cnt;
      END IF;

      RETURN t_numfmtid;
   END get_numfmt;


   FUNCTION get_font (p_name         VARCHAR2,
                      p_family       PLS_INTEGER := 2,
                      p_fontsize     NUMBER := 8,
                      p_theme        PLS_INTEGER := 1,
                      p_underline    BOOLEAN := FALSE,
                      p_italic       BOOLEAN := FALSE,
                      p_bold         BOOLEAN := FALSE,
                      p_rgb          VARCHAR2 := NULL                                            -- this is a hex ALPHA Red Green Blue value
                                                     )
      RETURN PLS_INTEGER
   AS
      t_ind   PLS_INTEGER;
   BEGIN
      IF workbook.fonts_tab.COUNT > 0
      THEN
         FOR f IN 0 .. workbook.fonts_tab.COUNT - 1
         LOOP
            IF (    workbook.fonts_tab (f).vc_font_name = p_name
                AND workbook.fonts_tab (f).pi_family = p_family
                AND workbook.fonts_tab (f).nn_fontsize = p_fontsize
                AND workbook.fonts_tab (f).pi_theme = p_theme
                AND workbook.fonts_tab (f).bo_underline = p_underline
                AND workbook.fonts_tab (f).bo_italic = p_italic
                AND workbook.fonts_tab (f).bo_bold = p_bold
                AND (workbook.fonts_tab (f).vc_rgb = p_rgb OR (workbook.fonts_tab (f).vc_rgb IS NULL AND p_rgb IS NULL)))
            THEN
               RETURN f;
            END IF;
         END LOOP;
      END IF;

      t_ind := workbook.fonts_tab.COUNT;
      workbook.fonts_tab (t_ind).vc_font_name := p_name;
      workbook.fonts_tab (t_ind).pi_family := p_family;
      workbook.fonts_tab (t_ind).nn_fontsize := p_fontsize;
      workbook.fonts_tab (t_ind).pi_theme := p_theme;
      workbook.fonts_tab (t_ind).bo_underline := p_underline;
      workbook.fonts_tab (t_ind).bo_italic := p_italic;
      workbook.fonts_tab (t_ind).bo_bold := p_bold;
      workbook.fonts_tab (t_ind).vc_rgb := p_rgb;
      RETURN t_ind;
   END get_font;

   FUNCTION get_fill (p_patterntype VARCHAR2, p_fgrgb VARCHAR2 := NULL)
      RETURN PLS_INTEGER
   AS
      t_ind   PLS_INTEGER;
   BEGIN
      IF workbook.fills_tab.COUNT > 0
      THEN
         FOR f IN 0 .. workbook.fills_tab.COUNT - 1
         LOOP
            IF (    workbook.fills_tab (f).vc_patterntype = p_patterntype
                AND NVL (workbook.fills_tab (f).vc_fgrgb, 'x') = NVL (UPPER (p_fgrgb), 'x'))
            THEN
               RETURN f;
            END IF;
         END LOOP;
      END IF;

      t_ind := workbook.fills_tab.COUNT;
      workbook.fills_tab (t_ind).vc_patterntype := p_patterntype;
      workbook.fills_tab (t_ind).vc_fgrgb := UPPER (p_fgrgb);
      RETURN t_ind;
   END get_fill;

   FUNCTION get_border (p_top       VARCHAR2 := 'thin',
                        p_bottom    VARCHAR2 := 'thin',
                        p_left      VARCHAR2 := 'thin',
                        p_right     VARCHAR2 := 'thin')
      RETURN PLS_INTEGER
   AS
      t_ind   PLS_INTEGER;
   BEGIN
      IF workbook.borders_tab.COUNT > 0
      THEN
         FOR b IN 0 .. workbook.borders_tab.COUNT - 1
         LOOP
            IF (    NVL (workbook.borders_tab (b).vc_top_border, 'x') = NVL (p_top, 'x')
                AND NVL (workbook.borders_tab (b).vc_bottom_border, 'x') = NVL (p_bottom, 'x')
                AND NVL (workbook.borders_tab (b).vc_left_border, 'x') = NVL (p_left, 'x')
                AND NVL (workbook.borders_tab (b).vc_right_border, 'x') = NVL (p_right, 'x'))
            THEN
               RETURN b;
            END IF;
         END LOOP;
      END IF;

      t_ind := workbook.borders_tab.COUNT;
      workbook.borders_tab (t_ind).vc_top_border := p_top;
      workbook.borders_tab (t_ind).vc_bottom_border := p_bottom;
      workbook.borders_tab (t_ind).vc_left_border := p_left;
      workbook.borders_tab (t_ind).vc_right_border := p_right;
      RETURN t_ind;
   END get_border;

   FUNCTION get_alignment (p_vertical VARCHAR2 := NULL, p_horizontal VARCHAR2 := NULL, p_wraptext BOOLEAN := NULL)
      RETURN t_alignment_rec
   AS
      t_rv   t_alignment_rec;
   BEGIN
      t_rv.vc_vertical := p_vertical;
      t_rv.vc_horizontal := p_horizontal;
      t_rv.bo_wraptext := p_wraptext;
      RETURN t_rv;
   END get_alignment;

   FUNCTION get_xfid (p_sheet        PLS_INTEGER,
                      p_col          PLS_INTEGER,
                      p_row          PLS_INTEGER,
                      p_numfmtid     PLS_INTEGER := NULL,
                      p_fontid       PLS_INTEGER := NULL,
                      p_fillid       PLS_INTEGER := NULL,
                      p_borderid     PLS_INTEGER := NULL,
                      p_alignment    t_alignment_rec := NULL)
      RETURN VARCHAR2
   AS
      t_cnt      PLS_INTEGER;
      t_xfid     PLS_INTEGER;
      t_xf       t_xf_fmt_rec;
      t_col_xf   t_xf_fmt_rec;
      t_row_xf   t_xf_fmt_rec;
   BEGIN

      IF workbook.sheets_tab (p_sheet).col_fmts_tab.EXISTS (p_col)
      THEN
         t_col_xf := workbook.sheets_tab (p_sheet).col_fmts_tab (p_col);
      END IF;

      IF workbook.sheets_tab (p_sheet).row_fmts_tab.EXISTS (p_row)
      THEN
         t_row_xf := workbook.sheets_tab (p_sheet).row_fmts_tab (p_row);
      END IF;

      --apex_debug.info('col: ' || p_col || ' row: ' || p_row || ' p_numfmtid: ' || p_numfmtid || ' col_numfmtid: ' ||  t_col_xf.pi_numfmtid);

      t_xf.pi_numfmtid :=
         COALESCE (p_numfmtid,
                   t_col_xf.pi_numfmtid,
                   t_row_xf.pi_numfmtid,
                   0);
      t_xf.pi_fontid :=
         COALESCE (p_fontid,
                   t_col_xf.pi_fontid,
                   t_row_xf.pi_fontid,
                   0);
      t_xf.pi_fillid :=
         COALESCE (p_fillid,
                   t_col_xf.pi_fillid,
                   t_row_xf.pi_fillid,
                   0);
      t_xf.pi_borderid :=
         COALESCE (p_borderid,
                   t_col_xf.pi_borderid,
                   t_row_xf.pi_borderid,
                   0);
      t_xf.alignment_rec := COALESCE (p_alignment, t_col_xf.alignment_rec, t_row_xf.alignment_rec);

      IF (    t_xf.pi_numfmtid + t_xf.pi_fontid + t_xf.pi_fillid + t_xf.pi_borderid = 0
          AND t_xf.alignment_rec.vc_vertical IS NULL
          AND t_xf.alignment_rec.vc_horizontal IS NULL
          AND NOT NVL (t_xf.alignment_rec.bo_wraptext, FALSE))
      THEN
         RETURN '';
      END IF;

      IF t_xf.pi_numfmtid > 0
      THEN
         set_col_width (p_sheet, p_col, workbook.numfmts_tab (workbook.numfmtindexes_tab (t_xf.pi_numfmtid)).vc_formatcode);
      END IF;

      t_cnt := workbook.cellxfs_tab.COUNT;

      FOR i IN 1 .. t_cnt
      LOOP
         IF (    workbook.cellxfs_tab (i).pi_numfmtid = t_xf.pi_numfmtid
             AND workbook.cellxfs_tab (i).pi_fontid = t_xf.pi_fontid
             AND workbook.cellxfs_tab (i).pi_fillid = t_xf.pi_fillid
             AND workbook.cellxfs_tab (i).pi_borderid = t_xf.pi_borderid
             AND NVL (workbook.cellxfs_tab (i).alignment_rec.vc_vertical, 'x') = NVL (t_xf.alignment_rec.vc_vertical, 'x')
             AND NVL (workbook.cellxfs_tab (i).alignment_rec.vc_horizontal, 'x') = NVL (t_xf.alignment_rec.vc_horizontal, 'x')
             AND NVL (workbook.cellxfs_tab (i).alignment_rec.bo_wraptext, FALSE) = NVL (t_xf.alignment_rec.bo_wraptext, FALSE))
         THEN
            t_xfid := i;
            EXIT;
         END IF;
      END LOOP;

      IF t_xfid IS NULL
      THEN
         t_cnt := t_cnt + 1;
         t_xfid := t_cnt;
         workbook.cellxfs_tab (t_cnt) := t_xf;
      END IF;

      RETURN 's="' || TO_CHAR (t_xfid) || '"';
   END get_xfid;

   PROCEDURE cell (p_col          PLS_INTEGER,
                   p_row          PLS_INTEGER,
                   p_value        NUMBER,
                   p_numfmtid     PLS_INTEGER := NULL,
                   p_fontid       PLS_INTEGER := NULL,
                   p_fillid       PLS_INTEGER := NULL,
                   p_borderid     PLS_INTEGER := NULL,
                   p_alignment    t_alignment_rec := NULL,
                   p_sheet        PLS_INTEGER := NULL)
   AS
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).nn_value_id := p_value;
      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).vc_style_def := NULL;
      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).vc_style_def :=
         get_xfid (t_sheet,
                   p_col,
                   p_row,
                   p_numfmtid,
                   p_fontid,
                   p_fillid,
                   p_borderid,
                   p_alignment);
   END cell;

   PROCEDURE cell (p_col          PLS_INTEGER,
                   p_row          PLS_INTEGER,
                   p_value        VARCHAR2,
                   p_numfmtid     PLS_INTEGER := NULL,
                   p_fontid       PLS_INTEGER := NULL,
                   p_fillid       PLS_INTEGER := NULL,
                   p_borderid     PLS_INTEGER := NULL,
                   p_alignment    t_alignment_rec := NULL,
                   p_sheet        PLS_INTEGER := NULL,
                   p_formula      VARCHAR2 := NULL)
   AS
      t_sheet       PLS_INTEGER;
      t_alignment   t_alignment_rec := p_alignment;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).nn_value_id := add_string (p_value);
      
      --THERWIX(2020/07/06): Allow to add Formulas into a cell
      IF p_formula IS NOT NULL 
      THEN
         workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).formula :=  (p_formula);
      END IF; 

      IF t_alignment.bo_wraptext IS NULL AND INSTR (p_value, CHR (13)) > 0
      THEN
         t_alignment.bo_wraptext := TRUE;
      END IF;

      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).vc_style_def :=
            't="s" '
         || get_xfid (t_sheet,
                      p_col,
                      p_row,
                      p_numfmtid,
                      p_fontid,
                      p_fillid,
                      p_borderid,
                      t_alignment);
   END cell;

   PROCEDURE cell (p_col          PLS_INTEGER,
                   p_row          PLS_INTEGER,
                   p_value        DATE,
                   p_numfmtid     PLS_INTEGER := NULL,
                   p_fontid       PLS_INTEGER := NULL,
                   p_fillid       PLS_INTEGER := NULL,
                   p_borderid     PLS_INTEGER := NULL,
                   p_alignment    t_alignment_rec := NULL,
                   p_sheet        PLS_INTEGER := NULL)
   AS
      t_numfmtid   PLS_INTEGER := p_numfmtid;
      t_sheet      PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);

      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).nn_value_id := oradatetoexcel (p_value);

      IF     t_numfmtid IS NULL
         AND NOT (    workbook.sheets_tab (t_sheet).col_fmts_tab.EXISTS (p_col)
                  AND workbook.sheets_tab (t_sheet).col_fmts_tab (p_col).pi_numfmtid IS NOT NULL)
         AND NOT (    workbook.sheets_tab (t_sheet).row_fmts_tab.EXISTS (p_row)
                  AND workbook.sheets_tab (t_sheet).row_fmts_tab (p_row).pi_numfmtid IS NOT NULL)
      THEN
         t_numfmtid := get_numfmt ('dd/mm/yyyy');
      END IF;

      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).vc_style_def :=
         get_xfid (t_sheet,
                   p_col,
                   p_row,
                   t_numfmtid,
                   p_fontid,
                   p_fillid,
                   p_borderid,
                   p_alignment);
   END cell;

   PROCEDURE hyperlink (p_col      PLS_INTEGER,
                        p_row      PLS_INTEGER,
                        p_url      VARCHAR2,
                        p_value    VARCHAR2 := NULL,
                        p_sheet    PLS_INTEGER := NULL)
   AS
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);

      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).nn_value_id := add_string (NVL (p_value, p_url));
      workbook.sheets_tab (t_sheet).sheet_rows_tab (p_row) (p_col).vc_style_def :=
            't="s" '
         || get_xfid (t_sheet,
                      p_col,
                      p_row,
                      '',
                      get_font ('Calibri', p_theme => 10, p_underline => TRUE));
      t_ind := workbook.sheets_tab (t_sheet).hyperlinks_tab.COUNT + 1;
      workbook.sheets_tab (t_sheet).hyperlinks_tab (t_ind).vc_cell := alfan_col (p_col) || TO_CHAR (p_row);
      workbook.sheets_tab (t_sheet).hyperlinks_tab (t_ind).vc_url := p_url;
   END hyperlink;

   PROCEDURE comment (p_col       PLS_INTEGER,
                      p_row       PLS_INTEGER,
                      p_text      VARCHAR2,
                      p_author    VARCHAR2 := NULL,
                      p_width     PLS_INTEGER := 150,
                      p_height    PLS_INTEGER := 100,
                      p_sheet     PLS_INTEGER := NULL)
   AS
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      t_ind := workbook.sheets_tab (t_sheet).comments_tab.COUNT + 1;
      workbook.sheets_tab (t_sheet).comments_tab (t_ind).pi_row_nr := p_row;
      workbook.sheets_tab (t_sheet).comments_tab (t_ind).pi_column_nr := p_col;
      workbook.sheets_tab (t_sheet).comments_tab (t_ind).vc_text := DBMS_XMLGEN.CONVERT (p_text);
      workbook.sheets_tab (t_sheet).comments_tab (t_ind).vc_author := DBMS_XMLGEN.CONVERT (p_author);
      workbook.sheets_tab (t_sheet).comments_tab (t_ind).pi_width := p_width;
      workbook.sheets_tab (t_sheet).comments_tab (t_ind).pi_height := p_height;
   END comment;

   PROCEDURE mergecells (p_tl_col    PLS_INTEGER                                                                                 -- top left
                                                ,
                         p_tl_row    PLS_INTEGER,
                         p_br_col    PLS_INTEGER                                                                             -- bottom right
                                                ,
                         p_br_row    PLS_INTEGER,
                         p_sheet     PLS_INTEGER := NULL)
   AS
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      t_ind := workbook.sheets_tab (t_sheet).mergecells_tab.COUNT + 1;
      workbook.sheets_tab (t_sheet).mergecells_tab (t_ind) :=
         alfan_col (p_tl_col) || TO_CHAR (p_tl_row) || ':' || alfan_col (p_br_col) || TO_CHAR (p_br_row);
   END mergecells;

   PROCEDURE add_validation (p_type           VARCHAR2,
                             p_sqref          VARCHAR2,
                             p_style          VARCHAR2 := 'stop'                                               -- stop, warning, information
                                                                ,
                             p_formula1       VARCHAR2 := NULL,
                             p_formula2       VARCHAR2 := NULL,
                             p_title          VARCHAR2 := NULL,
                             p_prompt         VARCHAR2 := NULL,
                             p_show_error     BOOLEAN := FALSE,
                             p_error_title    VARCHAR2 := NULL,
                             p_error_txt      VARCHAR2 := NULL,
                             p_sheet          PLS_INTEGER := NULL)
   AS
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      t_ind := workbook.sheets_tab (t_sheet).validations_tab.COUNT + 1;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_validation_type := p_type;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_errorstyle := p_style;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_sqref := p_sqref;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_formula1 := p_formula1;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_formula2 := p_formula2;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_error_title := p_error_title;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_error_txt := p_error_txt;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_title := p_title;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).vc_prompt := p_prompt;
      workbook.sheets_tab (t_sheet).validations_tab (t_ind).bo_showerrormessage := p_show_error;
   END add_validation;

   PROCEDURE list_validation (p_sqref_col      PLS_INTEGER,
                              p_sqref_row      PLS_INTEGER,
                              p_tl_col         PLS_INTEGER                                                                       -- top left
                                                          ,
                              p_tl_row         PLS_INTEGER,
                              p_br_col         PLS_INTEGER                                                                   -- bottom right
                                                          ,
                              p_br_row         PLS_INTEGER,
                              p_style          VARCHAR2 := 'stop'                                              -- stop, warning, information
                                                                 ,
                              p_title          VARCHAR2 := NULL,
                              p_prompt         VARCHAR2 := NULL,
                              p_show_error     BOOLEAN := FALSE,
                              p_error_title    VARCHAR2 := NULL,
                              p_error_txt      VARCHAR2 := NULL,
                              p_sheet          PLS_INTEGER := NULL,
                              p_sheet_datasource PLS_INTEGER := NULL)
   AS
      c_single_quote constant varchar2(1) := '''';
   BEGIN
      -- PHARTENFELLER(2019/09/24): Allow listvalidations with data from a different sheet
      IF p_sheet_datasource IS NULL THEN
         add_validation (
            'list',
            alfan_col (p_sqref_col) || TO_CHAR (p_sqref_row),
            p_style         => LOWER (p_style),
            p_formula1      =>    '$'
                              || alfan_col (p_tl_col)
                              || '$'
                              || TO_CHAR (p_tl_row)
                              || ':$'
                              || alfan_col (p_br_col)
                              || '$'
                              || TO_CHAR (p_br_row),
            p_title         => p_title,
            p_prompt        => p_prompt,
            p_show_error    => p_show_error,
            p_error_title   => p_error_title,
            p_error_txt     => p_error_txt,
            p_sheet         => p_sheet);
      ELSE
         add_validation (
            'list',
            alfan_col (p_sqref_col) || TO_CHAR (p_sqref_row),
            p_style         => LOWER (p_style),
            p_formula1      =>   c_single_quote
                              || workbook.sheets_tab(p_sheet_datasource).vc_sheet_name
                              || c_single_quote
                              || '!$'
                              || alfan_col (p_tl_col)
                              || '$'
                              || TO_CHAR (p_tl_row)
                              || ':$'
                              || alfan_col (p_br_col)
                              || '$'
                              || TO_CHAR (p_br_row),
            p_title         => p_title,
            p_prompt        => p_prompt,
            p_show_error    => p_show_error,
            p_error_title   => p_error_title,
            p_error_txt     => p_error_txt,
            p_sheet         => p_sheet);
      END IF;
   END list_validation;

   PROCEDURE list_validation (p_sqref_col       PLS_INTEGER,
                              p_sqref_row       PLS_INTEGER,
                              p_defined_name    VARCHAR2,
                              p_style           VARCHAR2 := 'stop'                                             -- stop, warning, information
                                                                  ,
                              p_title           VARCHAR2 := NULL,
                              p_prompt          VARCHAR2 := NULL,
                              p_show_error      BOOLEAN := FALSE,
                              p_error_title     VARCHAR2 := NULL,
                              p_error_txt       VARCHAR2 := NULL,
                              p_sheet           PLS_INTEGER := NULL)
   AS
   BEGIN
      add_validation ('list',
                      alfan_col (p_sqref_col) || TO_CHAR (p_sqref_row),
                      p_style         => LOWER (p_style),
                      p_formula1      => p_defined_name,
                      p_title         => p_title,
                      p_prompt        => p_prompt,
                      p_show_error    => p_show_error,
                      p_error_title   => p_error_title,
                      p_error_txt     => p_error_txt,
                      p_sheet         => TO_CHAR (p_sheet));
   END list_validation;

   PROCEDURE defined_name (p_tl_col        PLS_INTEGER                                                                           -- top left
                                                      ,
                           p_tl_row        PLS_INTEGER,
                           p_br_col        PLS_INTEGER                                                                       -- bottom right
                                                      ,
                           p_br_row        PLS_INTEGER,
                           p_name          VARCHAR2,
                           p_sheet         PLS_INTEGER := NULL,
                           p_localsheet    PLS_INTEGER := NULL)
   AS
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      t_ind := workbook.defined_names_tab.COUNT + 1;
      workbook.defined_names_tab (t_ind).vc_defined_name := p_name;
      workbook.defined_names_tab (t_ind).vc_defined_ref :=
            'Sheet'
         || TO_CHAR (t_sheet)
         || '!$'
         || alfan_col (p_tl_col)
         || '$'
         || TO_CHAR (p_tl_row)
         || ':$'
         || alfan_col (p_br_col)
         || '$'
         || TO_CHAR (p_br_row);
      workbook.defined_names_tab (t_ind).pi_sheet := p_localsheet;
   END defined_name;

   PROCEDURE set_column_width (p_col PLS_INTEGER, p_width NUMBER, p_sheet PLS_INTEGER := NULL)
   AS
   BEGIN
      workbook.sheets_tab (NVL (p_sheet, workbook.sheets_tab.COUNT)).widths_tab_tab (p_col) := p_width;
   END set_column_width;

   PROCEDURE set_column (p_col          PLS_INTEGER,
                         p_numfmtid     PLS_INTEGER := NULL,
                         p_fontid       PLS_INTEGER := NULL,
                         p_fillid       PLS_INTEGER := NULL,
                         p_borderid     PLS_INTEGER := NULL,
                         p_alignment    t_alignment_rec := NULL,
                         p_sheet        PLS_INTEGER := NULL)
   AS
      t_sheet   PLS_INTEGER;
      returnVal VARCHAR2(20);

   BEGIN
      t_sheet := get_sheet_id (p_sheet);     
      workbook.sheets_tab (t_sheet).col_fmts_tab (p_col).pi_numfmtid := p_numfmtid;
      workbook.sheets_tab (t_sheet).col_fmts_tab (p_col).pi_fontid := p_fontid;
      workbook.sheets_tab (t_sheet).col_fmts_tab (p_col).pi_fillid := p_fillid;
      workbook.sheets_tab (t_sheet).col_fmts_tab (p_col).pi_borderid := p_borderid;
      workbook.sheets_tab (t_sheet).col_fmts_tab (p_col).alignment_rec := p_alignment;

   END set_column;

   PROCEDURE set_row (p_row          PLS_INTEGER,
                      p_numfmtid     PLS_INTEGER := NULL,
                      p_fontid       PLS_INTEGER := NULL,
                      p_fillid       PLS_INTEGER := NULL,
                      p_borderid     PLS_INTEGER := NULL,
                      p_alignment    t_alignment_rec := NULL,
                      p_sheet        PLS_INTEGER := NULL)
   AS
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab(t_sheet).row_fmts_tab(p_row).pi_numfmtid := p_numfmtid;
      workbook.sheets_tab (t_sheet).row_fmts_tab (p_row).pi_fontid := p_fontid;
      workbook.sheets_tab (t_sheet).row_fmts_tab (p_row).pi_fillid := p_fillid;
      workbook.sheets_tab (t_sheet).row_fmts_tab (p_row).pi_borderid := p_borderid;
      workbook.sheets_tab (t_sheet).row_fmts_tab (p_row).alignment_rec := p_alignment;
   END set_row;

   PROCEDURE freeze_rows (p_nr_rows PLS_INTEGER := 1, p_sheet PLS_INTEGER := NULL)
   AS
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab (t_sheet).pi_freeze_cols := NULL;
      workbook.sheets_tab (t_sheet).pi_freeze_rows := p_nr_rows;
   END freeze_rows;

   PROCEDURE freeze_cols (p_nr_cols PLS_INTEGER := 1, p_sheet PLS_INTEGER := NULL)
   AS
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab (t_sheet).pi_freeze_rows := NULL;
      workbook.sheets_tab (t_sheet).pi_freeze_cols := p_nr_cols;
   END freeze_cols;

   PROCEDURE freeze_pane (p_col PLS_INTEGER, p_row PLS_INTEGER, p_sheet PLS_INTEGER := NULL)
   AS
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      workbook.sheets_tab (t_sheet).pi_freeze_rows := p_row;
      workbook.sheets_tab (t_sheet).pi_freeze_cols := p_col;
   END freeze_pane;

   PROCEDURE set_autofilter (p_column_start    PLS_INTEGER := NULL,
                             p_column_end      PLS_INTEGER := NULL,
                             p_row_start       PLS_INTEGER := NULL,
                             p_row_end         PLS_INTEGER := NULL,
                             p_sheet           PLS_INTEGER := NULL)
   AS
      t_ind     PLS_INTEGER;
      t_sheet   PLS_INTEGER;
   BEGIN
      t_sheet := get_sheet_id (p_sheet);
      t_ind := 1;
      workbook.sheets_tab (t_sheet).autofilters_tab (t_ind).pi_column_start := p_column_start;
      workbook.sheets_tab (t_sheet).autofilters_tab (t_ind).pi_column_end := p_column_end;
      workbook.sheets_tab (t_sheet).autofilters_tab (t_ind).pi_row_start := p_row_start;
      workbook.sheets_tab (t_sheet).autofilters_tab (t_ind).pi_row_end := p_row_end;
      defined_name (p_column_start,
                    p_row_start,
                    p_column_end,
                    p_row_end,
                    '_xlnm._FilterDatabase',
                    t_sheet,
                    t_sheet - 1);
   END set_autofilter;

   FUNCTION finish 
      RETURN BLOB
   AS
      t_excel                      BLOB;
      t_xxx                        CLOB;
      t_tmp                        VARCHAR2 (32767 CHAR);
      t_str                        VARCHAR2 (32767 CHAR);
      t_c                          NUMBER;
      t_h                          NUMBER;
      t_w                          NUMBER;
      t_cw                         NUMBER;
      t_cell                       VARCHAR2 (1000 CHAR);
      t_row_ind                    PLS_INTEGER;
      t_col_min                    PLS_INTEGER;
      t_col_max                    PLS_INTEGER;
      t_col_ind                    PLS_INTEGER;
      t_len                        PLS_INTEGER;
   BEGIN
      DBMS_LOB.createtemporary (t_excel, TRUE);
      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
<Default Extension="xml" ContentType="application/xml"/>
<Default Extension="vml" ContentType="application/vnd.openxmlformats-officedocument.vmlDrawing"/>
<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>');

      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<Override PartName="/xl/worksheets/sheet'
                          || TO_CHAR (s)
                          || '.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '
<Override PartName="/xl/theme/theme1.xml" ContentType="application/vnd.openxmlformats-officedocument.theme+xml"/>
<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>
<Override PartName="/xl/sharedStrings.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sharedStrings+xml"/>
<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
<Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>');

      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         IF workbook.sheets_tab (s).comments_tab.COUNT > 0
         THEN
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<Override PartName="/xl/comments'
                             || TO_CHAR (s)
                             || '.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.comments+xml"/>');
         END IF;
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</Types>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, '[Content_Types].xml', t_xxx);
      t_xxx := NULL;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<dc:creator>'
                       || SYS_CONTEXT ('userenv', 'os_user')
                       || '</dc:creator>
<cp:lastModifiedBy>'
                       || SYS_CONTEXT ('userenv', 'os_user')
                       || '</cp:lastModifiedBy>
<dcterms:created xsi:type="dcterms:W3CDTF">'
                       || TO_CHAR (CURRENT_TIMESTAMP, 'yyyy-mm-dd"T"hh24:mi:ssTZH:TZM')
                       || '</dcterms:created>
<dcterms:modified xsi:type="dcterms:W3CDTF">'
                       || TO_CHAR (CURRENT_TIMESTAMP, 'yyyy-mm-dd"T"hh24:mi:ssTZH:TZM')
                       || '</dcterms:modified>
</cp:coreProperties>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, 'docProps/core.xml', t_xxx);
      t_xxx := NULL;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
<Application>Microsoft Excel</Application>
<DocSecurity>0</DocSecurity>
<HeadingPairs>
<vt:vector size="2" baseType="variant">
<vt:variant>
<vt:lpstr>Worksheets</vt:lpstr>
</vt:variant>
<vt:variant>
<vt:i4>'
                       || TO_CHAR (workbook.sheets_tab.COUNT)
                       || '</vt:i4>  
</vt:variant>
</vt:vector>
</HeadingPairs>
<TitlesOfParts>
<vt:vector size="'
                       || TO_CHAR (workbook.sheets_tab.COUNT)
                       || '" baseType="lpstr">');

      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<vt:lpstr>' || workbook.sheets_tab (s).vc_sheet_name || '</vt:lpstr>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</vt:vector>
</TitlesOfParts>
<AppVersion>14.0300</AppVersion>
</Properties>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, 'docProps/app.xml', t_xxx);
      t_xxx := NULL;
      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>
<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>
<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>
</Relationships>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, '_rels/.rels', t_xxx);
      t_xxx := NULL;
      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
                       || chr(13) || chr(10) 
                       || '<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="x14ac" xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac">');

      IF workbook.numfmts_tab.COUNT > 0
      THEN
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<numFmts count="' || TO_CHAR (workbook.numfmts_tab.COUNT) || '">');

         FOR n IN 1 .. workbook.numfmts_tab.COUNT
         LOOP
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<numFmt numFmtId="'
                             || TO_CHAR (workbook.numfmts_tab (n).pi_numfmtid)
                             || '" formatCode="'
                             || workbook.numfmts_tab (n).vc_formatcode
                             || '"/>');
         END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</numFmts>');
      END IF;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<fonts count="' || TO_CHAR (workbook.fonts_tab.COUNT) || '" x14ac:knownFonts="1">');

      FOR f IN 0 .. workbook.fonts_tab.COUNT - 1
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<font>'
                          || CASE WHEN workbook.fonts_tab (f).bo_bold THEN '<b/>' END
                          || CASE WHEN workbook.fonts_tab (f).bo_italic THEN '<i/>' END
                          || CASE WHEN workbook.fonts_tab (f).bo_underline THEN '<u/>' END
                          || '<sz val="'
                          || TO_CHAR (workbook.fonts_tab (f).nn_fontsize, 'TM9', 'NLS_NUMERIC_CHARACTERS=.,')
                          || '"/>
                             <color '
                          || CASE
                                WHEN workbook.fonts_tab (f).vc_rgb IS NOT NULL THEN 'rgb="' || workbook.fonts_tab (f).vc_rgb
                                ELSE 'theme="' || TO_CHAR (workbook.fonts_tab (f).pi_theme)
                             END
                          || '"/>
                             <name val="'
                          || workbook.fonts_tab (f).vc_font_name
                          || '"/>
                             <family val="'
                          || TO_CHAR (workbook.fonts_tab (f).pi_family)
                          || '"/>
                             <scheme val="none"/>
                             </font>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</fonts><fills count="' || TO_CHAR (workbook.fills_tab.COUNT) || '">');

      FOR f IN 0 .. workbook.fills_tab.COUNT - 1
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<fill><patternFill patternType="'
                          || workbook.fills_tab (f).vc_patterntype
                          || '">'
                          || CASE WHEN workbook.fills_tab (f).vc_fgrgb IS NOT NULL THEN '<fgColor rgb="' || workbook.fills_tab (f).vc_fgrgb || '"/>' END
                          || '</patternFill></fill>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</fills>
<borders count="' || TO_CHAR (workbook.borders_tab.COUNT) || '">');

      FOR b IN 0 .. workbook.borders_tab.COUNT - 1
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<border>'
                          || CASE
                                WHEN workbook.borders_tab (b).vc_left_border IS NULL THEN '<left/>'
                                ELSE '<left style="' || workbook.borders_tab (b).vc_left_border || '"/>'
                             END
                          || CASE
                                WHEN workbook.borders_tab (b).vc_right_border IS NULL THEN '<right/>'
                                ELSE '<right style="' || workbook.borders_tab (b).vc_right_border || '"/>'
                             END
                          || CASE
                                WHEN workbook.borders_tab (b).vc_top_border IS NULL THEN '<top/>'
                                ELSE '<top style="' || workbook.borders_tab (b).vc_top_border || '"/>'
                             END
                          || CASE
                                WHEN workbook.borders_tab (b).vc_bottom_border IS NULL THEN '<bottom/>'
                                ELSE '<bottom style="' || workbook.borders_tab (b).vc_bottom_border || '"/>'
                             END
                          || '</border>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</borders>

<cellStyleXfs count="1">
<xf numFmtId="0" fontId="0" fillId="0" borderId="0" />
</cellStyleXfs>
<cellXfs count="' || (workbook.cellxfs_tab.COUNT() + 1) || '">
<xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="1" />');
      FOR x IN 1 .. workbook.cellxfs_tab.COUNT
      LOOP
      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<xf numFmtId="'
                       --|| '0' --TO_CHAR (workbook.cellxfs_tab (x).pi_numfmtid)
                       || TO_CHAR (workbook.cellxfs_tab (x).pi_numfmtid)
                       || '" fontId="'
                       || TO_CHAR (workbook.cellxfs_tab (x).pi_fontid)
                       || '" fillId="'
                       || TO_CHAR (workbook.cellxfs_tab (x).pi_fillid)
                       || '" borderId="'
                       || TO_CHAR (workbook.cellxfs_tab (x).pi_borderid)
                       || '">');                    

       IF (   workbook.cellxfs_tab (x).alignment_rec.vc_horizontal IS NOT NULL
             OR workbook.cellxfs_tab (x).alignment_rec.vc_vertical IS NOT NULL
             OR workbook.cellxfs_tab (x).alignment_rec.bo_wraptext)
         THEN
      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<alignment'
                       || CASE
                             WHEN workbook.cellxfs_tab (x).alignment_rec.vc_horizontal IS NOT NULL
                             THEN ' horizontal="' || workbook.cellxfs_tab (x).alignment_rec.vc_horizontal || '"'
                          END
                       || CASE
                             WHEN workbook.cellxfs_tab (x).alignment_rec.vc_vertical IS NOT NULL
                             THEN ' vertical="' || workbook.cellxfs_tab (x).alignment_rec.vc_vertical || '"'
                          END
                       || CASE WHEN workbook.cellxfs_tab (x).alignment_rec.bo_wraptext
                               THEN ' wrapText="true"'
                          END
                       || '/>');
         END IF;

         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '</xf>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</cellXfs>
<cellStyles count="1">
<cellStyle name="Normal" xfId="0" builtinId="0"/>
</cellStyles>                      
<dxfs count="0"/>
<tableStyles count="0" defaultTableStyle="TableStyleMedium2" defaultPivotStyle="PivotStyleLight16"/>
<extLst>
<ext uri="{EB79DEF2-80B8-43e5-95BD-54CBDDF9020C}" xmlns:x14="http://schemas.microsoft.com/office/spreadsheetml/2009/9/main">
<x14:slicerStyles defaultSlicerStyle="SlicerStyleLight1"/>
</ext>
</extLst>
</styleSheet>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, 'xl/styles.xml', t_xxx);
      t_xxx := NULL;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
<fileVersion appName="xl" lastEdited="5" lowestEdited="5" rupBuild="9302"/>
<workbookPr date1904="false" defaultThemeVersion="124226"/>
<bookViews>
<workbookView xWindow="120" yWindow="45" windowWidth="19155" windowHeight="4935"/>
</bookViews>
<sheets>');

      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         -- PHARTENFELLER(2019/09/23) added option to hide sheet
         IF NOT workbook.sheets_tab (s).hidden then
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<sheet name="'
                           || workbook.sheets_tab (s).vc_sheet_name
                           || '" sheetId="'
                           || TO_CHAR (s)
                           || '" r:id="rId'
                           || TO_CHAR (9 + s)
                           || '"/>');
         ELSE
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<sheet name="'
                           || workbook.sheets_tab (s).vc_sheet_name
                           || '" sheetId="'
                           || TO_CHAR (s)
                           || '" state="hidden" '
                           || 'r:id="rId'
                           || TO_CHAR (9 + s)
                           || '"/>');
         END IF;
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</sheets>');

      IF workbook.defined_names_tab.COUNT > 0
      THEN
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<definedNames>');

         FOR s IN 1 .. workbook.defined_names_tab.COUNT
         LOOP
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<definedName name="'
                             || workbook.defined_names_tab (s).vc_defined_name
                             || '"'
                             || CASE
                                   WHEN workbook.defined_names_tab (s).pi_sheet IS NOT NULL
                                   THEN ' localSheetId="' || TO_CHAR (workbook.defined_names_tab (s).pi_sheet) || '"'
                                END
                             || '>'
                             || workbook.defined_names_tab (s).vc_defined_ref
                             || '</definedName>');
         END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</definedNames>');
      END IF;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<calcPr calcId="144525"/></workbook>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, 'xl/workbook.xml', t_xxx);
      t_xxx := NULL;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<a:theme xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" name="Office Theme">
<a:themeElements>
<a:clrScheme name="Office">
<a:dk1>
<a:sysClr val="windowText" lastClr="000000"/>
</a:dk1>
<a:lt1>
<a:sysClr val="window" lastClr="FFFFFF"/>
</a:lt1>
<a:dk2>
<a:srgbClr val="1F497D"/>
</a:dk2>
<a:lt2>
<a:srgbClr val="EEECE1"/>
</a:lt2>
<a:accent1>
<a:srgbClr val="4F81BD"/>
</a:accent1>
<a:accent2>
<a:srgbClr val="C0504D"/>
</a:accent2>
<a:accent3>
<a:srgbClr val="9BBB59"/>
</a:accent3>
<a:accent4>
<a:srgbClr val="8064A2"/>
</a:accent4>
<a:accent5>
<a:srgbClr val="4BACC6"/>
</a:accent5>
<a:accent6>
<a:srgbClr val="F79646"/>
</a:accent6>
<a:hlink>
<a:srgbClr val="0000FF"/>
</a:hlink>
<a:folHlink>
<a:srgbClr val="800080"/>
</a:folHlink>
</a:clrScheme>
<a:fontScheme name="Office">
<a:majorFont>
<a:latin typeface="Cambria"/>
<a:ea typeface=""/>
<a:cs typeface=""/>
<a:font script="Jpan" typeface="MS P????"/>
<a:font script="Hang" typeface="?? ??"/>
<a:font script="Hans" typeface="??"/>
<a:font script="Hant" typeface="????"/>
<a:font script="Arab" typeface="Times New Roman"/>
<a:font script="Hebr" typeface="Times New Roman"/>
<a:font script="Thai" typeface="Tahoma"/>
<a:font script="Ethi" typeface="Nyala"/>
<a:font script="Beng" typeface="Vrinda"/>
<a:font script="Gujr" typeface="Shruti"/>
<a:font script="Khmr" typeface="MoolBoran"/>
<a:font script="Knda" typeface="Tunga"/>
<a:font script="Guru" typeface="Raavi"/>
<a:font script="Cans" typeface="Euphemia"/>
<a:font script="Cher" typeface="Plantagenet Cherokee"/>
<a:font script="Yiii" typeface="Microsoft Yi Baiti"/>
<a:font script="Tibt" typeface="Microsoft Himalaya"/>
<a:font script="Thaa" typeface="MV Boli"/>
<a:font script="Deva" typeface="Mangal"/>
<a:font script="Telu" typeface="Gautami"/>
<a:font script="Taml" typeface="Latha"/>
<a:font script="Syrc" typeface="Estrangelo Edessa"/>
<a:font script="Orya" typeface="Kalinga"/>
<a:font script="Mlym" typeface="Kartika"/>
<a:font script="Laoo" typeface="DokChampa"/>
<a:font script="Sinh" typeface="Iskoola Pota"/>
<a:font script="Mong" typeface="Mongolian Baiti"/>
<a:font script="Viet" typeface="Times New Roman"/>
<a:font script="Uigh" typeface="Microsoft Uighur"/>
<a:font script="Geor" typeface="Sylfaen"/>
</a:majorFont>
<a:minorFont>
<a:latin typeface="Calibri"/>
<a:ea typeface=""/>
<a:cs typeface=""/>
<a:font script="Jpan" typeface="MS P????"/>
<a:font script="Hang" typeface="?? ??"/>
<a:font script="Hans" typeface="??"/>
<a:font script="Hant" typeface="????"/>
<a:font script="Arab" typeface="Arial"/>
<a:font script="Hebr" typeface="Arial"/>
<a:font script="Thai" typeface="Tahoma"/>
<a:font script="Ethi" typeface="Nyala"/>
<a:font script="Beng" typeface="Vrinda"/>
<a:font script="Gujr" typeface="Shruti"/>
<a:font script="Khmr" typeface="DaunPenh"/>
<a:font script="Knda" typeface="Tunga"/>
<a:font script="Guru" typeface="Raavi"/>
<a:font script="Cans" typeface="Euphemia"/>
<a:font script="Cher" typeface="Plantagenet Cherokee"/>
<a:font script="Yiii" typeface="Microsoft Yi Baiti"/>
<a:font script="Tibt" typeface="Microsoft Himalaya"/>
<a:font script="Thaa" typeface="MV Boli"/>
<a:font script="Deva" typeface="Mangal"/>
<a:font script="Telu" typeface="Gautami"/>
<a:font script="Taml" typeface="Latha"/>
<a:font script="Syrc" typeface="Estrangelo Edessa"/>
<a:font script="Orya" typeface="Kalinga"/>
<a:font script="Mlym" typeface="Kartika"/>
<a:font script="Laoo" typeface="DokChampa"/>
<a:font script="Sinh" typeface="Iskoola Pota"/>
<a:font script="Mong" typeface="Mongolian Baiti"/>
<a:font script="Viet" typeface="Arial"/>
<a:font script="Uigh" typeface="Microsoft Uighur"/>
<a:font script="Geor" typeface="Sylfaen"/>
</a:minorFont>
</a:fontScheme>
<a:fmtScheme name="Office">
<a:fillStyleLst>
<a:solidFill>
<a:schemeClr val="phClr"/>
</a:solidFill>
<a:gradFill rotWithShape="1">
<a:gsLst>
<a:gs pos="0">
<a:schemeClr val="phClr">
<a:tint val="50000"/>
<a:satMod val="300000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="35000">
<a:schemeClr val="phClr">
<a:tint val="37000"/>
<a:satMod val="300000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="100000">
<a:schemeClr val="phClr">
<a:tint val="15000"/>
<a:satMod val="350000"/>
</a:schemeClr>
</a:gs>
</a:gsLst>
<a:lin ang="16200000" scaled="1"/>
</a:gradFill>
<a:gradFill rotWithShape="1">
<a:gsLst>
<a:gs pos="0">
<a:schemeClr val="phClr">
<a:shade val="51000"/>
<a:satMod val="130000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="80000">
<a:schemeClr val="phClr">
<a:shade val="93000"/>
<a:satMod val="130000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="100000">
<a:schemeClr val="phClr">
<a:shade val="94000"/>
<a:satMod val="135000"/>
</a:schemeClr>
</a:gs>
</a:gsLst>
<a:lin ang="16200000" scaled="0"/>
</a:gradFill>
</a:fillStyleLst>
<a:lnStyleLst>
<a:ln w="9525" cap="flat" cmpd="sng" algn="ctr">
<a:solidFill>
<a:schemeClr val="phClr">
<a:shade val="95000"/>
<a:satMod val="105000"/>
</a:schemeClr>
</a:solidFill>
<a:prstDash val="solid"/>
</a:ln>
<a:ln w="25400" cap="flat" cmpd="sng" algn="ctr">
<a:solidFill>
<a:schemeClr val="phClr"/>
</a:solidFill>
<a:prstDash val="solid"/>
</a:ln>
<a:ln w="38100" cap="flat" cmpd="sng" algn="ctr">
<a:solidFill>
<a:schemeClr val="phClr"/>
</a:solidFill>
<a:prstDash val="solid"/>
</a:ln>
</a:lnStyleLst>
<a:effectStyleLst>
<a:effectStyle>
<a:effectLst>
<a:outerShdw blurRad="40000" dist="20000" dir="5400000" rotWithShape="0">
<a:srgbClr val="000000">
<a:alpha val="38000"/>
</a:srgbClr>
</a:outerShdw>
</a:effectLst>
</a:effectStyle>
<a:effectStyle>
<a:effectLst>
<a:outerShdw blurRad="40000" dist="23000" dir="5400000" rotWithShape="0">
<a:srgbClr val="000000">
<a:alpha val="35000"/>
</a:srgbClr>
</a:outerShdw>
</a:effectLst>
</a:effectStyle>
<a:effectStyle>
<a:effectLst>
<a:outerShdw blurRad="40000" dist="23000" dir="5400000" rotWithShape="0">
<a:srgbClr val="000000">
<a:alpha val="35000"/>
</a:srgbClr>
</a:outerShdw>
</a:effectLst>
<a:scene3d>
<a:camera prst="orthographicFront">
<a:rot lat="0" lon="0" rev="0"/>
</a:camera>
<a:lightRig rig="threePt" dir="t">
<a:rot lat="0" lon="0" rev="1200000"/>
</a:lightRig>
</a:scene3d>
<a:sp3d>
<a:bevelT w="63500" h="25400"/>
</a:sp3d>
</a:effectStyle>
</a:effectStyleLst>
<a:bgFillStyleLst>
<a:solidFill>
<a:schemeClr val="phClr"/>
</a:solidFill>
<a:gradFill rotWithShape="1">
<a:gsLst>
<a:gs pos="0">
<a:schemeClr val="phClr">
<a:tint val="40000"/>
<a:satMod val="350000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="40000">
<a:schemeClr val="phClr">
<a:tint val="45000"/>
<a:shade val="99000"/>
<a:satMod val="350000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="100000">
<a:schemeClr val="phClr">
<a:shade val="20000"/>
<a:satMod val="255000"/>
</a:schemeClr>
</a:gs>
</a:gsLst>
<a:path path="circle">
<a:fillToRect l="50000" t="-80000" r="50000" b="180000"/>
</a:path>
</a:gradFill>
<a:gradFill rotWithShape="1">
<a:gsLst>
<a:gs pos="0">
<a:schemeClr val="phClr">
<a:tint val="80000"/>
<a:satMod val="300000"/>
</a:schemeClr>
</a:gs>
<a:gs pos="100000">
<a:schemeClr val="phClr">
<a:shade val="30000"/>
<a:satMod val="200000"/>
</a:schemeClr>
</a:gs>
</a:gsLst>
<a:path path="circle">
<a:fillToRect l="50000" t="50000" r="50000" b="50000"/>
</a:path>
</a:gradFill>
</a:bgFillStyleLst>
</a:fmtScheme>
</a:themeElements>
<a:objectDefaults/>
<a:extraClrSchemeLst/>
</a:theme>',
         p_eof =>         TRUE);
      zip_util_pkg.add_file (t_excel, 'xl/theme/theme1.xml', t_xxx);
      t_xxx := NULL;

      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         t_col_min := 16384;
         t_col_max := 1;
         t_row_ind := workbook.sheets_tab (s).sheet_rows_tab.FIRST;

         WHILE t_row_ind IS NOT NULL
         LOOP
            t_col_min := LEAST (t_col_min, workbook.sheets_tab (s).sheet_rows_tab (t_row_ind).FIRST);
            t_col_max := GREATEST (t_col_max, workbook.sheets_tab (s).sheet_rows_tab (t_row_ind).LAST);
            t_row_ind := workbook.sheets_tab (s).sheet_rows_tab.NEXT (t_row_ind);
         END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:xdr="http://schemas.openxmlformats.org/drawingml/2006/spreadsheetDrawing" xmlns:x14="http://schemas.microsoft.com/office/spreadsheetml/2009/9/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="x14ac" xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac">
<dimension ref="'
                       || alfan_col (t_col_min)
                       || workbook.sheets_tab (s).sheet_rows_tab.FIRST
                       || ':'
                       || alfan_col (t_col_max)
                       || workbook.sheets_tab (s).sheet_rows_tab.LAST
                       || '"/>
<sheetViews>
<sheetView'
                       || CASE WHEN s = 1 THEN ' tabSelected="1"' END
                       || ' workbookViewId="0">');

         IF workbook.sheets_tab (s).pi_freeze_rows > 0 AND workbook.sheets_tab (s).pi_freeze_cols > 0
         THEN
      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<pane xSplit="'
                        || TO_CHAR (workbook.sheets_tab (s).pi_freeze_cols)
                        || '" '
                        || 'ySplit="'
                        || TO_CHAR (workbook.sheets_tab (s).pi_freeze_rows)
                        || '" '
                        || 'topLeftCell="'
                        || alfan_col (workbook.sheets_tab (s).pi_freeze_cols + 1)
                        || TO_CHAR (workbook.sheets_tab (s).pi_freeze_rows + 1)
                        || '" '
                        || 'activePane="bottomLeft" state="frozen"/>');
         ELSE
            IF workbook.sheets_tab (s).pi_freeze_rows > 0
            THEN
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<pane ySplit="'
                                || TO_CHAR (workbook.sheets_tab (s).pi_freeze_rows)
                                || '" topLeftCell="A'
                                || TO_CHAR (workbook.sheets_tab (s).pi_freeze_rows + 1)
                                || '" activePane="bottomLeft" state="frozen"/>');
            END IF;

            IF workbook.sheets_tab (s).pi_freeze_cols > 0
            THEN
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<pane xSplit="'
                                || TO_CHAR (workbook.sheets_tab (s).pi_freeze_cols)
                                || '" topLeftCell="'
                                || alfan_col (workbook.sheets_tab (s).pi_freeze_cols + 1)
                                || '1" activePane="bottomLeft" state="frozen"/>');
            END IF;
         END IF;

         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '</sheetView>
</sheetViews>
<sheetFormatPr defaultRowHeight="15" x14ac:dyDescent="0.25"/>');

         IF workbook.sheets_tab (s).widths_tab_tab.COUNT > 0
         THEN
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<cols>');
            t_col_ind := workbook.sheets_tab (s).widths_tab_tab.FIRST;

            WHILE t_col_ind IS NOT NULL
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<col min="'
                                || TO_CHAR (t_col_ind)
                                || '" max="'
                                || TO_CHAR (t_col_ind)
                                || '" width="'
                                || TO_CHAR (workbook.sheets_tab (s).widths_tab_tab (t_col_ind), 'TM9', 'NLS_NUMERIC_CHARACTERS=.,')
                                || '" customWidth="1"/>');
               t_col_ind := workbook.sheets_tab (s).widths_tab_tab.NEXT (t_col_ind);
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</cols>');
         END IF;

         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<sheetData>');
         t_row_ind := workbook.sheets_tab (s).sheet_rows_tab.FIRST;

         WHILE t_row_ind IS NOT NULL
         LOOP
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<row r="' || t_row_ind || '" spans="' || TO_CHAR (t_col_min) || ':' || TO_CHAR (t_col_max) || '">');
            t_col_ind := workbook.sheets_tab (s).sheet_rows_tab (t_row_ind).FIRST;

            WHILE t_col_ind IS NOT NULL
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<c r="'
                                || alfan_col (t_col_ind)
                                || TO_CHAR (t_row_ind)
                                || '"'
                                || ' '
                                || workbook.sheets_tab (s).sheet_rows_tab (t_row_ind) (t_col_ind).vc_style_def
                                || '> '		       		                                
                                || CASE WHEN workbook.sheets_tab (s).sheet_rows_tab (t_row_ind) (t_col_ind).formula IS NOT NULL THEN '<f>'
                                || TO_CHAR (workbook.sheets_tab (s).sheet_rows_tab (t_row_ind) (t_col_ind).formula)
                                || '</f>' END
                                || '<v>'
                                || TO_CHAR (workbook.sheets_tab (s).sheet_rows_tab (t_row_ind) (t_col_ind).nn_value_id,
                                            'TM9',
                                            'NLS_NUMERIC_CHARACTERS=.,')
                                || '</v></c>');

               t_col_ind := workbook.sheets_tab (s).sheet_rows_tab (t_row_ind).NEXT (t_col_ind);
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</row>');
            t_row_ind := workbook.sheets_tab (s).sheet_rows_tab.NEXT (t_row_ind);
         END LOOP;

         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '</sheetData>');

         IF workbook.sheets_tab (s).hash_value is not null and workbook.sheets_tab (s).salt_value is not null 
         THEN     
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<sheetProtection sheet="1" algorithmName="SHA-512" hashValue="' 
                              || workbook.sheets_tab (s).hash_value 
                              || '" saltValue="' 
                              || workbook.sheets_tab (s).salt_value 
                              || '" spinCount="100000" objects="1" scenarios="1" />');
         END IF;                                   

         IF workbook.sheets_tab (s).protection_tab.COUNT > 0  
         THEN    
            clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<protectedRanges>');

            FOR p in 1 .. workbook.sheets_tab (s).protection_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '   <protectedRange sqref="' 
                                 || workbook.sheets_tab (s).protection_tab (p).vc_tl_col
                                 || workbook.sheets_tab (s).protection_tab (p).vc_tl_row 
                                 || ':' 
                                 || workbook.sheets_tab (s).protection_tab (p).vc_br_col 
                                 || workbook.sheets_tab (s).protection_tab (p).vc_br_row 
                                 || '" name="'
                                 || workbook.sheets_tab (s).protection_tab (p).vc_name
                                 || '" />');
            END LOOP;  

            clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '</protectedRanges>');                   
         END IF;   

         FOR a IN 1 .. workbook.sheets_tab (s).autofilters_tab.COUNT
         LOOP
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<autoFilter ref="'
                             || alfan_col (NVL (workbook.sheets_tab (s).autofilters_tab (A).pi_column_start, t_col_min))
                             || TO_CHAR (NVL (workbook.sheets_tab (s).autofilters_tab (a).pi_row_start, workbook.sheets_tab (s).sheet_rows_tab.FIRST))
                             || ':'
                             || alfan_col (
                                   COALESCE (workbook.sheets_tab (s).autofilters_tab (a).pi_column_end,
                                             workbook.sheets_tab (s).autofilters_tab (a).pi_column_start,
                                             t_col_max))
                             || TO_CHAR (NVL (workbook.sheets_tab (s).autofilters_tab (A).pi_row_end, workbook.sheets_tab (s).sheet_rows_tab.LAST))
                             || '"/>');
         END LOOP;

         IF workbook.sheets_tab (s).mergecells_tab.COUNT > 0
         THEN
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<mergeCells count="' || TO_CHAR (workbook.sheets_tab (s).mergecells_tab.COUNT) || '">');

            FOR m IN 1 .. workbook.sheets_tab (s).mergecells_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<mergeCell ref="' || workbook.sheets_tab (s).mergecells_tab (m) || '"/>');
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</mergeCells>');
         END IF;

         IF workbook.sheets_tab (s).validations_tab.COUNT > 0
         THEN
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<dataValidations count="' || TO_CHAR (workbook.sheets_tab (s).validations_tab.COUNT) || '">');

            FOR m IN 1 .. workbook.sheets_tab (s).validations_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<dataValidation'
                                || ' type="'
                                || workbook.sheets_tab (s).validations_tab (m).vc_validation_type
                                || '"'
                                || ' errorStyle="'
                                || workbook.sheets_tab (s).validations_tab (m).vc_errorstyle
                                || '"'
                                || ' allowBlank="'
                                || CASE WHEN NVL (workbook.sheets_tab (s).validations_tab (m).bo_allowblank, TRUE) THEN '1' ELSE '0' END
                                || '"'
                                || ' sqref="'
                                || workbook.sheets_tab (s).validations_tab (m).vc_sqref
                                || '"');

               IF workbook.sheets_tab (s).validations_tab (m).vc_prompt IS NOT NULL
               THEN
                  clob_vc_concat(
                     p_clob        => t_xxx,
                     p_vc_buffer   => t_tmp,
                     p_vc_addition => ' showInputMessage="1" prompt="'
                                   || workbook.sheets_tab (s).validations_tab (m).vc_prompt 
                                   || '"');

                  IF workbook.sheets_tab (s).validations_tab (m).vc_title IS NOT NULL
                  THEN
                     clob_vc_concat(
                        p_clob        => t_xxx,
                        p_vc_buffer   => t_tmp,
                        p_vc_addition => ' promptTitle="'
                                      || workbook.sheets_tab (s).validations_tab (m).vc_title
                                      || '"');
                  END IF;
               END IF;

               IF workbook.sheets_tab (s).validations_tab (m).bo_showerrormessage
               THEN
                  clob_vc_concat(
                     p_clob        => t_xxx,
                     p_vc_buffer   => t_tmp,
                     p_vc_addition => ' showErrorMessage="1"');

                  IF workbook.sheets_tab (s).validations_tab (m).vc_error_title IS NOT NULL
                  THEN
                     clob_vc_concat(
                        p_clob        => t_xxx,
                        p_vc_buffer   => t_tmp,
                        p_vc_addition => ' errorTitle="' 
                                      || workbook.sheets_tab (s).validations_tab (m).vc_error_title 
                                      || '"');
                  END IF;

                  IF workbook.sheets_tab (s).validations_tab (m).vc_error_txt IS NOT NULL
                  THEN
                     clob_vc_concat(
                        p_clob        => t_xxx,
                        p_vc_buffer   => t_tmp,
                        p_vc_addition => ' error="' 
                                      || workbook.sheets_tab (s).validations_tab (m).vc_error_txt 
                                      || '"');
                  END IF;
               END IF;

               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '>');

               IF workbook.sheets_tab (s).validations_tab (m).vc_formula1 IS NOT NULL
               THEN
                  clob_vc_concat(
                     p_clob        => t_xxx,
                     p_vc_buffer   => t_tmp,
                     p_vc_addition => '<formula1>' 
                                   || workbook.sheets_tab (s).validations_tab (m).vc_formula1 
                                   || '</formula1>');
               END IF;

               IF workbook.sheets_tab (s).validations_tab (m).vc_formula2 IS NOT NULL
               THEN
                  clob_vc_concat(
                     p_clob        => t_xxx,
                     p_vc_buffer   => t_tmp,
                     p_vc_addition => '<formula2>' 
                                   || workbook.sheets_tab (s).validations_tab (m).vc_formula2
                                   || '</formula2>');
               END IF;

               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '</dataValidation>');
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</dataValidations>');
         END IF;

         IF workbook.sheets_tab (s).hyperlinks_tab.COUNT > 0
         THEN
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<hyperlinks>');

            FOR h IN 1 .. workbook.sheets_tab (s).hyperlinks_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<hyperlink ref="'
                                || workbook.sheets_tab (s).hyperlinks_tab (h).vc_cell
                                || '" r:id="rId'
                                || TO_CHAR (h)
                                || '"/>');
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</hyperlinks>');
         END IF;

         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<pageMargins left="0.7" right="0.7" top="0.75" bottom="0.75" header="0.3" footer="0.3"/>');

         IF workbook.sheets_tab (s).comments_tab.COUNT > 0
         THEN
            -- AMEI, 20141129 Bugfix for
            -- t_xxx := t_xxx || '<legacyDrawing r:id="rId' || (workbook.sheets_tab (s).hyperlinks_tab.COUNT + 1) || '"/>';
            -- Raised ORA-06502: PL/SQL: numerischer oder Wertefehler,
            -- occurs when a at least on column has a Help Text,
            -- occurs NOT when NONE column has a Help Text at all.
            -- Bugfix by explicit conversion TO_CHAR(...)
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<legacyDrawing r:id="rId' 
                             || TO_CHAR (workbook.sheets_tab (s).hyperlinks_tab.COUNT + 1) 
                             || '"/>');
         END IF;

         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '</worksheet>',
            p_eof         => TRUE);
         zip_util_pkg.add_file (t_excel, 'xl/worksheets/sheet' || TO_CHAR (s) || '.xml', t_xxx);
         t_xxx := NULL;

         IF workbook.sheets_tab (s).hyperlinks_tab.COUNT > 0 OR workbook.sheets_tab (s).comments_tab.COUNT > 0
         THEN
            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">');

            IF workbook.sheets_tab (s).comments_tab.COUNT > 0
            THEN
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<Relationship Id="rId'
                                || TO_CHAR (workbook.sheets_tab (s).hyperlinks_tab.COUNT + 2)
                                || '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/comments" Target="../comments'
                                || s
                                || '.xml"/>');
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<Relationship Id="rId'
                                || TO_CHAR (workbook.sheets_tab (s).hyperlinks_tab.COUNT + 1)
                                || '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/vmlDrawing" Target="../drawings/vmlDrawing'
                                || TO_CHAR (s)
                                || '.vml"/>');
            END IF;

            FOR h IN 1 .. workbook.sheets_tab (s).hyperlinks_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<Relationship Id="rId'
                                || TO_CHAR (h)
                                || '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="'
                                || workbook.sheets_tab (s).hyperlinks_tab (h).vc_url
                                || '" TargetMode="External"/>');
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</Relationships>',
               p_eof         => TRUE);
            zip_util_pkg.add_file (t_excel, 'xl/worksheets/_rels/sheet' || TO_CHAR (s) || '.xml.rels', t_xxx);
            t_xxx := NULL;
         END IF;

         IF workbook.sheets_tab (s).comments_tab.COUNT > 0
         THEN
            DECLARE
               cnt          PLS_INTEGER;
               author_ind   st_author;
            BEGIN
               gv_authors_tab.delete;

               FOR c IN 1 .. workbook.sheets_tab (s).comments_tab.COUNT
               LOOP
                  gv_authors_tab (workbook.sheets_tab (s).comments_tab (c).vc_author) := 0;
               END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<comments xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
<authors>');
               cnt := 0;
               author_ind := gv_authors_tab.FIRST;

               WHILE author_ind IS NOT NULL OR gv_authors_tab.NEXT (author_ind) IS NOT NULL
               LOOP
                  gv_authors_tab (author_ind) := cnt;
                  clob_vc_concat(
                     p_clob        => t_xxx,
                     p_vc_buffer   => t_tmp,
                     p_vc_addition => '<author>' || author_ind || '</author>');
                  cnt := cnt + 1;
                  author_ind := gv_authors_tab.NEXT (author_ind);
               END LOOP;
            END;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</authors><commentList>');

            FOR c IN 1 .. workbook.sheets_tab (s).comments_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<comment ref="'
                                || alfan_col (workbook.sheets_tab (s).comments_tab (c).pi_column_nr)
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_row_nr)
                                || '" authorId="'
                                || gv_authors_tab (workbook.sheets_tab (s).comments_tab (c).vc_author)
                                || '"><text>');

               IF workbook.sheets_tab (s).comments_tab (c).vc_author IS NOT NULL
               THEN
                  clob_vc_concat(
                     p_clob        => t_xxx,
                     p_vc_buffer   => t_tmp,
                     p_vc_addition => '<r><rPr><b/><sz val="9"/><color indexed="81"/><rFont val="Tahoma"/><charset val="1"/></rPr><t xml:space="preserve">'
                                   || workbook.sheets_tab (s).comments_tab (c).vc_author
                                   || ':</t></r>');
               END IF;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<r><rPr><sz val="9"/><color indexed="81"/><rFont val="Tahoma"/><charset val="1"/></rPr><t xml:space="preserve">'
                             || CASE WHEN workbook.sheets_tab (s).comments_tab (c).vc_author IS NOT NULL THEN '' END
                             || workbook.sheets_tab (s).comments_tab (c).vc_text
                             || '</t></r></text></comment>');
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</commentList></comments>',
               p_eof         => TRUE);
            zip_util_pkg.add_file (t_excel, 'xl/comments' || TO_CHAR (s) || '.xml', t_xxx);
            t_xxx := NULL;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '<xml xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel">
<o:shapelayout v:ext="edit"><o:idmap v:ext="edit" data="2"/></o:shapelayout>
<v:shapetype id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe"><v:stroke joinstyle="miter"/><v:path gradientshapeok="t" o:connecttype="rect"/></v:shapetype>');

            FOR c IN 1 .. workbook.sheets_tab (s).comments_tab.COUNT
            LOOP
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<v:shape id="_x0000_s'
                                || TO_CHAR (c)
                                || '" type="#_x0000_t202" style="position:absolute;margin-left:35.25pt;margin-top:3pt;z-index:'
                                || TO_CHAR (c)
                                || ';visibility:hidden;" fillcolor="#ffffe1" o:insetmode="auto">
<v:fill color2="#ffffe1"/><v:shadow on="t" color="black" obscured="t"/><v:path o:connecttype="none"/>
<v:textbox style="mso-direction-alt:auto"><div style="text-align:left"></div></v:textbox>
<x:ClientData ObjectType="Note"><x:MoveWithCells/><x:SizeWithCells/>');
               t_w := workbook.sheets_tab (s).comments_tab (c).pi_width;
               t_c := 1;

               LOOP
                  IF workbook.sheets_tab (s).widths_tab_tab.EXISTS (workbook.sheets_tab (s).comments_tab (c).pi_column_nr + t_c)
                  THEN
                     t_cw := 256 * workbook.sheets_tab (s).widths_tab_tab (workbook.sheets_tab (s).comments_tab (c).pi_column_nr + t_c);
                     t_cw := TRUNC ( (t_cw + 18) / 256 * 7);                                              -- assume default 11 point Calibri
                  ELSE
                     t_cw := 64;
                  END IF;

                  EXIT WHEN t_w < t_cw;
                  t_c := t_c + 1;
                  t_w := t_w - t_cw;
               END LOOP;

               t_h := workbook.sheets_tab (s).comments_tab (c).pi_height;
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<x:Anchor>'
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_column_nr)
                                || ',15,'
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_row_nr)
                                || ',30,'
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_column_nr + t_c - 1)
                                || ','
                                || TO_CHAR (ROUND (t_w))
                                || ','
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_row_nr + 1 + TRUNC (t_h / 20))
                                || ','
                                || TO_CHAR (MOD (t_h, 20))
                                || '</x:Anchor>');
               clob_vc_concat(
                  p_clob        => t_xxx,
                  p_vc_buffer   => t_tmp,
                  p_vc_addition => '<x:AutoFill>false</x:AutoFill><x:Row>'
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_row_nr - 1)
                                || '</x:Row><x:Column>'
                                || TO_CHAR (workbook.sheets_tab (s).comments_tab (c).pi_column_nr - 1)
                                || '</x:Column></x:ClientData></v:shape>');
            END LOOP;

            clob_vc_concat(
               p_clob        => t_xxx,
               p_vc_buffer   => t_tmp,
               p_vc_addition => '</xml>',
               p_eof         => TRUE);
            zip_util_pkg.add_file (t_excel, 'xl/drawings/vmlDrawing' || TO_CHAR (s) || '.vml', t_xxx);
            t_xxx := NULL;
         END IF;
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings" Target="sharedStrings.xml"/>
<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/>');

      FOR s IN 1 .. workbook.sheets_tab.COUNT
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<Relationship Id="rId'
                          || TO_CHAR (9 + s)
                          || '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet'
                          || TO_CHAR (s)
                          || '.xml"/>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</Relationships>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, 'xl/_rels/workbook.xml.rels', t_xxx);
      t_xxx := NULL;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><sst xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" count="'
                       || workbook.pi_str_cnt
                       || '" uniqueCount="'
                       || TO_CHAR (workbook.strings_tab.COUNT)
                       || '">');

      FOR i IN 0 .. workbook.str_ind_tab.COUNT - 1
      LOOP
         clob_vc_concat(
            p_clob        => t_xxx,
            p_vc_buffer   => t_tmp,
            p_vc_addition => '<si><t>' 
                          || DBMS_XMLGEN.CONVERT (SUBSTR (workbook.str_ind_tab (i), 1, 32000))
                          || '</t></si>');
      END LOOP;

      clob_vc_concat(
         p_clob        => t_xxx,
         p_vc_buffer   => t_tmp,
         p_vc_addition => '</sst>',
         p_eof         => TRUE);
      zip_util_pkg.add_file (t_excel, 'xl/sharedStrings.xml', t_xxx);
      t_xxx := NULL;
      zip_util_pkg.finish_zip (t_excel);
      clear_workbook;
      RETURN t_excel;
   END finish;

   FUNCTION query2sheet (p_sql VARCHAR2, p_column_headers BOOLEAN := TRUE, p_sheet PLS_INTEGER := NULL, p_skip_header boolean := FALSE)
      RETURN BLOB
   AS
      t_sheet       PLS_INTEGER;
      t_c           INTEGER;
      t_col_cnt     INTEGER;
      t_desc_tab    DBMS_SQL.desc_tab2;
      d_tab         DBMS_SQL.date_table;
      n_tab         DBMS_SQL.number_table;
      v_tab         DBMS_SQL.varchar2_table;
      t_bulk_size   PLS_INTEGER := 200;
      t_r           INTEGER;
      t_cur_row     PLS_INTEGER;
   BEGIN
      t_sheet := COALESCE (p_sheet, new_sheet);
      t_c := DBMS_SQL.open_cursor;
      DBMS_SQL.parse (t_c, p_sql, DBMS_SQL.native);
      DBMS_SQL.describe_columns2 (t_c, t_col_cnt, t_desc_tab);

      FOR c IN 1 .. t_col_cnt
      LOOP
         IF p_column_headers
         THEN
            cell (c,
                  1,
                  t_desc_tab (c).col_name,
                  p_sheet   => t_sheet);
         END IF;

         CASE
            WHEN t_desc_tab (c).col_type IN (2, 100, 101)
            THEN
               DBMS_SQL.define_array (t_c,
                                      c,
                                      n_tab,
                                      t_bulk_size,
                                      1);
            WHEN t_desc_tab (c).col_type IN (12,
                                             178,
                                             179,
                                             180,
                                             181,
                                             231)
            THEN
               DBMS_SQL.define_array (t_c,
                                      c,
                                      d_tab,
                                      t_bulk_size,
                                      1);
            WHEN t_desc_tab (c).col_type IN (1,
                                             8,
                                             9,
                                             96,
                                             112)
            THEN
               DBMS_SQL.define_array (t_c,
                                      c,
                                      v_tab,
                                      t_bulk_size,
                                      1);
            ELSE
               NULL;
         END CASE;
      END LOOP;

      -- column headers werden vom Lieferantenabfragetool gesetzt, daher die Idßs um einen erhöht (TH)
      if p_skip_header then
          t_cur_row := CASE WHEN p_column_headers THEN 3 ELSE 2 END;
      else
          t_cur_row := CASE WHEN p_column_headers THEN 2 ELSE 1 END;
      end if;

      t_r := DBMS_SQL.execute (t_c);

      LOOP
         t_r := DBMS_SQL.fetch_rows (t_c);

         IF t_r > 0
         THEN
            FOR c IN 1 .. t_col_cnt
            LOOP
               CASE
                  WHEN t_desc_tab (c).col_type IN (2, 100, 101)
                  THEN
                     DBMS_SQL.COLUMN_VALUE (t_c, c, n_tab);

                     FOR i IN 0 .. t_r - 1
                     LOOP
                        IF n_tab (i + n_tab.FIRST) IS NOT NULL
                        THEN
                           cell (c,
                                 t_cur_row + i,
                                 n_tab (i + n_tab.FIRST),
                                 p_sheet   => t_sheet);
                        END IF;
                     END LOOP;

                     n_tab.delete;
                  WHEN t_desc_tab (c).col_type IN (12,
                                                   178,
                                                   179,
                                                   180,
                                                   181,
                                                   231)
                  THEN
                     DBMS_SQL.COLUMN_VALUE (t_c, c, d_tab);

                     FOR i IN 0 .. t_r - 1
                     LOOP
                        IF d_tab (i + d_tab.FIRST) IS NOT NULL
                        THEN
                           cell (c,
                                 t_cur_row + i,
                                 d_tab (i + d_tab.FIRST),
                                 p_sheet   => t_sheet);
                        END IF;
                     END LOOP;

                     d_tab.delete;
                  WHEN t_desc_tab (c).col_type IN (1,
                                                   8,
                                                   9,
                                                   96,
                                                   112)
                  THEN
                     DBMS_SQL.COLUMN_VALUE (t_c, c, v_tab);

                     FOR i IN 0 .. t_r - 1
                     LOOP
                        IF v_tab (i + v_tab.FIRST) IS NOT NULL
                        THEN
                           cell (c,
                                 t_cur_row + i,
                                 v_tab (i + v_tab.FIRST),
                                 p_sheet   => t_sheet);
                        END IF;
                     END LOOP;

                     v_tab.delete;
                  ELSE
                     NULL;
               END CASE;
            END LOOP;
         END IF;

         EXIT WHEN t_r != t_bulk_size;
         t_cur_row := t_cur_row + t_r;
      END LOOP;

      DBMS_SQL.close_cursor (t_c);
      RETURN finish;
   EXCEPTION
      WHEN OTHERS
      THEN
         IF DBMS_SQL.is_open (t_c)
         THEN
            DBMS_SQL.close_cursor (t_c);
         END IF;

         RETURN NULL;
   END query2sheet;

   FUNCTION finish2 (p_clob                 IN OUT NOCOPY CLOB,
                     p_columns              PLS_INTEGER,
                     p_rows                 PLS_INTEGER,
                     p_XLSX_date_format     VARCHAR2,
                     p_XLSX_datetime_format VARCHAR2)
      RETURN BLOB
   AS
      t_excel               BLOB;
      t_xxx                 CLOB;
      t_str                 VARCHAR2 (32767);
   BEGIN
      DBMS_LOB.createtemporary (t_excel, TRUE);
	  DBMS_LOB.createtemporary (t_xxx, TRUE);
	  --
      t_str := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"
           xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
	<dimension ref="A1:'
                       || alfan_col (p_columns)
                       || p_rows
                       || '"/>
	<sheetViews>
		<sheetView tabSelected="1"
		           workbookViewId="0">
			<pane ySplit="1"
			      topLeftCell="A2"
			      activePane="bottomLeft"
			      state="frozen"/>
			<selection pane="bottomLeft"
			           activeCell="A2"
			           sqref="A2"/>
		</sheetView>
	</sheetViews><sheetData>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
	  DBMS_LOB.append (t_xxx, p_clob);
	  DBMS_LOB.freetemporary (p_clob);
      t_str := '</sheetData><autoFilter ref="A1:'
                             || alfan_col (p_columns)
                             || p_rows
							 || '"/>
</worksheet>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, 'xl/worksheets/sheet1.xml', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      t_str := '<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
	<Default Extension="xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml" />
	<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml" />
	<Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml" />
	<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml" />
	<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
</Types>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, '[Content_Types].xml', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      t_str := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
	<Relationship Target="xl/workbook.xml" Id="r_main" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument"/>
	<Relationship Target="docProps/core.xml" Id="r_props" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties"/>
</Relationships>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, '_rels/.rels', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      t_str := '<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"
          xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
	<sheets>
		<sheet name="Sheet1"
		       sheetId="1"
		       r:id="r_sheet1" />
	</sheets>
	<definedNames>
		<definedName name="_xlnm._FilterDatabase"
		             localSheetId="0"
		             hidden="1">Sheet1!$A$1:'
					 || alfan_col(p_columns) || '$' || p_rows
					 || '</definedName>
	</definedNames>
</workbook>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, 'xl/workbook.xml', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      t_str := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"
                   xmlns:dc="http://purl.org/dc/elements/1.1/"
                   xmlns:dcterms="http://purl.org/dc/terms/"
                   xmlns:dcmitype="http://purl.org/dc/dcmitype/"
                   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<dc:creator>'
		|| NVL(SYS_CONTEXT('APEX$SESSION','APP_USER'),SYS_CONTEXT ('userenv', 'os_user'))
		|| '</dc:creator>
	<cp:lastModifiedBy>'
		|| NVL(SYS_CONTEXT('APEX$SESSION','APP_USER'),SYS_CONTEXT ('userenv', 'os_user'))
		|| '</cp:lastModifiedBy>
	<dcterms:created xsi:type="dcterms:W3CDTF">'
		|| TO_CHAR (sysdate, 'yyyy-mm-dd"T"hh24:mi:ss')
		|| '</dcterms:created>
	<dcterms:modified xsi:type="dcterms:W3CDTF">'
		|| TO_CHAR (sysdate, 'yyyy-mm-dd"T"hh24:mi:ss')
		|| '</dcterms:modified>
</cp:coreProperties>';
	  DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, 'docProps/core.xml', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      t_str := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
	<numFmts count="2">
		<numFmt numFmtId="1000"
		        formatCode="' || orafmt2excel(p_XLSX_date_format) || '" />
		<numFmt numFmtId="1001"
		        formatCode="' || orafmt2excel(p_XLSX_datetime_format) || '" />
	</numFmts>
	<fonts count="2">
		<font />
		<font>
			<b/>
		</font>
	</fonts>
	<fills count="3">
		<fill>
			<patternFill patternType="none"/>
		</fill>
		<fill>
			<patternFill patternType="gray125"/>
		</fill>
		<fill>
			<patternFill patternType="solid">
				<fgColor rgb="FFE1E1E1"/>
				<bgColor indexed="64"/>
			</patternFill>
		</fill>
	</fills>
	<borders count="1">
		<border />
	</borders>
	<cellStyleXfs count="1">
		<xf />
	</cellStyleXfs>
	<cellXfs count="4">
		<xf />
		<xf fontId="1" fillId="2" applyFont="1" applyFill="1"/>
		<xf numFmtId="1000" />
		<xf numFmtId="1001" />
	</cellXfs>
</styleSheet>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, 'xl/styles.xml', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      t_str := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
	<Relationship Target="worksheets/sheet1.xml" Id="r_sheet1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet"/>
	<Relationship Target="styles.xml" Id="r_styles" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles"/>
</Relationships>';
      DBMS_LOB.writeappend (t_xxx, length(t_str), t_str);
      zip_util_pkg.add_file (t_excel, 'xl/_rels/workbook.xml.rels', t_xxx);
      dbms_lob.trim( t_xxx, 0 );
      --
      zip_util_pkg.finish_zip (t_excel);
      DBMS_LOB.freetemporary (t_xxx);
      RETURN t_excel;
   exception
    when others then
        raise_application_error(-20002, '|+|' || sqlerrm || ',' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '|+|');
   END finish2;

   FUNCTION query2sheet2(p_sql                  VARCHAR2,
                         p_XLSX_date_format     VARCHAR2 := 'dd/mm/yyyy',
                         p_XLSX_datetime_format VARCHAR2 := 'dd/mm/yyyy hh24:mi:ss')
      RETURN BLOB
   AS
      t_c               INTEGER;
      t_r               INTEGER;
      t_desc_tab        DBMS_SQL.desc_tab2;
      t_clob_sql        CLOB;
      t_clob_result     CLOB;
      t_column_name     VARCHAR2(30);
      t_column_type     VARCHAR2(10);
      t_str             VARCHAR2(32767);
      t_cols_count      PLS_INTEGER := 0;
      t_rows_count      PLS_INTEGER := 0;
   BEGIN
      DBMS_LOB.createtemporary (t_clob_sql, true);
      t_c := DBMS_SQL.open_cursor;
      DBMS_SQL.parse (t_c, p_sql, DBMS_SQL.native);
      DBMS_SQL.describe_columns2 (t_c, t_cols_count, t_desc_tab);

      t_str := 'select xmlserialize(content xmlagg(t_xml)) as t_xml, count(*) as cnt from ( select '
            ||      'xmlelement("row",';
      DBMS_LOB.writeappend(t_clob_sql, length(t_str), t_str);
      FOR c IN 1 .. t_cols_count
      LOOP
         t_column_name := t_desc_tab (c).col_name;
         t_str := 'xmlelement("c",xmlattributes(''inlineStr'' as "t",''1'' as "s"),xmlelement("is",xmlelement("t",xmlcdata('''||t_column_name||'''))))' || case when c != t_cols_count then ',' end;
         DBMS_LOB.writeappend(t_clob_sql, length(t_str), t_str);
      END LOOP;
      t_str := ') as t_xml from dual ';

      DBMS_LOB.writeappend(t_clob_sql, length(t_str), t_str);
      t_str := ' union all select '
            ||      'xmlelement("row",';
      DBMS_LOB.writeappend(t_clob_sql, length(t_str), t_str);
      FOR c IN 1 .. t_cols_count
      LOOP
         t_column_name := t_desc_tab (c).col_name;
         t_column_type :=
            case
                when t_desc_tab(c).col_type IN (2,100,101)              then 'n' -- number
                when t_desc_tab(c).col_type IN (12,178,179,180,181,231) then 'd' -- date
                when t_desc_tab(c).col_type IN (1,9,96,112)             then 'inlineStr' -- char
                when t_desc_tab(c).col_type IN (8)                      then 'long' -- long
                else 'other'
            end;
         t_str :=
                'xmlelement("c",'
              ||    'xmlattributes('''||case when t_column_type in ('long','other') then 'inlineStr' else t_column_type end||''' as "t"'
              ||case when t_column_type != 'd' then '),' else ',case when nvl(trunc('||t_column_name||'),trunc(sysdate))=nvl('||t_column_name||',trunc(sysdate)) then ''2'' else ''3'' end as "s"),' end
              ||case
                    when t_column_type = 'inlineStr' then
                        'xmlelement("is",xmlelement("t",xmlcdata('||t_column_name||')))'
                    when t_column_type = 'long' then
                        'xmlelement("is",xmlelement("t",xmlcdata(''I don''''t know how to select longs'')))'
                    when t_column_type = 'other' then
                        'xmlelement("is",xmlelement("t",xmlcdata(to_clob('||t_column_name||'))))'
                    else
                        'case '
                        ||'when '||t_column_name||' is not null then xmlelement("v",'||case when t_column_type='d' then 'case when nvl(trunc('||t_column_name||'),trunc(sysdate))=nvl('||t_column_name||',trunc(sysdate)) then to_char('||t_column_name||',''yyyymmdd'') else to_char('||t_column_name||',''yyyymmdd"T"hh24miss'') end' else 'xmlcdata('||t_column_name||')' end ||') '
                        ||'else xmlelement("v") '
                        ||'end'
                end
              ||')'
              || case when c != t_cols_count then ',' end;
         DBMS_LOB.writeappend(t_clob_sql, length(t_str), t_str);
      END LOOP;
      t_str := ') as t_xml FROM ( ' || p_sql || ' )) ';
      DBMS_LOB.writeappend (t_clob_sql, length(t_str), t_str);
      DBMS_SQL.parse (t_c, t_clob_sql, DBMS_SQL.native);
      DBMS_LOB.freetemporary (t_clob_sql);
      DBMS_SQL.define_column (t_c, 1, t_clob_result);
      DBMS_SQL.define_column (t_c, 2, t_rows_count);
      t_r := DBMS_SQL.execute_and_fetch (t_c);
      DBMS_SQL.column_value (t_c, 1, t_clob_result);
      DBMS_SQL.column_value (t_c, 2, t_rows_count);
      DBMS_SQL.close_cursor (t_c);
      return finish2(p_clob             => t_clob_result,
                     p_columns          => t_cols_count,
                     p_rows             => t_rows_count,
                     p_XLSX_date_format      => p_XLSX_date_format,
                     p_XLSX_datetime_format  => p_XLSX_datetime_format) ;
   EXCEPTION
      WHEN OTHERS THEN
         IF DBMS_SQL.is_open (t_c) THEN DBMS_SQL.close_cursor (t_c); END IF;
         if DBMS_LOB.istemporary (t_clob_sql)=1 then DBMS_LOB.freetemporary (t_clob_sql); end if;
         raise_application_error(-20001, '|+|' || sqlerrm || ',' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '|+|');
   end query2sheet2;

   function query2sheet3
   (
     p_sql     in varchar2
   , p_binds   in t_bind_tab
   , p_headers in t_header_tab
   , p_XLSX_date_format     VARCHAR2 := 'dd/mm/yyyy'
   , p_XLSX_datetime_format VARCHAR2 := 'dd/mm/yyyy hh24:mi:ss'
   )
    return blob
   AS
      t_sheet       pls_integer;
      t_c           INTEGER;
      t_col_cnt     INTEGER;
      t_desc_tab    DBMS_SQL.desc_tab2;
      d_tab         DBMS_SQL.date_table;
      n_tab         DBMS_SQL.number_table;
      v_tab         DBMS_SQL.varchar2_table;
      t_bulk_size   PLS_INTEGER := 200;
      t_r           INTEGER;
      t_cur_row     PLS_INTEGER;
      t_cur_bind_name   varchar2(32767);
   begin
      t_sheet := COALESCE (null, new_sheet);
      t_c := DBMS_SQL.open_cursor;
      DBMS_SQL.parse (t_c, p_sql, DBMS_SQL.native);
      DBMS_SQL.describe_columns2 (t_c, t_col_cnt, t_desc_tab);

      if p_binds.count > 0 then
         t_cur_bind_name := p_binds.first();
         loop
            exit when t_cur_bind_name is null;
            dbms_sql.bind_variable( t_c, t_cur_bind_name, p_binds(t_cur_bind_name));
            t_cur_bind_name := p_binds.next(t_cur_bind_name);
         end loop;
      end if;


      FOR c IN 1 .. t_col_cnt
      LOOP
          cell (c,
                1,
                case when p_headers.exists(c) then p_headers(c) else t_desc_tab(c).col_name end,
                p_sheet   => t_sheet);

         CASE
            WHEN t_desc_tab (c).col_type IN (2, 100, 101)
            THEN
               DBMS_SQL.define_array (t_c,
                                      c,
                                      n_tab,
                                      t_bulk_size,
                                      1);
            WHEN t_desc_tab (c).col_type IN (12,
                                             178,
                                             179,
                                             180,
                                             181,
                                             231)
            THEN
               DBMS_SQL.define_array (t_c,
                                      c,
                                      d_tab,
                                      t_bulk_size,
                                      1);
            WHEN t_desc_tab (c).col_type IN (1,
                                             8,
                                             9,
                                             96,
                                             112)
            THEN
               DBMS_SQL.define_array (t_c,
                                      c,
                                      v_tab,
                                      t_bulk_size,
                                      1);
            ELSE
               NULL;
         END CASE;
      END LOOP;

      t_cur_row := CASE WHEN true THEN 2 ELSE 1 END;

      t_r := DBMS_SQL.execute (t_c);

      LOOP
         t_r := DBMS_SQL.fetch_rows (t_c);

         IF t_r > 0
         THEN
            FOR c IN 1 .. t_col_cnt
            LOOP
               CASE
                  WHEN t_desc_tab (c).col_type IN (2, 100, 101)
                  THEN
                     DBMS_SQL.COLUMN_VALUE (t_c, c, n_tab);

                     FOR i IN 0 .. t_r - 1
                     LOOP
                        IF n_tab (i + n_tab.FIRST) IS NOT NULL
                        THEN
                           cell (c,
                                 t_cur_row + i,
                                 n_tab (i + n_tab.FIRST),
                                 p_sheet   => t_sheet);
                        END IF;
                     END LOOP;

                     n_tab.delete;
                  WHEN t_desc_tab (c).col_type IN (12,
                                                   178,
                                                   179,
                                                   180,
                                                   181,
                                                   231)
                  THEN
                     DBMS_SQL.COLUMN_VALUE (t_c, c, d_tab);

                     FOR i IN 0 .. t_r - 1
                     LOOP
                        IF d_tab (i + d_tab.FIRST) IS NOT NULL
                        THEN
                           cell (c,
                                 t_cur_row + i,
                                 d_tab (i + d_tab.FIRST),
                                 p_sheet   => t_sheet);
                        END IF;
                     END LOOP;

                     d_tab.delete;
                  WHEN t_desc_tab (c).col_type IN (1,
                                                   8,
                                                   9,
                                                   96,
                                                   112)
                  THEN
                     DBMS_SQL.COLUMN_VALUE (t_c, c, v_tab);

                     FOR i IN 0 .. t_r - 1
                     LOOP
                        IF v_tab (i + v_tab.FIRST) IS NOT NULL
                        THEN
                           cell (c,
                                 t_cur_row + i,
                                 v_tab (i + v_tab.FIRST),
                                 p_sheet   => t_sheet);
                        END IF;
                     END LOOP;

                     v_tab.delete;
                  ELSE
                     NULL;
               END CASE;
            END LOOP;
         END IF;

         EXIT WHEN t_r != t_bulk_size;
         t_cur_row := t_cur_row + t_r;
      END LOOP;

      DBMS_SQL.close_cursor (t_c);
      RETURN finish;
   EXCEPTION
      WHEN OTHERS
      THEN
         IF DBMS_SQL.is_open (t_c)
         THEN
            DBMS_SQL.close_cursor (t_c);
         END IF;

         RETURN NULL;
   END query2sheet3;

END;
/

create or replace package body zip_util_pkg
is

/**
* Purpose:      Package handles zipping and unzipping of files
*
* Remarks:      by Anton Scheffer, see http://forums.oracle.com/forums/thread.jspa?messageID=9289744#9289744
* 
*               for unzipping, see http://technology.amis.nl/blog/8090/parsing-a-microsoft-word-docx-and-unzip-zipfiles-with-plsql
*               for zipping, see http://forums.oracle.com/forums/thread.jspa?threadID=1115748&tstart=0
*
* Who     Date        Description
* ------  ----------  --------------------------------
* MBR     09.01.2011  Created
* MBR     21.05.2012  Fixed a bug related to use of dbms_lob.substr in get_file (use dbms_lob.copy instead)
* MK      01.07.2014  Added get_file_clob to immediatly retrieve file content as a CLOB
*
* @headcom
*/

  /* Constants */
  c_max_length CONSTANT PLS_INTEGER := 32767;
  c_file_comment CONSTANT RAW(32767) := utl_raw.cast_to_raw('Implementation by Anton Scheffer');

  /**
  * Convert to little endian raw
  */
  FUNCTION little_endian( p_big IN NUMBER
                        , p_bytes IN pls_integer := 4
                        )
    RETURN RAW
  AS
  BEGIN
    RETURN utl_raw.substr( utl_raw.cast_from_binary_integer( p_big
                                                             , utl_raw.little_endian
                                                           )
                         , 1
                         , p_bytes
                         );
  END little_endian;

  FUNCTION get_modify_date( p_modify_date IN DATE DEFAULT SYSDATE)
    RETURN RAW
  AS
  BEGIN
    RETURN little_endian( to_number( to_char( p_modify_date, 'dd' ) )
                          + to_number( to_char( p_modify_date, 'mm' ) ) * 32
                          + ( to_number( to_char( p_modify_date, 'yyyy' ) ) - 1980 ) * 512
                        , 2
                        );
  END get_modify_date;

  FUNCTION get_modify_time( p_modify_date IN DATE DEFAULT SYSDATE)
    RETURN RAW
  AS
  BEGIN
    RETURN little_endian( to_number( to_char( p_modify_date, 'ss' ) ) / 2
                          + to_number( to_char( p_modify_date, 'mi' ) ) * 32
                          + to_number( to_char( p_modify_date, 'hh24' ) ) * 2048
                        , 2
                        );
  END get_modify_time;


  FUNCTION raw2num( p_value in raw )
    RETURN NUMBER
  AS
  BEGIN                                               -- note: FFFFFFFF => -1
    RETURN utl_raw.cast_to_binary_integer( p_value
                                         , utl_raw.little_endian
                                         );

  END raw2num;

  FUNCTION raw2varchar2( p_raw IN RAW
                       , p_encoding IN VARCHAR2
                       )
    RETURN VARCHAR2
  AS
  BEGIN
    RETURN nvl( utl_i18n.raw_to_char( p_raw
                                    , p_encoding
                                    )
              , utl_i18n.raw_to_char ( p_raw
                                     , utl_i18n.map_charset( p_encoding
                                                           , utl_i18n.generic_context
                                                           , utl_i18n.iana_to_oracle
                                                           )
                                     )
              );
  END raw2varchar2;

  FUNCTION raw2varchar2( p_zipped_blob IN BLOB
                       , p_start_index IN NUMBER
                       , p_end_index IN NUMBER
                       , p_encoding IN VARCHAR2
                       )
    RETURN VARCHAR2
  AS
  BEGIN
    RETURN raw2varchar2( dbms_lob.substr( p_zipped_blob
                                        , p_start_index
                                        , p_end_index
                                        )
                       , p_encoding
                       );
  END raw2varchar2;


  FUNCTION raw2num( p_zipped_blob IN BLOB
                  , p_start_index IN NUMBER
                  , p_end_index IN NUMBER
                  )
    RETURN NUMBER
  AS
  BEGIN
    RETURN raw2num( dbms_lob.substr( p_zipped_blob
                                   , p_start_index
                                   , p_end_index
                                   )
                  );
  END raw2num;

  FUNCTION get_file_list( p_zipped_blob IN BLOB
                        , p_encoding IN VARCHAR2 := NULL
  )
    RETURN t_file_list
  AS
    l_index INTEGER;
    l_header_index INTEGER;
    l_file_list t_file_list;
  BEGIN
    l_index := dbms_lob.getlength( p_zipped_blob ) - 21;
    LOOP
      EXIT WHEN dbms_lob.substr( p_zipped_blob, 4, l_index ) = hextoraw( '504B0506' )
             OR l_index < 1;
      l_index := l_index - 1;
    END LOOP;

    IF l_index <= 0 THEN
      RETURN NULL;
    END IF;

    l_header_index := raw2num( p_zipped_blob, 4, l_index + 16 ) + 1;
    l_file_list := t_file_list( );
    l_file_list.EXTEND( raw2num( p_zipped_blob, 2, l_index + 10 ) );

    FOR i IN 1 .. raw2num( p_zipped_blob, 2, l_index + 8 )
    LOOP
      l_file_list( i ) := raw2varchar2( p_zipped_blob
                                      , raw2num( p_zipped_blob, 2, l_header_index + 28 )
                                      , l_header_index + 46
                                      , p_encoding
                                      );
      l_header_index := l_header_index
                      + 46
                      + raw2num( dbms_lob.substr( p_zipped_blob, 2, l_header_index + 28 ) )
                      + raw2num( dbms_lob.substr( p_zipped_blob, 2, l_header_index + 30 ) )
                      + raw2num( dbms_lob.substr( p_zipped_blob, 2, l_header_index + 32 ) );
    END LOOP;

    RETURN l_file_list;
  END get_file_list;

  FUNCTION get_file( p_zipped_blob IN BLOB
                   , p_file_name IN VARCHAR2
                   , p_encoding IN VARCHAR2 := NULL
                   )
    RETURN BLOB
  AS
    l_retval BLOB;
    l_index INTEGER;
    l_header_index INTEGER;
    l_file_index INTEGER;
  BEGIN
    l_index := dbms_lob.getlength( p_zipped_blob ) - 21;
    LOOP
      EXIT WHEN dbms_lob.substr( p_zipped_blob, 4, l_index ) = hextoraw( '504B0506' )
             OR l_index < 1;
      l_index := l_index - 1;
    END LOOP;

    IF l_index <= 0 THEN
      RETURN NULL;
    END IF;

    l_header_index := raw2num( p_zipped_blob, 4, l_index + 16 ) + 1;
    FOR i IN 1 .. raw2num( p_zipped_blob, 2, l_index + 8 )
    LOOP
      IF p_file_name = raw2varchar2( p_zipped_blob
                                   , raw2num( p_zipped_blob, 2, l_header_index + 28 )
                                   , l_header_index + 46
                                   , p_encoding
                                   )
      THEN
        IF dbms_lob.substr( p_zipped_blob, 2, l_header_index + 10 ) = hextoraw( '0800' ) -- deflate
        THEN
          l_file_index := raw2num( p_zipped_blob, 4, l_header_index + 42 );
          l_retval := hextoraw( '1F8B0800000000000003' ); -- gzip r_header
          dbms_lob.copy( l_retval
                       , p_zipped_blob
                       , raw2num( p_zipped_blob, 4, l_file_index + 19 )
                       , 11
                       , l_file_index
                         + 31
                         + raw2num( p_zipped_blob, 2, l_file_index + 27 )
                         + raw2num( p_zipped_blob, 2, l_file_index + 29 )
                       );
          dbms_lob.append( l_retval
                         , dbms_lob.substr( p_zipped_blob, 4, l_file_index + 15 )
                         );
          dbms_lob.append( l_retval
                         , dbms_lob.substr( p_zipped_blob, 4, l_file_index + 23 )
                         );
          RETURN utl_compress.lz_uncompress( l_retval );
        END IF;
        IF dbms_lob.substr( p_zipped_blob, 2, l_header_index + 10) = hextoraw( '0000' ) -- The file is stored (no compression)
        THEN
          l_file_index := raw2num( p_zipped_blob, 4, l_header_index + 42 );

          dbms_lob.createtemporary(l_retval, cache => true);

          dbms_lob.copy(dest_lob => l_retval,
                        src_lob => p_zipped_blob,
                        amount => raw2num( p_zipped_blob, 4, l_file_index + 19 ),
                        dest_offset => 1,
                        src_offset => l_file_index + 31 + raw2num(dbms_lob.substr(p_zipped_blob, 2, l_file_index + 27)) + raw2num(dbms_lob.substr( p_zipped_blob, 2, l_file_index + 29))
                       );

          RETURN l_retval;                                        
        END IF;
      END IF;
      l_header_index := l_header_index
                      + 46
                      + raw2num( p_zipped_blob, 2, l_header_index + 28 )
                      + raw2num( p_zipped_blob, 2, l_header_index + 30 )
                      + raw2num( p_zipped_blob, 2, l_header_index + 32 );
    END LOOP;
    RETURN NULL;
  END get_file;

  FUNCTION get_file_clob( p_zipped_blob IN BLOB
                        , p_file_name IN VARCHAR2
                        , p_encoding IN VARCHAR2 := NULL
                        )
    RETURN CLOB
  AS
    l_file_blob BLOB;
    l_return CLOB;
    l_dest_offset INTEGER := 1;
    l_src_offset INTEGER := 1;
    l_warning INTEGER;
    l_lang_ctx INTEGER := dbms_lob.DEFAULT_LANG_CTX;
  BEGIN
    l_file_blob := get_file( p_zipped_blob => p_zipped_blob
                           , p_file_name => p_file_name
                           , p_encoding => p_encoding
                           );
    IF l_file_blob IS NULL THEN
      raise_application_error( -20000
                             , 'File not found...'
                             );
    END IF;
    dbms_lob.createtemporary (l_return, true);
    dbms_lob.converttoclob( dest_lob => l_return
                          , src_blob => l_file_blob
                          , amount => dbms_lob.lobmaxsize
                          , dest_offset => l_dest_offset
                          , src_offset => l_src_offset
                          , blob_csid => dbms_lob.default_csid
                          , lang_context =>l_lang_ctx
                          , warning => l_warning
                          );
    RETURN l_return;
  END get_file_clob;

  PROCEDURE add_file( p_zipped_blob IN OUT NOCOPY BLOB
                    , p_name IN VARCHAR2
                    , p_content IN BLOB
  )
  AS
    l_new_file BLOB;
    l_content_length INTEGER;
  BEGIN
    l_new_file := utl_compress.lz_compress( p_content );
    l_content_length := dbms_lob.getlength( l_new_file );

    IF p_zipped_blob IS NULL THEN
      dbms_lob.createtemporary( p_zipped_blob, true );
    END IF;
    dbms_lob.APPEND( p_zipped_blob
                   , utl_raw.concat ( hextoraw( '504B0304' )                                -- Local file r_header signature
                                    , hextoraw( '1400' )                                    -- version 2.0
                                    , hextoraw( '0000' )                                    -- no General purpose bits
                                    , hextoraw( '0800' )                                    -- deflate
                                    , get_modify_time                                       -- File last modification time
                                    , get_modify_date                                       -- File last modification date
                                    , dbms_lob.substr( l_new_file, 4, l_content_length - 7) -- CRC-321
                                    , little_endian( l_content_length - 18 )                -- compressed size
                                    , little_endian( dbms_lob.getlength( p_content ) )      -- uncompressed size
                                    , little_endian( LENGTH( p_name ), 2 )                  -- File name length
                                    , hextoraw( '0000' )                                    -- Extra field length
                                    , utl_raw.cast_to_raw( p_name )                         -- File name
                                    )
                   );
    dbms_lob.copy( p_zipped_blob
                 , l_new_file
                 , l_content_length - 18
                 , dbms_lob.getlength( p_zipped_blob ) + 1
                 , 11
                 );  -- compressed content
    dbms_lob.freetemporary( l_new_file );
  END add_file;

  PROCEDURE add_file( p_zipped_blob IN OUT NOCOPY BLOB
                    , p_name IN VARCHAR2
                    , p_content CLOB
                    )
  AS
    l_tmp BLOB;
    dest_offset INTEGER := 1;
    src_offset INTEGER := 1;
    l_warning INTEGER;
    l_lang_ctx INTEGER := dbms_lob.DEFAULT_LANG_CTX;
  BEGIN
    dbms_lob.createtemporary( l_tmp, true );
    dbms_lob.converttoblob( l_tmp
                          , p_content
                          , dbms_lob.lobmaxsize
                          , dest_offset
                          , src_offset
                          , nls_charset_id( 'AL32UTF8' ) 
                          , l_lang_ctx
                          , l_warning
                          );
    add_file( p_zipped_blob, p_name, l_tmp );
    dbms_lob.freetemporary( l_tmp );
  END add_file;

  PROCEDURE finish_zip( p_zipped_blob IN OUT NOCOPY BLOB )
  AS
    l_cnt pls_integer := 0;
    l_offset INTEGER;
    l_offset_directory INTEGER;
    l_offset_header INTEGER;
  BEGIN
    l_offset_directory := dbms_lob.getlength( p_zipped_blob );
    l_offset := dbms_lob.instr( p_zipped_blob
                              , hextoraw( '504B0304' )
                              , 1
                              );
    WHILE l_offset > 0 LOOP
      l_cnt := l_cnt + 1;
      dbms_lob.APPEND( p_zipped_blob
                     , utl_raw.concat( hextoraw( '504B0102' )                           -- Central directory file r_header signature
                                     , hextoraw( '1400' )                               -- version 2.0
                                     , dbms_lob.substr( p_zipped_blob, 26, l_offset + 4 )
                                     , hextoraw( '0000' )                               -- File comment length
                                     , hextoraw( '0000' )                               -- Disk number where file starts
                                     , hextoraw( '0100' )                               -- Internal file attributes
                                     , hextoraw( '2000B681' )                           -- External file attributes
                                     , little_endian( l_offset - 1 )                    -- Relative offset of local file r_header
                                     , dbms_lob.substr( p_zipped_blob
                                                      , utl_raw.cast_to_binary_integer( dbms_lob.substr( p_zipped_blob
                                                                                                       , 2
                                                                                                       , l_offset + 26
                                                                                                       )
                                                                                      , utl_raw.little_endian
                                                                                      )
                                                      , l_offset + 30
                                                      )                                 -- File name
                                    )
                     );
      l_offset := dbms_lob.instr( p_zipped_blob
                                , hextoraw( '504B0304' )
                                , l_offset + 32
                                );
    END LOOP;

    l_offset_header := dbms_lob.getlength( p_zipped_blob );
    dbms_lob.APPEND( p_zipped_blob
                  , utl_raw.concat( hextoraw( '504B0506' )                                         -- End of central directory signature
                                   , hextoraw( '0000' )                                            -- Number of this disk
                                   , hextoraw( '0000' )                                            -- Disk where central directory starts
                                   , little_endian( l_cnt, 2 )                                     -- Number of central directory records on this disk
                                   , little_endian( l_cnt, 2 )                                     -- Total number of central directory records
                                   , little_endian( l_offset_header - l_offset_directory )         -- Size of central directory
                                   , little_endian( l_offset_directory )                           -- Relative offset of local file r_header
                                   , little_endian( nvl( utl_raw.length( c_file_comment ), 0 ), 2) -- ZIP file comment length
                                   , c_file_comment
                                   )
                    );
  END finish_zip;

end zip_util_pkg;
/