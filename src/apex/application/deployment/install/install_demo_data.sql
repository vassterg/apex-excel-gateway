prompt --application/deployment/install/install_demo_data
begin
--   Manifest
--     INSTALL: INSTALL-Demo Data
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2021.04.15'
,p_release=>'21.1.0'
,p_default_workspace_id=>9510583246779566
,p_default_application_id=>111
,p_default_id_offset=>288269999118260128
,p_default_owner=>'SURVEY_TOOL'
);
wwv_flow_api.create_install_script(
 p_id=>wwv_flow_api.id(73801478690756240)
,p_install_id=>wwv_flow_api.id(72854742268623600)
,p_name=>'Demo Data'
,p_sequence=>50
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  nextnum number;  ',
'  l_num number;',
'begin',
'    delete R_SHIPPINGSTATUS;',
'    delete R_STATUS;',
'    delete R_VALIDATION;',
'    delete R_HEADER;',
'    delete R_DROPDOWNS;',
'    delete R_TEMPLATES;',
'    delete TEMPLATE_AUTOMATIONS;',
'    delete TEMPLATE_HEADER_GROUP;',
'    delete TEMPLATE_HEADER;',
'    delete TEMPLATE_HEADER_VALIDATIONS;',
'',
'    Insert into R_SHIPPINGSTATUS (SPS_NAME) values (''Template not sent'');',
'    Insert into R_SHIPPINGSTATUS (SPS_NAME) values (''Template sent'');',
'    Insert into R_SHIPPINGSTATUS (SPS_NAME) values (''Correction sent'');',
'    Insert into R_SHIPPINGSTATUS (SPS_NAME) values (''Reminder sent'');',
'',
'    Insert into R_STATUS (STS_NAME) values (''Not edited'');',
'    Insert into R_STATUS (STS_NAME) values (''In processing'');',
'    Insert into R_STATUS (STS_NAME) values (''Completed'');',
'',
'    Insert into R_VALIDATION (VAL_TEXT,VAL_MESSAGE) values (''email'',''Invalid email address'');',
'    Insert into R_VALIDATION (VAL_TEXT,VAL_MESSAGE) values (''number'',''Invalid number'');',
'    Insert into R_VALIDATION (VAL_TEXT,VAL_MESSAGE) values (''date'',''Invalid date'');',
'    Insert into R_VALIDATION (VAL_TEXT,VAL_MESSAGE) values (''formula'',''formula'');',
'',
'    Insert into R_HEADER (HEA_ID,HEA_TEXT,HEA_XLSX_WIDTH) values (9999, ''Faulty'',30);',
'    Insert into R_HEADER (HEA_ID,HEA_TEXT,HEA_XLSX_WIDTH) values (9998, ''Annotation'',30);',
'    Insert into R_HEADER (HEA_ID,HEA_TEXT,HEA_XLSX_WIDTH) values (9997, ''Feedback'',30);',
'    Insert into R_HEADER (HEA_ID,HEA_TEXT,HEA_XLSX_WIDTH) values (9996, ''Validation'',30);',
'',
'    -- Add Demo Template (Employee List)',
'    Insert into R_HEADER (HEA_ID,HEA_TEXT,HEA_XLSX_WIDTH,HEA_VAL_ID) values (''1'',''Name'',''30'',null);',
'    Insert into R_HEADER (HEA_ID,HEA_TEXT,HEA_XLSX_WIDTH,HEA_VAL_ID) values (''2'',''Fist name'',''30'',null);',
'    Insert into R_HEADER (HEA_ID,HEA_TEXT,HEA_XLSX_WIDTH,HEA_VAL_ID) values (''3'',''Email'',''40'',''1'');',
'    Insert into R_HEADER (HEA_ID,HEA_TEXT,HEA_XLSX_WIDTH,HEA_VAL_ID) values (''4'',''Department'',''30'',null);',
'    Insert into R_HEADER (HEA_ID,HEA_TEXT,HEA_XLSX_WIDTH,HEA_VAL_ID) values (''5'',''Job'',''30'',null);',
'    Insert into R_HEADER (HEA_ID,HEA_TEXT,HEA_XLSX_WIDTH,HEA_VAL_ID) values (''6'',''Hire date'',''20'',''3'');',
'    Insert into R_HEADER (HEA_ID,HEA_TEXT,HEA_XLSX_WIDTH,HEA_VAL_ID) values (''7'',''Salary'',''20'',''2'');',
'',
'    Insert into R_DROPDOWNS (DDS_HEA_ID,DDS_TEXT) values (''4'',''Accounting'');',
'    Insert into R_DROPDOWNS (DDS_HEA_ID,DDS_TEXT) values (''4'',''Research'');',
'    Insert into R_DROPDOWNS (DDS_HEA_ID,DDS_TEXT) values (''4'',''Sales'');',
'    Insert into R_DROPDOWNS (DDS_HEA_ID,DDS_TEXT) values (''5'',''Analyst'');',
'    Insert into R_DROPDOWNS (DDS_HEA_ID,DDS_TEXT) values (''5'',''Clerk'');',
'    Insert into R_DROPDOWNS (DDS_HEA_ID,DDS_TEXT) values (''5'',''Manager'');',
'    Insert into R_DROPDOWNS (DDS_HEA_ID,DDS_TEXT) values (''5'',''President'');',
'    Insert into R_DROPDOWNS (DDS_HEA_ID,DDS_TEXT) values (''5'',''Salesman'');',
'',
'    Insert into R_TEMPLATES (TPL_ID,TPL_NAME,TPL_DEADLINE,TPL_NUMBER_OF_ROWS) values (''1'',''Employee List (Demo)'',''14'',''50'');',
'',
'    Insert into TEMPLATE_AUTOMATIONS (TPA_TPL_ID,TPA_DAYS,TPA_ENABLED) values (''1'',null,''0'');',
'',
'    Insert into TEMPLATE_HEADER_GROUP (THG_ID,THG_TEXT,THG_XLSX_BACKGROUND_COLOR,THG_XLSX_FONT_COLOR) values (''1'',''Personal data'',''ffb2b2b2'',''ff000000'');',
'    Insert into TEMPLATE_HEADER_GROUP (THG_ID,THG_TEXT,THG_XLSX_BACKGROUND_COLOR,THG_XLSX_FONT_COLOR) values (''2'',''Job data'',''ffc75600'',''ff000000'');',
'',
'    Insert into TEMPLATE_HEADER (TPH_ID,TPH_TPL_ID,TPH_HEA_ID,TPH_XLSX_BACKGROUND_COLOR,TPH_XLSX_FONT_COLOR,TPH_SORT_ORDER,TPH_THG_ID) values (''1'',''1'',''2'',''ffcccccc'',''ff000000'',''1'',''1'');',
'    Insert into TEMPLATE_HEADER (TPH_ID,TPH_TPL_ID,TPH_HEA_ID,TPH_XLSX_BACKGROUND_COLOR,TPH_XLSX_FONT_COLOR,TPH_SORT_ORDER,TPH_THG_ID) values (''2'',''1'',''1'',''ffcccccc'',''ff000000'',''2'',''1'');',
'    Insert into TEMPLATE_HEADER (TPH_ID,TPH_TPL_ID,TPH_HEA_ID,TPH_XLSX_BACKGROUND_COLOR,TPH_XLSX_FONT_COLOR,TPH_SORT_ORDER,TPH_THG_ID) values (''3'',''1'',''3'',''ffcccccc'',''ff000000'',''3'',''1'');',
'    Insert into TEMPLATE_HEADER (TPH_ID,TPH_TPL_ID,TPH_HEA_ID,TPH_XLSX_BACKGROUND_COLOR,TPH_XLSX_FONT_COLOR,TPH_SORT_ORDER,TPH_THG_ID) values (''4'',''1'',''4'',''ffc75600'',''ff000000'',''4'',''2'');',
'    Insert into TEMPLATE_HEADER (TPH_ID,TPH_TPL_ID,TPH_HEA_ID,TPH_XLSX_BACKGROUND_COLOR,TPH_XLSX_FONT_COLOR,TPH_SORT_ORDER,TPH_THG_ID) values (''5'',''1'',''5'',''ffc75600'',''ff000000'',''5'',''2'');',
'    Insert into TEMPLATE_HEADER (TPH_ID,TPH_TPL_ID,TPH_HEA_ID,TPH_XLSX_BACKGROUND_COLOR,TPH_XLSX_FONT_COLOR,TPH_SORT_ORDER,TPH_THG_ID) values (''6'',''1'',''6'',''ffc75600'',''ff000000'',''6'',''2'');',
'    Insert into TEMPLATE_HEADER (TPH_ID,TPH_TPL_ID,TPH_HEA_ID,TPH_XLSX_BACKGROUND_COLOR,TPH_XLSX_FONT_COLOR,TPH_SORT_ORDER,TPH_THG_ID) values (''7'',''1'',''7'',''ffc75600'',''ff000000'',''7'',''2'');',
'',
'    Insert into TEMPLATE_HEADER_VALIDATIONS (THV_TPH_ID,THV_FORMULA1,THV_FORMULA2) values (''6'',''01.01.2000'',''31.12.2021'');',
'    Insert into TEMPLATE_HEADER_VALIDATIONS (THV_TPH_ID,THV_FORMULA1,THV_FORMULA2) values (''7'',''1000'',''10000'');',
'',
'    -- set sequences to the last used id',
'    select max(sps_id)+1 into nextnum from R_SHIPPINGSTATUS;',
'    select sps_seq.nextval into l_num from DUAL;   ',
'    if (nextnum - l_num - 1) != 0',
'     then',
'        execute immediate ''ALTER SEQUENCE sps_seq INCREMENT BY ''|| (nextnum - l_num - 1) ||'' minvalue 0''; ',
'    end if;',
'    select sps_seq.nextval into l_num from DUAL;',
'    execute immediate ''alter sequence sps_seq increment by 1 '';',
'    ',
'    select max(sts_id)+1 into nextnum from R_STATUS;',
'    select sts_seq.nextval into l_num from DUAL;  ',
'    if (nextnum - l_num - 1) != 0',
'     then',
'        execute immediate ''ALTER SEQUENCE sts_seq INCREMENT BY ''|| (nextnum - l_num - 1) ||'' MINVALUE 0'';  ',
'    end if;    ',
'    select sts_seq.nextval into l_num from DUAL;',
'    execute immediate ''alter sequence sts_seq increment by 1 '';',
'    ',
'    select max(val_id)+1 into nextnum from R_VALIDATION;',
'    select val_seq.nextval into l_num from DUAL;  ',
'    if (nextnum - l_num - 1) != 0',
'     then',
'        execute immediate ''ALTER SEQUENCE val_seq INCREMENT BY ''|| (nextnum - l_num - 1) ||'' MINVALUE 0'';  ',
'    end if;    ',
'    select val_seq.nextval into l_num from DUAL;',
'    execute immediate ''alter sequence val_seq increment by 1 '';',
'    ',
'    select max(hea_id)+1 into nextnum from R_HEADER where hea_id < 9996;',
'    select hea_seq.nextval into l_num from DUAL;  ',
'    if (nextnum - l_num - 1) != 0',
'     then',
'        execute immediate ''ALTER SEQUENCE hea_seq INCREMENT BY ''|| (nextnum - l_num - 1) ||'' MINVALUE 0'';  ',
'    end if;    ',
'    select hea_seq.nextval into l_num from DUAL;',
'    execute immediate ''alter sequence hea_seq increment by 1 '';',
'    ',
'    select max(dds_id)+1 into nextnum from R_DROPDOWNS;',
'    select dds_seq.nextval into l_num from DUAL;  ',
'    if (nextnum - l_num - 1) != 0',
'     then',
'        execute immediate ''ALTER SEQUENCE dds_seq INCREMENT BY ''|| (nextnum - l_num - 1) ||'' MINVALUE 0'';  ',
'    end if;    ',
'    select dds_seq.nextval into l_num from DUAL;',
'    execute immediate ''alter sequence dds_seq increment by 1 '';',
'    ',
'    select max(tpl_id)+1 into nextnum from R_TEMPLATES;',
'    select tpl_seq.nextval into l_num from DUAL;',
'    if (nextnum - l_num - 1) != 0',
'     then',
'        execute immediate ''ALTER SEQUENCE tpl_seq INCREMENT BY ''|| (nextnum - l_num - 1) ||'' MINVALUE 0'';',
'    end if;    ',
'    select tpl_seq.nextval into l_num from DUAL;',
'    execute immediate ''alter sequence tpl_seq increment by 1 '';',
'    ',
'    select max(tpa_id)+1 into nextnum from TEMPLATE_AUTOMATIONS;',
'    select tpa_seq.nextval into l_num from DUAL;',
'    if (nextnum - l_num - 1) != 0',
'     then',
'        execute immediate ''ALTER SEQUENCE tpa_seq INCREMENT BY ''|| (nextnum - l_num - 1) ||'' MINVALUE 0'';',
'    end if;    ',
'    select tpa_seq.nextval into l_num from DUAL;',
'    execute immediate ''alter sequence tpa_seq increment by 1 '';',
'    ',
'    select max(thg_id)+1 into nextnum from TEMPLATE_HEADER_GROUP;',
'    select thg_seq.nextval into l_num from DUAL;',
'    if (nextnum - l_num - 1) != 0',
'     then',
'        execute immediate ''ALTER SEQUENCE thg_seq INCREMENT BY ''|| (nextnum - l_num - 1) ||'' MINVALUE 0'';',
'    end if;    ',
'    select thg_seq.nextval into l_num from DUAL;',
'    execute immediate ''alter sequence thg_seq increment by 1 '';',
'    ',
'    select max(tph_id)+1 into nextnum from TEMPLATE_HEADER;',
'    select tph_seq.nextval into l_num from DUAL;',
'    if (nextnum - l_num - 1) != 0',
'     then',
'        execute immediate ''ALTER SEQUENCE tph_seq INCREMENT BY ''|| (nextnum - l_num - 1) ||'' MINVALUE 0'';',
'    end if;    ',
'    select tph_seq.nextval into l_num from DUAL;',
'    execute immediate ''alter sequence tph_seq increment by 1 '';',
'    ',
'    select max(thv_id)+1 into nextnum from TEMPLATE_HEADER_VALIDATIONS;',
'    select thv_seq.nextval into l_num from DUAL;',
'    if (nextnum - l_num - 1) != 0',
'     then',
'        execute immediate ''ALTER SEQUENCE thv_seq INCREMENT BY ''|| (nextnum - l_num - 1) ||'' MINVALUE 0'';',
'    end if;    ',
'    select thv_seq.nextval into l_num from DUAL;',
'    execute immediate ''alter sequence thv_seq increment by 1 '';',
'',
'end;',
'/'))
);
wwv_flow_api.component_end;
end;
/