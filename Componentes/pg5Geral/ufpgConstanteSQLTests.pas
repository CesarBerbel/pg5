unit ufpgConstanteSQLTests;

interface

uses
  SysUtils;


const

//jcf:format=off

SQL_RETORNA_FILA_PROCESSO =
  'SELECT COUNT(1) TOTAL                              ' + #13 +
  '  FROM %SEFPGPROCESSO EP,                          ' + #13 +
  '       %SEWFLHISTOBJETO EHO                        ' + #13 +
  ' WHERE EHO.CDOBJETO = EP.CDOBJETO                  ' + #13 +
  '   AND EHO.CDFILA = %S                             ' + #13 +
  '   AND EXISTS (SELECT 1                            ' + #13 +
  '                 FROM %SEFPGPROCESSO               ' + #13 +
  '                WHERE NUPROCESSO LIKE %S           ' + #13 +
  '                  AND CDOBJETO = EHO.CDOBJETO)     ' + #13 +
  '   AND NUSEQHIST = (SELECT MAX(NUSEQHIST)          ' + #13 +
  '                      FROM %SEWFLHISTOBJETO        ' + #13 +
  '                     WHERE CDOBJETO = EHO.CDOBJETO)';

SQL_RETORNA_PROCESSO =
  'SELECT P.NUPROCESSO                                     ' + #13 +
  '  FROM %SEFPGPROCESSO P                                 ' + #13 +
  ' where not EXISTS (select 1                             ' + #13 +
  '                     from %SESAJPENDENCIAPRAZO EPR      ' + #13 +
  '                    where EPR.CDPROCESSO = P.CDPROCESSO)' + #13 +
  '   AND FLPROCVIRTUAL = ''S''                            ' + #13 +
  '   %S ''C''                                             ' + #13 +
  '   AND P.DTRECEBIMENTO >= %S                            ';

SQL_RETORNA_AUDIENCIA_MARCADA =
  'SELECT COUNT(1) TOTAL                             ' +#13+
  '  FROM %SEGGPAUDIENCIA AUDI,                      ' +#13+
  '       %SEGGPSITUACAOAUDI SITAUD                  ' +#13+
  ' WHERE AUDI.CDSITUACAOAUDI = SITAUD.CDSITUACAOAUDI' +#13+
  '   AND SITAUD.CDSITUACAOAUDI = 1                  ' +#13+
  '   AND EXISTS (SELECT 1                           ' +#13+
  '                 FROM %SEFPGPROCESSO              ' +#13+
  '                WHERE NUPROCESSO = %S             ' +#13+
  '                AND AUDI.CDPROCESSO = CDPROCESSO) ';

SQL_RETORNA_DOCUMENTO_EMITIDO =
  'SELECT COUNT(1) TOTAL                       ' + #13 +
  '  FROM %SEDIGPROCESSODOC                    ' + #13 +
  ' WHERE CDPROCESSO = (SELECT CDPROCESSO      ' + #13 +
  '                       FROM %SEFPGPROCESSO  ' + #13 +
  '                      WHERE NUPROCESSO = %S)';

// 26/05/2015 - MURILO.CRISTIANO - SALT: 186660/2/2
//SQL_RETORNA_QTDE_REGISTRO_PAUTA_AUD_TABELADO =
//  'SELECT COUNT(1) QTDE                                                                                              ' + #13 +    esse não existe em outro lugar
//  '  FROM EGGPAUDIENCIA EPA                                                                                          ' + #13 +
//  ' WHERE TO_DATE(EPA.DTINICIO, ''DD/MM/YYYY'') BETWEEN TO_DATE(%S, ''DD/MM/YYYY'') AND TO_DATE(%S, ''DD/MM/YYYY'')  ';

SQL_RETORNA_MUDOU_VARA =
  ' %S                                             ' + #13 +
  '  FROM %SEFPGDISTPROCESSO EDP,                  ' + #13 +
  '       (SELECT NUSEQDISTRIB, CDVARA, CDPROCESSO ' + #13 +
  '          FROM %SEFPGDISTPROCESSO               ' + #13 +
  '         WHERE FLULTDISTRIBUICAO = ''S'') EDP1  ' + #13 +
  '  WHERE EDP.CDPROCESSO = EDP1.CDPROCESSO        ' + #13 +
  '    AND EDP.CDPROCESSO = %S                     ' + #13 +
  '    %S                                          ';

SQL_RETORNA_CADASTRO_CONTATO =
  'SELECT COUNT(1) TOTAL  ' + #13 +
  '  FROM %sESAJPESSOADOC ' + #13 +
  ' WHERE NUDOCUMENTO = %s' ;

SQL_RETORNA_CDPROCESSO =
  'SELECT CDPROCESSO        ' + #13 +
  '  FROM %sEFPGPROCESSO    ' + #13 +
  ' WHERE NUPROCESSO LIKE %S';

SQL_VERIFICA_CADASTRO_PARTE =
  'SELECT COUNT(1) ENCONTROU                       ' +#13+
  '  FROM %SESAJPESSOA EP,                         ' +#13+
  '       %SEFPGPARTE E                            ' +#13+
  ' WHERE EP.CDPESSOA = %S                         ' +#13+
  '   AND E.CDPESSOA = EP.CDPESSOA                 ' +#13+
  '   AND EXISTS (SELECT 1                         ' +#13+
  '                 FROM %SEFPGPROCESSO            ' +#13+
  '                WHERE CDPROCESSO = E.CDPROCESSO ' +#13+
  '                  AND NUPROCESSO like %S)       ';

SQL_RETORNA_MUDOU_VAGA =
  'SELECT CASE WHEN EDP.CDVAGA = %S                   ' + #13 +
  '       THEN 1                                      ' + #13 +
  '       ELSE 0 END ENCONTROU                        ' + #13 +
  '  FROM %SEFPGDISTPROCESSO EDP                      ' + #13 +
  ' WHERE EDP.CDPROCESSO = (SELECT CDPROCESSO         ' + #13 +
  '                           FROM %SEFPGPROCESSO     ' + #13 +
  '                          WHERE NUPROCESSO LIKE %S)' + #13 +
  '    AND EDP.FLULTDISTRIBUICAO = ''S''              ' ;

SQL_RETORNA_REALMENTE_ENCAMINHOU =
  'SELECT CASE WHEN EP.CDFORODESTINO IS NOT NULL' + #13 +
  '       THEN 1                                ' + #13 +
  '       ELSE 0 END ENCONTROU                  ' + #13 +
  '  FROM %SEFPGPROCESSO EP                     ' + #13 +
  ' WHERE NUPROCESSO like %S                    ';

SQL_VERIFICA_CADASTRO_BEM =
  'SELECT COUNT(1) TOTAL                                               ' + #13 +
  '  FROM %SEFPGBEM BEM                                                ' + #13 +
  '  LEFT JOIN %SEFPGITEMBEM ITEM ON (BEM.CDPROCESSO = ITEM.CDPROCESSO)' + #13 +
  ' WHERE EXISTS (SELECT 1                                             ' + #13 +
  '                 FROM %SEFPGPROCESSO                                ' + #13 +
  '                WHERE NUPROCESSO = %S                               ' + #13 +
  '                  AND CDPROCESSO = BEM.CDPROCESSO)                  ';

//27/05/2015 - LUCIANO.FAGUNDES - SALT: 186660/2/6
//SQL_VERIFICA_PETICAO_EXCEPCIONAL_INICIAL =
//  ' SELECT COUNT(1) ENCONTROU           ' + #13 +
//  '   FROM %SEPROPROTOCOLO@DBLINKCENTRAL' + #13 +
//  '  WHERE NUPROTOCOLO = %S             ';

SQL_VERIFICA_PETICAO_CADASTRADA =
'SELECT COUNT(1) PETICAO                                ' + #13 +
 ' FROM %sEFPGPROCESSO EP                            ' + #13 +
' WHERE EXISTS (SELECT 1                                ' + #13 +
'                 FROM %SEFPGPROCESSO                   ' + #13 +
'                WHERE CDPROCESSOPRINC IS NULL          ' + #13 +
'                  AND NUPROCESSO = %S)                 ' + #13 +
//'                  AND CDPROCESSO = EP.CDPROCESSOPRINC) ' + #13 +
'   AND %S = %S                                         ' + #13 +
'   AND CDCLASSEPROCESSO = %S                           ';

//28/05/2015 - CARLOS.GASPAR - Salt: 186660/2/7
SQL_RETORNA_NUMERO_PROCESSO =
  'SELECT NUPROCESSO DADOS            ' + #13 +
  '  FROM %sEFPGPROCESSO@DBLINKCENTRAL' + #13 +
  ' WHERE FLPROCVIRTUAL = ''S''       ' + #13 +
  '   AND DTRECEBIMENTO >= %s         ';   // TO_DATE(''01/01/2015'', ''DD/MM/YYYY'') ' ;

//SQL_CHECAR_PROTOCOLO_DOCUMENTO =
//  'SELECT COUNT(1) ENCONTROU               ' + #13 +
//  '  FROM %SEPROPROTOCOLO EPLINK,          ' + #13 +
//  '       %SEFPGPROCESSO@DBLINKCENTRAL EP  ' + #13 +
//  ' WHERE EPLINK.NUPROCESSO LIKE %S        ' + #13 +
//  '   AND EP.NUPROCESSO = EPLINK.NUPROCESSO' + #13 +
//  '   AND EPLINK.NUPROTOCOLO = %S          ';

//28/05/2015 - ANTONIO.SOUSA - Salt: 186660/2/4
SQL_CHECAR_PROTOCOLO =
  'SELECT COUNT(1) ENCONTROU     ' + #13 +
  '  FROM %SEPROPROTOCOLO EPLINK ' + #13 +
  ' WHERE EPLINK.NUPROTOCOLO = %S';

//11/06/2015 - cesar.almeida - SALT: 186660/4/2
SQL_PROPRIEDADES_DOCUMENTO =
  'SELECT EDIG.FLJUNTADO LIBERADO,          ' + #13 +
  '       EEDT.DTFINALIZACAO FINALIZADO,    ' + #13 +
  '       EEDT.FLASSINATDIGITAL ASSINADO    ' + #13 +
  '  FROM %SEDIGPROCESSODOC EDIG,           ' + #13 +
  '       %SEEDTDOCEMITIDO EEDT,            ' + #13 +
  '       %SEFPGPROCESSO P                  ' + #13 +
  ' WHERE EDIG.CDPROCESSO = EEDT.CDPROCESSO ' + #13 +
  '   AND EDIG.CDPROCESSO = P.CDPROCESSO    ' + #13 +
  '   AND P.NUPROCESSO = %S                 ' + #13 +
  '   AND EEDT.CDDOCUMENTO = %S             ';

SQL_VERICAR_PETICAO_INICIAL =
  'SELECT COUNT(1) TOTAL             ' + #13 +
  '  FROM %SEFPGPROCESSO             ' + #13 +
  ' WHERE NUPROCESSO LIKE %S         ' + #13 +
  '   AND TPSIGILO = %S              ' + #13 +
  '   AND CDSITUACAOPROCESSO <> ''C''';

SQL_RETORNAR_PROCESSO_MOV_UNITARIA =
  ' SELECT EP.NUPROCESSO                              ' + #13 +
  '   FROM %sEFPGPROCESSO EP                          ' + #13 +
  '  WHERE EP.FLPROCVIRTUAL = ''S''                   ' + #13 +
  '    AND EP.CDSITUACAOPROCESSO <> ''C''             ' + #13 +
  '    AND EXISTS (SELECT 1                           ' + #13 +
  '                  FROM %sEFPGPROCESSOMV            ' + #13 +
  '                 WHERE CDPROCESSO = EP.CDPROCESSO) ';

SQL_VERIFICAR_MOV_UNITARIA =
  'SELECT COUNT(1) TOTAL                                                                 ' + #13 +
  '  FROM %SEFPGPROCESSOMV EPA                                                           ' + #13 +
  ' WHERE NUSEQPROCESSOMV > 1                                                            ' + #13 +
  '   AND CDTIPOMVPROCESSO = (SELECT CDTIPOMVPROCESSO                                    ' + #13 +
  '                             FROM %SEFPGTIPOMVPROCESSO                                ' + #13 +
  '                            WHERE ((CDTIPOMVEXT IS NOT NULL AND (CDTIPOMVEXT = %S))OR ' + #13 +
  '                                   (CDTIPOMVEXT IS NULL AND (CDTIPOMVPROCESSO = %S))))' + #13 +
  '   AND EXISTS (SELECT 1                                                               ' + #13 +
  '                 FROM %SEFPGPROCESSO                                                  ' + #13 +
  '                WHERE CDPROCESSO = EPA.CDPROCESSO                                     ' + #13 +
  '                  AND NUPROCESSO LIKE %S)                                             ';

//29/06/2015 - CARLOS.GASPAR - Salt: 186660/6/4
SQL_VERIFICAR_SENTENCA =
  'SELECT COUNT(1) TOTAL                                                     ' + #13 +
  '  FROM %SEFPGPROCESSOMV EPA                                               ' + #13 +
  '  LEFT JOIN %SEEDTDOCEMITIDO EDE ON (EDE.CDPROCESSO = EPA.CDPROCESSO AND  ' + #13 +
  '  %S                                                                      ' + #13 +
  '  LEFT JOIN %SEFPGREGSENTENCA ERS ON (ERS.CDPROCESSO = EPA.CDPROCESSO AND ' + #13 +
  '  %S                                                                      ' + #13 +
  ' WHERE EPA.NUSEQPROCESSOMV > 1                                            ' + #13 +
  '   AND EPA.CDTIPOMVPROCESSO = %S                                          ' + #13 +
  '   AND %S                                                                 ' + #13 +
  '   AND EXISTS (SELECT 1                                                   ' + #13 +
  '                 FROM %SEFPGPROCESSO                                      ' + #13 +
  '                WHERE CDPROCESSO = EPA.CDPROCESSO                         ' + #13 +
  '                  AND NUPROCESSO LIKE %S)                                 ' + #13 +
  '   AND ERS.CDDOCUMENTO = (SELECT MAX(CDDOCUMENTO)                         ' + #13 +
  '                            FROM %SEFPGREGSENTENCA                        ' + #13 +
  '                           WHERE CDPROCESSO = ERS.CDPROCESSO)             ' + #13 +
  '   AND EDE.CDDOCUMENTO = ERS.CDDOCUMENTO                                  ';

(*SQL_VERIFICAR_SENTENCA =
  'SELECT COUNT(1) TOTAL                            ' + #13 +
  '  FROM EFPGPROCESSOMV EPM                        ' + #13 +
  ' WHERE EPM.CDTIPOMVPROCESSO = %S                 ' + #13 +
  '   AND EXISTS (SELECT 1                          ' + #13 +
  '                 FROM EFPGPROCESSO               ' + #13 +
  '                WHERE CDPROCESSO = EPM.CDPROCESSO' + #13 +
  '                  AND CDSITUACAOPROCESSO <> ''C''' + #13 +
  '                  AND NUPROCESSO LIKE %S)        ' ;       *)

SQL_VERIFICAR_ASSUNTO_INSERIDO =
  'SELECT COUNT(1) TOTAL                            ' + #13 +
  '  FROM %SEFPGPROCESSOASSUNT EPA                  ' + #13 +
  ' WHERE EXISTS (SELECT 1                          ' + #13 +
  '                 FROM %SEFPGPROCESSO             ' + #13 +
  '                WHERE CDPROCESSO = EPA.CDPROCESSO' + #13 +
  '                  AND NUPROCESSO LIKE %S)        ' ;

SQL_VERIFICAR_APENSAMENTO =
  'SELECT COUNT(1) TOTAL                             ' + #13  +
  '  FROM %SEFPGPROCESSOAPENSO EPA                   ' + #13  +
  ' WHERE EPA.CDPROCESSO = %S                        ' + #13  +
  '   AND EXISTS (SELECT 1                           ' + #13  +
  '                 FROM %SEFPGPROCESSO              ' + #13  +
  '                WHERE CDPROCESSO = EPA.CDPROCESSO ' + #13  +
  '                  AND CDSITUACAOPROCESSO <> ''C'')' ;

//10/06/2015 - LUCIANO.FAGUNDES - SALT: 186660/4/7
SQL_VERIFICA_NUPROCESSO  =
  'SELECT FLFINALIZADO,      ' + #13 +
  '       FLPROCVIRTUAL,     ' + #13 +
  '       NUPROTOCOLO        ' + #13 +
  '  FROM %SEFPGPROCESSO     ' + #13 +
  ' WHERE NUPROCESSO LIKE %S ' ;

//SQL_RETOENAR_PROCESSO_RETIFICACAO =
//  'SELECT PR.NUPROCESSO                                 ' + #13 +
//  '  FROM EFPGPROCESSO PR                               ' + #13 +
//  ' WHERE FLPROCVIRTUAL = ''S''                         ' + #13 +
//  '   AND ROWNUM = 1                                    ' + #13 +
//  '   AND CDSITUACAOPROCESSO <> ''C''                   ' + #13 +
//  '   AND NOT EXISTS (SELECT 1                          ' + #13 +
//  '                     FROM EFPGPROCESSOASSUNT         ' + #13 +
//  '                    WHERE CDASSUNTO = %S             ' + #13 +
//  '                      AND CDPROCESSO = PR.CDPROCESSO)' ;

// 16/06/2015 - MURILO.CRISTIANO - SALT: 186660/4/3
SQL_RETORNAR_PROCESSOS_MOVIMENTACOES_LOTE =
  'SELECT DISTINCT NUPROCESSO FROM (                            ' + #13 +
  'SELECT EPROC.NUPROCESSO, TPSIGILO                            ' + #13 +
  '  FROM %sEFPGPROCESSO EPROC                                  ' + #13 +
  ' WHERE EPROC.FLPROCVIRTUAL = ''S''                           ' + #13 +
  '   AND EPROC.CDSITUACAOPROCESSO <> ''C''                     ' + #13 +
  '   AND NOT EXISTS (SELECT 1                                  ' + #13 +
  '                     FROM %sEFPGPROCESSOMV EPM               ' + #13 +
  '                    WHERE EPM.CDPROCESSO = EPROC.CDPROCESSO) ' + #13 +
  '   AND NOT EXISTS (SELECT 1                                  ' + #13 +
  '                     FROM %sEFPGPROCESSO                     ' + #13 +
  '                    WHERE nuprocesso = EPROC.nuprocesso      ' + #13 +
  '                      AND TPSIGILO <> ''N''))                ' + #13 +
  ' WHERE TPSIGILO = ''N''                                      ';

// 16/06/2015 - MURILO.CRISTIANO - SALT: 186660/4/3
SQL_CHECAR_MOVIMENTACOES_LANCADAS_EM_LOTE =
  'SELECT COUNT(DISTINCT CDPROCESSO) AS CDPROCESSO ' + #13 +
  '  FROM %SEFPGPROCESSOMV EPM                     ' + #13 +
  ' WHERE EXISTS (SELECT 1                         ' + #13 +
  '                FROM %SEFPGPROCESSO             ' + #13 +
  '               WHERE CDPROCESSO = EPM.CDPROCESSO' + #13 +
  '                 AND CDSITUACAOPROCESSO <> ''C''' + #13 +
  '                 AND NUPROCESSO IN (%S))        ';

//17/06/2015 - LUCIANO.FAGUNDES - SALT: 186660/4/7
SQL_RETORNA_PROCESSO_EMISSAO_DOC_DTALTERADA =
  'SELECT EP.NUPROCESSO                            ' + #13 +
  '  FROM %SEFPGPROCESSO EP                        ' + #13 +
  ' WHERE EP.FLPROCVIRTUAL = ''N''                 ' + #13 +
  '   AND EP.CDSITUACAOPROCESSO <> ''C''           ' + #13 +
  '   AND EXISTS (SELECT 1                         ' + #13 +
  '                FROM %SEFPGPROGDISTRIB          ' + #13 +
  '               WHERE CDPROCESSO = EP.CDPROCESSO)';

//19/06/2015 - LUCIANO.FAGUNDES - SALT: 186660/4/7
SQL_VERIFICA_DTMOV_DOCUMENTO =
  'SELECT COUNT(1) AS DATA                  ' + #13 +
  '  FROM %SEEDTDOCEMITIDO PROMV,           ' + #13 +
  '       %SEFPGPROCESSO PRO                ' + #13 +
  ' WHERE PRO.NUPROCESSO LIKE %S            ' + #13 +
  '   AND PRO.CDPROCESSO = PROMV.CDPROCESSO ' + #13 +
  '   AND %S = %S                           ';

SQL_RETORNA_NUPROCESSO_NAOFINALIZADO =
  ' SELECT DISTINCT(PRO.NUPROCESSO) AS NUPROCESSO' + #13 +
  '   FROM %SEEDTDOCEMITIDO DOCEM,               ' + #13 +
  '        %SEFPGPROCESSO PRO                    ' + #13 +
  '  WHERE DOCEM.DTFINALIZACAO IS NULL           ' + #13 +
  '    AND PRO.CDPROCESSO = DOCEM.CDPROCESSO     ';

//19/06/2015 - ANTONIO.SOUSA - SALT: 186660/6/7
SQL_VERIFICA_RECADO_INSERIDO =
  'SELECT COUNT(1) TOTAL       ' + #13 +
  '  FROM %SESAJRECADO         ' + #13 +
  ' WHERE CDUSUARIODESTINO = %S' + #13 +
  '   AND FLEXCLUIDO = ''N''   ' + #13 +
  '   AND DERECADO = %S        ';

//23/06/2015 - ANTONIO.SOUSA - SALT: 186660/6/7
SQL_VERIFICA_AUTOTEXTO =
  'SELECT COUNT(1) TOTAL                          ' + #13 +
  '  FROM %SEEDTAUTOTEXTOGRUPO EATG,              ' + #13 +
  '       %SEEDTAUTOTEXTO EAT                     ' + #13 +
  ' WHERE EATG.NUSEQAUTOTEXTO = EAT.NUSEQAUTOTEXTO' + #13 +
  '   AND EATG.CDUSUARIO = EAT.CDUSUARIO          ' + #13 +
  '   AND EATG.CDUSUARIO = %S                     ' + #13 +
  '   AND EAT.NMABREVAUTOTEXTO = %S               ' + #13 +
  '   AND EATG.CDGRUPO = %S                       ';

//23/06/2015 - LUCIANO.FAGUNDES - SALT: 186660/6/6
SQL_RETORNA_NUPROCESSO_FISICO_APREENSAO =
  'SELECT NUPROCESSO                 ' + #13 +
  '  FROM %SEFPGPROCESSO             ' + #13 +
  ' WHERE CDSITUACAOPROCESSO <> ''C''' + #13 +
  '   AND FLPROCVIRTUAL = ''N''      ';

//23/06/2015 - LUCIANO.FAGUNDES - SALT: 186660/6/6
SQL_VERIFICA_NUPROCESSO_FISICO_APREENSAO =
  'SELECT COUNT(1) AS VERIFICADO        ' + #13 +
  '  FROM %SEFPGBEM EB,                 ' + #13 +
  '       %SEFPGPROCESSO EP             ' + #13 +
  ' WHERE EB.CDPROCESSO = EP.CDPROCESSO ' + #13 +
  '   AND EP.NUPROCESSO LIKE %S         ' + #13 +
  '   AND %S = %S                       ' + #13 +                 //TRUNC(EB.DTENTRADA) = %STRUNC(SYSDATE)
  '   AND EB.CDCATEGORIABEM = %S        ' ;

//SQL_VERIFICA_EXCLUSAO_MOVIMENTACAO = '';
//    ' SELECT COUNT(1) TOTAL         ' + #13 +
//    '   FROM EFPGPROCESSOMV EPM     ' + #13 +
//    '  WHERE EPM.CDPROCESSO = %S    ' + #13 +
//    '    AND DTEXCLUSAO like %S     ';

SQL_VERIFICA_EXCLUSAO_MOVIMENTACAO =
  'SELECT COUNT(1) TOTAL                                           ' + #13 +
  '  FROM %SEFPGPROCESSOMV EPM                                     ' + #13 +
  ' WHERE EPM.CDPROCESSO = %S                                      ' + #13 +
  '   /*AND %S = %S  */                                                ' + #13 +     //TRUNC(EPM.DTEXCLUSAO) = TRUNC(SYSDATE)
  '   AND EPM.NUSEQPROCESSOMV = (SELECT MAX(NUSEQPROCESSOMV)       ' + #13 +
  '                                FROM %SEFPGPROCESSOMV           ' + #13 +
  '                               WHERE CDPROCESSO = EPM.CDPROCESSO' + #13 +
  '                                /* AND %S = %S  */)                 ';            //TRUNC(DTEXCLUSAO) = TRUNC(SYSDATE)) ';

//25/06/2015 - ANTONIO.SOUSA - SALT: 186660/6/7
SQL_RETORNA_NUPROCESSO_EDICAO_DOC =
  'SELECT %S NUPROCESSO              ' + #13 +
  '  FROM %SEFPGPROCESSO             ' + #13 +
  ' WHERE FLPROCVIRTUAL = ''S''      ' + #13 +
  '   AND CDSITUACAOPROCESSO <> ''C''' + #13 +
  '   AND NUSEQULTIMAMV = 1          ' ;

SQL_VERIFICAR_PETICAO_DIVERSA =
  'SELECT COUNT(1) TOTAL                                  ' + #13 +
  '  FROM %SEFPGPROCESSO P,                               ' + #13 +
  '       %SEFPGPROCESSOASSUNT PA,                        ' + #13 +
  '       %SESAJASSUNTO EA                                ' + #13 +
  ' WHERE PA.CDPROCESSO = P.CDPROCESSO                    ' + #13 +
  '   AND EA.CDASSUNTO = PA.CDASSUNTO                     ' + #13 +
  '  AND EXISTS (SELECT 1                                 ' + #13 +
  '                FROM %SEFPGPROCESSO EP                 ' + #13 +
  '               WHERE P.CDPROCESSOMASTER = EP.CDPROCESSO' + #13 +
  '                 AND EP.NUPROCESSO like %S             ' + #13 +
  '                 AND EP.NUPROCESSO = P.NUPROCESSO)     ';

SQL_RETORNA_DOC_EMITIDO =
  'SELECT COUNT(1) TOTAL                              ' + #13 +
  '  FROM %SEEDTDOCEMITIDO EDOC                       ' + #13 +
  ' WHERE EDOC.FLASSINATDIGITAL = ''S''               ' + #13 +
  '   AND %S = %S                                     ' + #13 +
  '   AND EDOC.CDCATEGORIA = %S                       ' + #13 +
  '   AND EDOC.CDMODELO = %S                          ' + #13 +
  '   AND EXISTS (SELECT 1                            ' + #13 +
  '                 FROM %SEFPGPROCESSO               ' + #13 +
  '                WHERE CDPROCESSO = EDOC.CDPROCESSO ' + #13 +
  '                  AND NUPROCESSO LIKE %S)          ';

{ Data de Criação:  01/07/2015  Responsável: Shirleano.Junior  Salt:186660/6/5 }
SQL_VERIFICA_CADASTRO_PROCESSO_PROTOCOLO =
  'SELECT COUNT(1) TOTAL                            ' + #13 +
  '  FROM %SEFPGPROCESSO EP                         ' + #13 +
  ' WHERE EP.FLPROCVIRTUAL = ''S''                  ' + #13 +
  '   AND NUPROCESSO = %S                           ' + #13 +
  '   AND EXISTS (SELECT 1                          ' + #13 +
  '                 FROM %SEFPGPROCESSOMV           ' + #13 +
  '                WHERE CDPROCESSO = EP.CDPROCESSO)';

//   04/08/2015  - Carlos.Gaspar - SALT: 186660/9/4
//  SQL_RETORNA_PROCESSO_FISICO =
//  'SELECT NUPROCESSO                                               ' + #13 +
//  '  FROM (SELECT SUBSTR(EP.NUPROCESSO,1,13) NUPROCESSO            ' + #13 +
//  '          FROM EFPGPROCESSO EP                                  ' + #13 +
//  '         WHERE EP.CDSITUACAOPROCESSO <> ''C''                   ' + #13 +
//  '           AND EP.FLPROCVIRTUAL = ''N''                         ' + #13 +
//  '           AND EP.CDVARA = 23                                   ' + #13 +
//  '           AND NOT EXISTS (SELECT 1                             ' + #13 +
//  '                             FROM ESAJPENDENCIAPRAZO            ' + #13 +
//  '                            WHERE CDPROCESSO = EP.CDPROCESSO)   ' + #13 +
//  '           AND EXISTS (SELECT 1                                 ' + #13 +
//  '                         FROM EFPGdistprocesso                  ' + #13 +
//  '                        WHERE CDPROCESSO = EP.CDPROCESSO        ' + #13 +
//  '                          AND TPDISTRIBUICAO = ''D''            ' + #13 +
//  '                          AND FLULTDISTRIBUICAO = ''S'')        ' + #13 +
//  '         ORDER BY DBMS_RANDOM.VALUE())                          ' + #13 +
//  ' WHERE ROWNUM = 1                                               ';

//SQL_VERIFICAR_PROCESSO_DIGITAL =
//  'SELECT NUPROCESSO                                     ' + #13 +
//  '          FROM EFPGPROCESSO EP                                ' + #13 +
//  '         WHERE EP.CDSITUACAOPROCESSO <> ''C''                 ' + #13 +
//  '           AND EP.FLPROCVIRTUAL = ''N''                       ' + #13 +
//  '           AND NOT EXISTS (SELECT 1                           ' + #13 +
//  '                             FROM ESAJPENDENCIAPRAZO          ' + #13 +
//  '                            WHERE CDPROCESSO = EP.CDPROCESSO) ' + #13 +
//  '           AND EXISTS (SELECT 1                               ' + #13 +
//  '                         FROM EFPGdistprocesso                ' + #13 +
//  '                        WHERE CDPROCESSO = EP.CDPROCESSO      ' + #13 +
//  '                          AND TPDISTRIBUICAO = ''D''          ' + #13 +
//  '                          AND FLULTDISTRIBUICAO = ''S'')      ';

SQL_VERIFICAR_DISTRIBUICAO_PROCESSOS =
  'SELECT COUNT(1) TOTAL                            ' + #13 +
  '  FROM %SEFPGPROCESSOMV EPM                      ' + #13 +
  ' WHERE %S = %S                                   ' + #13 +
  ' --AND EPM.NUSEQPROCESSOMV = 2                   ' + #13 +
  '   AND EPM.CDSITUACAOPROCESSO <> ''C''           ' + #13 +
  '   AND EXISTS (SELECT 1                          ' + #13 +
  '                 FROM %SEFPGPROCESSO             ' + #13 +
  '                WHERE EPM.CDPROCESSO = CDPROCESSO' + #13 +
  '                  AND NUPROCESSO IN (%S))        ';

//02/07/2015 - ANTONIO.SOUSA - SALT: 186660/6/7
SQL_RETORNA_PROCESSO_ALTERACAO =
  'SELECT NUPROCESSO                 ' + #13 +
  '  FROM %SEFPGPROCESSO             ' + #13 +
  ' WHERE FLPROCVIRTUAL = ''S''      ' + #13 +
  '   AND CDSITUACAOPROCESSO <> ''C''' + #13 +
  '   AND NUSEQULTIMAMV = 1          ';

SQL_RETORNA_NOME_DOC =
  'SELECT COUNT(1) TOTAL  ' + #13 +
  '  FROM %SEEDTDOCEMITIDO' + #13 +
  ' WHERE NMDOCUMENTO = %S' + #13 +
  '   AND CDCATEGORIA = %S' + #13 +
  '   AND CDMODELO = %S   ' ;

SQL_RETORNA_NUPROCESSO_VIRTUAL_EXPEDIENTE_FINAL =
  'SELECT NUPROCESSO                     ' + #13 +
  '  FROM %SEFPGPROCESSO                 ' + #13 +
  ' WHERE CDSITUACAOPROCESSO <> ''C''    ' + #13 +
  '   AND FLPROCVIRTUAL = ''S''          ';

SQL_VERIFICA_PROCESSO_LIBERADO_AUTOS =
  ' SELECT COUNT(1) TOTAL                         ' + #13 +
  '   FROM %SEEDTDOCEMITIDO                       ' + #13 +
  '  WHERE CDPROCESSO = (SELECT CDPROCESSO        ' + #13 +
  '                        FROM %SEFPGPROCESSO    ' + #13 +
  '                       WHERE NUPROCESSO = %S ) ' + #13 +
  '    AND FLASSINATDIGITAL = ''S''               ' + #13 +
  '    AND %S = %S                                ' + #13 +
  '    AND CDCATEGORIA = %S                       ' + #13 +
  '    AND CDMODELO = %S                          ' ;

SQL_RETORNA_CORRECAO_CLASSE =
  'SELECT CASE WHEN EHC.CDCLASSE <> EHC1.CDCLASSE     ' + #13 +
  '     THEN 1                                        ' + #13 +
  '     ELSE 0 END RESULTADO                          ' + #13 +
  '  FROM %SEFPGHISTCLASSE EHC,                       ' + #13 +
  '       %SEFPGHISTCLASSE EHC1                       ' + #13 +
  ' WHERE EHC.CDPROCESSO = (SELECT CDPROCESSO         ' + #13 +
  '                           FROM %SEFPGPROCESSO     ' + #13 +
  '                          WHERE NUPROCESSO LIKE %S)' + #13 +
  '   AND EHC.CDPROCESSO = EHC1.CDPROCESSO            ' + #13 +
  '   AND EHC.FLULTHISTCLASSE = ''N''                 ' + #13 +
  '   AND EHC1.FLULTHISTCLASSE = ''S''                ' + #13 +
  '   AND %S = %S                                     ';

//LUCIANO.FAGUNDES  - 07/07/2015 - SALT: 186660/8/8
SQL_RETORNA_NUPROCESSO_SIMPLES =
  'SELECT NUPROCESSO TESTE                                 ' + #13 +
  '  FROM %SEFPGPROCESSO PRO                               ' + #13 +
  ' WHERE EXISTS (SELECT 1                                 ' + #13 +
  '                 FROM %SEFPGDISTPROCESSO                ' + #13 +
  '                WHERE CDPROCESSO = PRO.CDPROCESSO       ' + #13 +
  '                  AND TPDISTRIBUICAO = ''D''            ' + #13 +
  '                  AND FLULTDISTRIBUICAO = ''S'')        ' + #13 +
  '   AND NOT EXISTS(SELECT 1                              ' + #13 +
  '                    FROM %SEFPGBEM EP                   ' + #13 +
  '                   WHERE PRO.CDPROCESSO = EP.CDPROCESSO)';

SQL_RETORNA_PROCESSO_DOCUMENTO_COMPARTILHAR =
  'SELECT DISTINCT %S NUPROCESSO                            ' + #13 +
  '  FROM %SEFPGPROCESSO PRO,                               ' + #13 +
  '       %SEEDTDOCEMITIDO DOCPRO                           ' + #13 +
  ' WHERE DOCPRO.CDPROCESSO = PRO.CDPROCESSO                ' + #13 +
  '   AND NOT EXISTS (SELECT 1                              ' + #13 +
  '                     FROM %SEEDTDOCEMITIDO DOC           ' + #13 +
  '                    WHERE DOC.CDPROCESSO = PRO.CDPROCESSO' + #13 +
  '                      and DOC.DTFINALIZACAO IS NULL)     ';

SQL_VERIFICAR_EXISTE_PROCESSO_DISTRIBUICAO =
'SELECT COUNT(1) EXISTE_PROCESSO                                     ' + #13 +
'  FROM %SEFPGPROCESSO P                                             ' + #13 +
'  LEFT JOIN %SEFPGPARTE PAP ON (P.CDPROCESSO = PAP.CDPROCESSO       ' + #13 +
'						    AND P.CDPARTEATIVAPRINC = PAP.CDPESSOA), ' + #13 +
'       %SESAJSITPROCESSO SP,                                        ' + #13 +
'       %SESAJCLASSE CL,                                             ' + #13 +
'       %SESAJTIPOCARTORIO TC,                                       ' + #13 +
'       %SEFPGPROGDISTRIB PD,                                        ' + #13 +
'       %SEFPGTIPODISTRIB TD                                         ' + #13 +
' WHERE SP.CDSITUACAOPROCESSO = P.CDSITUACAOPROCESSO                 ' + #13 +
'   AND P.CDVARA IS NULL                                             ' + #13 +
'   AND CL.CDCLASSE = P.CDCLASSEPROCESSO                             ' + #13 +
'   AND TC.CDTIPOCARTORIO = P.CDTIPOCARTORIO                         ' + #13 +
'   AND PD.CDPROCESSO = P.CDPROCESSO                                 ' + #13 +
'   AND PD.CDTIPODISTRIB = TD.CDTIPODISTRIB                          ' + #13 +
'   AND P.DTUSUINCLUSAO BETWEEN  %S and %s                           ' + #13 +
'   AND P.CDFORO = %S                                                ' + #13 +
'   AND P.CDTIPOCARTORIO = %S                      			             ';


SQL_VERIFICAR_ENCAMINHAMENTO =
  'SELECT COUNT(1) TOTAL                                                                     ' + #13 +
  '  FROM (SELECT COUNT(1)                                                                   ' + #13 +
  '          FROM %SEFPGPROCESSOMV                                                           ' + #13 +
  '         WHERE CDPROCESSO = (SELECT CDPROCESSO FROM EFPGPROCESSO WHERE NUPROCESSO LIKE %S)' + #13 +
  '           AND NUSEQDISTRIB = 1                                                           ' + #13 +
  '           AND CDSITUACAOPROCESSO = ''F''                                                 ' + #13 +
  '           AND DECOMPLEMENTOMV IS NOT NULL                                                ' + #13 +
  '           AND %S = %S                                                                    ' + #13 +             //TRUNC(DTMOVIMENTO) = TRUNC(SYSDATE
  '   UNION ALL                                                                              ' + #13 +
  '        SELECT COUNT(1)                                                                   ' + #13 +
  '          FROM %SEFPGPROCESSOMV                                                           ' + #13 +
  '         WHERE CDPROCESSO = (SELECT CDPROCESSO FROM EFPGPROCESSO WHERE NUPROCESSO LIKE %S)' + #13 +
  '           AND NUSEQDISTRIB = 2                                                           ' + #13 +
  '           AND CDSITUACAOPROCESSO = ''N''                                                 ' + #13 +
  '           AND DECOMPLEMENTOMV IS NOT NULL                                                ' + #13 +
  '           AND  %S = %S) TABELA                                                           ';  // TRUNC(DTMOVIMENTO) = TRUNC(SYSDATE)

SQL_EXISTE_DOCUMENTO_PROCESSO =
  'SELECT COUNT(1) DOC                       ' + #13 +
  '  FROM %SEEDTDOCEMITIDO DOC,              ' + #13 +
  '       %SEEDTDOCBINARIO BIN,              ' + #13 +
  '       %SEFPGPROCESSO P                   ' + #13 +
  ' WHERE DOC.CDDOCBINARIO = BIN.CDDOCBINARIO' + #13 +
  '   AND DOC.CDPROCESSO = P.CDPROCESSO      ' + #13 +
  '   AND P.NUPROCESSO LIKE %S               ';

SQL_RETORNA_PROCESSO_DISTRIBUIDO_SEM_PENDENCIA =
  'SELECT %S NUPROCESSO                                 ' + #13 +
  '  FROM %SEFPGPROCESSO EP                             ' + #13 +
  ' WHERE EP.CDSITUACAOPROCESSO <> ''C''                ' + #13 +
  '   AND EP.FLPROCVIRTUAL = ''N''                      ' + #13 +
  '   AND NOT EXISTS (SELECT 1                          ' + #13 +
  '                     FROM %SESAJPENDENCIAPRAZO       ' + #13 +
  '                    WHERE CDPROCESSO = EP.CDPROCESSO)' + #13 +
  '   AND EXISTS (SELECT 1                              ' + #13 +
  '                 FROM %SEFPGDISTPROCESSO             ' + #13 +
  '                WHERE CDPROCESSO = EP.CDPROCESSO)    ';

SQL_RETORNA_NUMERO_PROCESSO_LOCAL_FISICO =
  'SELECT NUPROCESSO, RAND() AS ID FROM (               ' + #13 +
  'SELECT %S NUPROCESSO                                 ' + #13 +
  '  FROM %SEFPGPROCESSO EP                             ' + #13 +
  ' WHERE EP.CDSITUACAOPROCESSO <> ''C''                ' + #13 +
  '   AND EP.FLPROCVIRTUAL = ''N''                      ' + #13 +
  '   AND EP.TPSIGILO = ''N''                           ' + #13 +
  '   AND NOT EXISTS (SELECT 1                          ' + #13 +
  '                     FROM %SESAJPENDENCIAPRAZO       ' + #13 +
  '                    WHERE CDPROCESSO = EP.CDPROCESSO)' + #13 +
  '   AND EXISTS (SELECT 1                              ' + #13 +
  '                 FROM %SEFPGDISTPROCESSO             ' + #13 +
  '                WHERE CDPROCESSO = EP.CDPROCESSO)    ' + #13 +
  '    AND CDFORO = %S)                                  ' + #13 +
  ' ORDER BY ID                                         ';

SQL_RETORNA_PROCESSO_VISUALIZA_DOCUMENTO =
  'SELECT DISTINCT %S NUPROCESSO,                       ' + #13 +
  '       P.DTUSUINCLUSAO                               ' + #13 +
  '  FROM %SEDIGPROCESSODOC EDIG,                       ' + #13 +
  '       %SEEDTDOCEMITIDO EEDT,                        ' + #13 +
  '       %SEFPGPROCESSO P                              ' + #13 +
  ' WHERE EDIG.CDPROCESSO = EEDT.CDPROCESSO             ' + #13 +
  '   AND EDIG.CDPROCESSO = P.CDPROCESSO                ' + #13 +
  '   AND P.CDSITUACAOPROCESSO <> ''C''                 ' + #13 +
  '   AND EXISTS (SELECT 1                              ' + #13 +
  '                 FROM %SESAJPENDENCIAPRAZO EPR       ' + #13 +
  '                WHERE EPR.CDPROCESSO = P.CDPROCESSO) ';

SQL_RETORNAR_PROCESSO_VIRTUALIZADO =
  'SELECT COUNT(1) TOTAL             ' + #13 +
  '  FROM %SEFPGPROCESSO             ' + #13 +
  ' WHERE CDSITUACAOPROCESSO <> ''C''' + #13 +
  '   AND FLPROCVIRTUAL = ''S''      ' + #13 +
  '   AND NUPROCESSO LIKE %S         ';

SQL_RETORNA_PROCESSO_BEM =
  'SELECT COUNT(1) ENCONTROU             ' + #13 +
  '  FROM %SEFPGBEM EB,                  ' + #13 +
  '       %SEFPGPROCESSO EP              ' + #13 +
  ' WHERE EB.CDPROCESSO = EP.CDPROCESSO  ' + #13 +
  '   AND EP.FLPROCVIRTUAL = ''S''       ' + #13 +
  '   AND EP.CDSITUACAOPROCESSO <> ''C'' ' + #13 +
  '   AND EP.NUSEQULTIMAMV = 1           ' + #13 +        
  '   AND EP.NUPROCESSO LIKE %S          ';

// 17/07/2015 - cesar.almeida - SALT: 186660/8/4
SQL_VERIFICAR_PROCESSO_DEPENDENTE =
  'SELECT COUNT(1) TOTAL         ' + #13 +
  '  FROM %SEFPGPROCESSO         ' + #13 +
  ' WHERE NUPROCESSO like %s     ' + #13 +
  '   AND NUPROTOCOLO IS NOT NULL' ;

//LUCIANO.FAGUNDES  - 17/07/2015 - SALT: 186660/8/8
SQL_VERIFICA_PETICAO_INTERMEDIARIA =
  'SELECT CASE WHEN COUNT(1) = 6    ' + #13 +
  '          THEN 1                 ' + #13 +
  '          ELSE 0 END VALIDADE    ' + #13 +
  '     FROM %SEFPGPROCESSO         ' + #13 +
  '    WHERE NUPROCESSO LIKE %s     ' + #13 +
  '      AND NUPROTOCOLO IS NOT NULL' + #13 +
  '      AND %S = %S                ';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICA_DISTRIBUICAO_PROCESSO =
  'SELECT COUNT(1) ENCONTROU                                            ' + #13 +
  '  FROM %SEFPGPROCESSO EP                                             ' + #13 +
  ' WHERE EP.CDSITUACAOPROCESSO <> ''C''                                ' + #13 +
  '   AND NOT EXISTS (SELECT 1                                          ' + #13 +
  '                     FROM %SESAJPENDENCIAPRAZO                       ' + #13 +
  '                    WHERE CDPROCESSO = EP.CDPROCESSO)                ' + #13 +
  '                      AND EXISTS (SELECT 1                           ' + #13 +
  '                                    FROM %SEFPGDISTPROCESSO          ' + #13 +
  '                                   WHERE CDPROCESSO = EP.CDPROCESSO) ' + #13 +
  '                      AND EP.NUPROCESSO LIKE %S                      ';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICA_PROCESSO_FISICO =
  'SELECT COUNT(1) ENCONTROU                            ' + #13 +
  '  FROM %SEFPGPROCESSO EP                             ' + #13 +
  ' WHERE EP.CDSITUACAOPROCESSO <> ''C''                ' + #13 +
  '   AND EP.FLPROCVIRTUAL = ''N''                      ' + #13 +
  '   AND EXISTS (SELECT 1                              ' + #13 +
  '                 FROM %SEFPGDISTPROCESSO             ' + #13 +
  '                WHERE CDPROCESSO = EP.CDPROCESSO)    ' + #13 +
  '   AND EP.NUPROCESSO LIKE %s                         ';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICA_PROCESSO_REMETIDO =
  'SELECT COUNT(1) REMETIDO            ' + #13 +
  '  FROM %SECGOCARGA EC,              ' + #13 +
  '       %SECGOLOTECARGA ELC,         ' + #13 +
  '       %SEFPGPROCESSO EP            ' + #13 +
  ' WHERE ELC.NULOTE = EC.NULOTE       ' + #13 +
  //'   AND EC.DTRECEBIMENTO IS NULL     ' + #13 +
  '   AND EC.NULOTE = %S               ' + #13 +
  '   AND EC.CDOBJETO = EP.CDOBJETO    ' + #13 +
  '   AND EP.NUPROCESSO LIKE  %S       ' + #13 +
  '   AND EC.CDLOCALDESTINO = %S  ';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICA_PROCESSO_RECEBIDO =
  'SELECT COUNT(1) RECEBIDO          ' + #13 +
  '  FROM %SECGOCARGA EC,            ' + #13 +
  '       %SECGOLOTECARGA ELC,       ' + #13 +
  '       %SEFPGPROCESSO EP          ' + #13 +
  ' WHERE ELC.NULOTE = EC.NULOTE     ' + #13 +
  '   AND %S = %S                    ' + #13 +
  '   AND EC.NULOTE = %S             ' + #13 +
  '   AND EC.CDOBJETO = EP.CDOBJETO  ' + #13 +
  '   AND EP.NUPROCESSO LIKE %S      ' + #13 +
  '   AND EC.CDLOCALDESTINO = %S';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICA_MOVIMENTACAO_PROCESSO =
  'SELECT COUNT(1) MOVIMENTACAO         ' + #13 +
  '  FROM %SEFPGPROCESSOMV EPM,         ' + #13 +
  '       %SEFPGPROCESSO EP,            ' + #13 +
  '       %SEFPGTIPOMVPROCESSO TMV      ' + #13 +
  ' WHERE EPM.CDPROCESSO = EP.CDPROCESSO' + #13 +
  '   AND EPM.CDTIPOMVPROCESSO = TMV.CDTIPOMVPROCESSO' + #13 +
  '   AND EP.NUPROCESSO LIKE %s         ' + #13 +
  '   AND CDTIPOMVEXT = %S              ' + #13 +
  '   AND %S = %S                       ' + #13 +
  '   AND DTEXCLUSAO IS NULL            ';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICA_MANDADO_EMITIDO =
  'SELECT COUNT(1) DOCEMITIDO           ' + #13 +
  '  FROM %SEEDTDOCEMITIDO EDE,         ' + #13 +
  '       %SEFPGPROCESSO EP             ' + #13 +
  ' WHERE EDE.CDPROCESSO = EP.CDPROCESSO' + #13 +
  '   AND EDE.CDCATEGORIA = %S          ' + #13 +
  '   AND EDE.CDMODELO = %S             ' + #13 +
  '   AND EP.NUPROCESSO LIKE %S         ' + #13 +
  '   AND EP.CDASSUNTOPRINC = %S        ';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICA_MANDADO_CRIADO =
  'SELECT COUNT(1) MANDADO             ' + #13 +
  '  FROM %SESMDMANDADO EM,            ' + #13 +
  '       %SEFPGPROCESSO EP            ' + #13 +
  ' WHERE EM.CDMODELO = %S             ' + #13 +
  '   AND EM.CDPROCESSO = EP.CDPROCESSO' + #13 +
  '   AND EP.NUPROCESSO LIKE %s        ';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICA_INTIMACAO_EMITIDA =
  'SELECT COUNT(1) DOCEMITIDO           ' + #13 +
  '  FROM %SEEDTDOCEMITIDO EDE,         ' + #13 +
  '       %SEFPGPROCESSO EP             ' + #13 +
  ' WHERE EDE.CDPROCESSO = EP.CDPROCESSO' + #13 +
  '   AND EDE.CDCATEGORIA = %S          ' + #13 +
  '   AND EDE.CDMODELO = %S             ' + #13 +
  '   AND EP.NUPROCESSO LIKE %s         ' + #13 +
  '   AND EP.CDASSUNTOPRINC = %S        ' ;

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICA_INTIMACAO_CRIADA =
  'SELECT COUNT(1) INTIMACAO           ' + #13 +
  '  FROM %SESMDMANDADO EM,            ' + #13 +
  '       %SEFPGPROCESSO EP            ' + #13 +
  ' WHERE EM.CDMODELO = %S             ' + #13 +
  '   AND EM.CDPROCESSO = EP.CDPROCESSO' + #13 +
  '   AND EP.NUPROCESSO LIKE %s        ';

 //28/07/2015 - LUCIANO.FAGUNDES - SALT: 186660/9/2
SQL_RETORNA_PROCESSO_REL_ANALITICO =
  'SELECT MAX(%S) NUPROCESSO                                         ' + #13 +
  '  FROM %SEFPGPROCESSO EPROC                                       ' + #13 +
  ' WHERE EPROC.FLPROCVIRTUAL = ''S''                                ' + #13 +
  '   AND EPROC.CDSITUACAOPROCESSO <> ''C''                          ' + #13 +
  '   AND EXISTS (SELECT 1                                           ' + #13 +
  '                 FROM %SEFPGPROCESSOMV EPM,                       ' + #13 +
  '                      %SEFPGTIPOMVPROCESSO ETP                    ' + #13 +
  '                WHERE EPM.CDPROCESSO = EPROC.CDPROCESSO           ' + #13 +
  '                  AND EPM.DTEXCLUSAO IS NULL                      ' + #13 +
  '                  AND ETP.CDTIPOMVPROCESSO = EPM.CDTIPOMVPROCESSO)' + #13 +
  '   AND EPROC.CDVARA = %S                                          ' + #13 +
  '   AND EPROC.CDFORO = %S                                          ' + #13 +
  '   AND EPROC.NUSEQULTIMAMV = %S                                   ' ;

//28/07/2015 - LUCIANO.FAGUNDES - SALT: 186660/9/2
SQL_RETORNA_PROCESSO_DEMONS_DISTRIB =
  'SELECT MAX(%S) NUPROCESSO                                              ' + #13 +
  '  FROM %SEFPGPROCESSO EPROC                                       ' + #13 +
  ' WHERE EPROC.FLPROCVIRTUAL = ''S''                                ' + #13 +
  '   AND EPROC.CDSITUACAOPROCESSO <> ''C''                          ' + #13 +
  '   AND EXISTS (SELECT 1                                           ' + #13 +
  '                 FROM %SEFPGPROCESSOMV EPM,                       ' + #13 +
  '                      %SEFPGTIPOMVPROCESSO ETP                    ' + #13 +
  '                WHERE EPM.CDPROCESSO = EPROC.CDPROCESSO           ' + #13 +
  '                  AND EPM.DTEXCLUSAO IS NULL                      ' + #13 +
  '                  AND ETP.CDTIPOMVPROCESSO = EPM.CDTIPOMVPROCESSO)' + #13 +
  '   AND EPROC.NUSEQULTIMAMV = ''3''                                ' + #13 +
  '   AND EPROC.CDFORO = %S                                          ' ;

// 04/08/2015  - Carlos.Gaspar - SALT: 1866660/9/4
//  SQL_PROCESSO_PARA_VIRTUALIZAR =
//  'SELECT NUPROCESSO                                                ' + #13 +
//  '  FROM (SELECT SUBSTR(NUPROCESSO,1,13) NUPROCESSO                ' + #13 +
//  '          FROM EFPGPROCESSO EP                                   ' + #13 +
//  '         WHERE EP.CDSITUACAOPROCESSO <> ''C''                    ' + #13 +
//  '           AND EP.FLPROCVIRTUAL = ''N''                          ' + #13 +
//  '           AND EP.CDVARA = 23                                    ' + #13 +
//  '           AND NOT EXISTS (SELECT 1                              ' + #13 +
//  '                             FROM ESAJPENDENCIAPRAZO             ' + #13 +
//  '                            WHERE CDPROCESSO = EP.CDPROCESSO)    ' + #13 +
//  '           AND EXISTS (SELECT 1                                  ' + #13 +
//  '                         FROM EFPGDISTPROCESSO                   ' + #13 +
//  '                        WHERE CDPROCESSO = EP.CDPROCESSO)        ' + #13 +
//  '         ORDER BY DBMS_RANDOM.VALUE())                           ' + #13 +
//  ' WHERE ROWNUM = 1                                                ';

SQL_DATA_AUDIENCIA =
  'SELECT %S             ' + #13 +      //to_char(DTINICIO, ''dd/mm/yyyy'') DTAUDIENCIA
  '  FROM %SEGGPAUDIENCIA' + #13 +
  ' WHERE CDVARA = %S    ' + #13 +
  '   AND CDSALA = %S    ';
 // ' ORDER BY DTINICIO    ';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICA_MANDANDO_REMETIDO_CM =
  'SELECT COUNT(1) ENCONTROU                 ' + #13 +
  '  FROM %SECGOULTIMACARGA UC,              ' + #13 +
  '       %SECGOCARGA C,                     ' + #13 +
  '       %SECGOLOTECARGA LC,                ' + #13 +
  '       %SESAJLOCAL L,                     ' + #13 +
  '       %SESAJTIPOLOCAL TL                 ' + #13 +
  ' WHERE UC.CDOBJETO = C.CDOBJETO           ' + #13 +
  '   AND UC.CDFORO = C.CDFORO               ' + #13 +
  '   AND UC.NULOTE = C.NULOTE               ' + #13 +
  '   AND UC.CDFORO = LC.CDFORO              ' + #13 +
  '   AND UC.NULOTE = LC.NULOTE              ' + #13 +
  '   AND UC.CDFORORESP = L.CDFORO           ' + #13 +
  '   AND UC.CDTIPOLOCALRESP = L.CDTIPOLOCAL ' + #13 +
  '   AND UC.CDLOCALRESP = L.CDLOCAL         ' + #13 +
  '   AND UC.CDTIPOLOCALRESP = TL.CDTIPOLOCAL' + #13 +
  '   AND UC.NULOTE = %s                     ' + #13 +
  '   AND LC.FLREMETIDO = ''S''              ' + #13 +
  '   AND UC.CDTIPOLOCALORIGEM = %S          ' + #13 +
  '   AND UC.CDTIPOLOCALDESTINO = %S         ';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICAR_MANDADO_DISTRIBUIDO_AGENTE =
  'SELECT COUNT(1) DISTRIBUIDO                                    ' + #13 +
  '  FROM %SESMDMANDADO EM,                                       ' + #13 +
  '       %SEFPGPROCESSO EP,                                      ' + #13 +
  '       %SESMDDISTMANDADO EDM,                                  ' + #13 +
  '       %SESMDHISTMANDADO EHM                                   ' + #13 +
  ' WHERE EP.NUPROCESSO LIKE %s                                   ' + #13 +
  '   AND EM.CDPROCESSO = EP.CDPROCESSO                           ' + #13 +
  '   AND EM.CDSITUACAOMAND = %S                                  ' + #13 +
  '   AND EDM.CDMANDADO = EM.CDMANDADO                            ' + #13 +
  '   AND EDM.CDAGENTE = %S                                       ' + #13 +
  '   AND EDM.FLULTDISTRIBUICAO = ''S''                           ' + #13 +
  '   AND EHM.CDMANDADO = EM.CDMANDADO                            ' + #13 +
  '   AND %S = %S                                                 ' + #13 +
  '   AND EHM.CDTIPOOPERACAO = %S                                 ' + #13 +
  '   AND EHM.NUSEQHISTMANDADO = (SELECT MAX(NUSEQHISTMANDADO)    ' + #13 +
  '                                 FROM %SESMDHISTMANDADO        ' + #13 +
  '                                WHERE CDMANDADO = EM.CDMANDADO)';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICA_MANDADO_AGENTE =
'SELECT COUNT(1) AGUARDANDO                                     ' + #13 +
'  FROM %SESMDMANDADO EM,                                       ' + #13 +
'       %SEFPGPROCESSO EP,                                      ' + #13 +
'       %SESMDDISTMANDADO EDM,                                  ' + #13 +
'       %SESMDHISTMANDADO EHM                                   ' + #13 +
' WHERE EP.NUPROCESSO LIKE %s                                   ' + #13 +
'   AND EM.CDPROCESSO = EP.CDPROCESSO                           ' + #13 +
'   AND EM.CDSITUACAOMAND = %S                                  ' + #13 +
'   AND EDM.CDMANDADO = EM.CDMANDADO                            ' + #13 +
'   AND EDM.CDAGENTE = %S                                       ' + #13 +
'   AND EDM.FLULTDISTRIBUICAO = ''S''                           ' + #13 +
'   AND EHM.CDMANDADO = EM.CDMANDADO                            ' + #13 +
'   AND %S = %S                                                 ' + #13 +
'   AND EHM.CDTIPOOPERACAO = %S                                 ' + #13 +
'   AND EHM.NUSEQHISTMANDADO = (SELECT MAX(NUSEQHISTMANDADO)    ' + #13 +
'                                 FROM %SESMDHISTMANDADO        ' + #13 +
'                                WHERE CDMANDADO = EM.CDMANDADO)';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICA_MANDADO_DISTRIBUIDO_CENTRAL =
  'SELECT COUNT(1) EMITIDO                                        ' + #13 +
  '  FROM %SESMDMANDADO EM,                                       ' + #13 +
  '       %SEFPGPROCESSO EP,                                      ' + #13 +
  '       %SESMDDISTMANDADO EDM,                                  ' + #13 +
  '       %SESMDHISTMANDADO EHM                                   ' + #13 +
  ' WHERE EP.NUPROCESSO LIKE %s                                   ' + #13 +
  '   AND EM.CDPROCESSO = EP.CDPROCESSO                           ' + #13 +
  '   AND EM.CDSITUACAOMAND = %S                                  ' + #13 +
  '   AND EDM.CDMANDADO = EM.CDMANDADO                            ' + #13 +
  '   AND EDM.CDAGENTE = %S                                       ' + #13 +
  '   AND EDM.FLULTDISTRIBUICAO = ''S''                           ' + #13 +
  '   AND EHM.CDMANDADO = EM.CDMANDADO                            ' + #13 +
  '   AND %S = %S                                                 ' + #13 +
  '   AND EHM.CDTIPOOPERACAO = %S                                 ' + #13 +
  '   AND EHM.NUSEQHISTMANDADO = (SELECT MAX(NUSEQHISTMANDADO)    ' + #13 +
  '                                 FROM %SESMDHISTMANDADO        ' + #13 +
  '                                WHERE CDMANDADO = EM.CDMANDADO)';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICA_SITUACAO_MANDADO =
  'SELECT COUNT(1) SITUACAO                                       ' + #13 +
  '  FROM %SESMDMANDADO EM,                                       ' + #13 +
  '       %SEFPGPROCESSO EP,                                      ' + #13 +
  '       %SESMDDISTMANDADO EDM,                                  ' + #13 +
  '       %SESMDHISTMANDADO EHM                                   ' + #13 +
  ' WHERE EP.NUPROCESSO LIKE %S                                   ' + #13 +
  '   AND EM.CDPROCESSO = EP.CDPROCESSO                           ' + #13 +
  '   AND EM.CDSITUACAOMAND = %S                                  ' + #13 +
  '   AND EDM.CDMANDADO = EM.CDMANDADO                            ' + #13 +
  '   AND EDM.CDAGENTE = %S                                       ' + #13 +
  '   AND EDM.FLULTDISTRIBUICAO = ''S''                           ' + #13 +
  '   AND EHM.CDMANDADO = EM.CDMANDADO                            ' + #13 +
  '   AND %S = %S                                                 ' + #13 +
  '   AND EHM.CDTIPOOPERACAO = %S                                 ' + #13 +
  '   AND %S = %S                                                 ' + #13 +
  '   AND EHM.NUSEQHISTMANDADO = (SELECT MAX(NUSEQHISTMANDADO)    ' + #13 +
  '                                 FROM %SESMDHISTMANDADO        ' + #13 +
  '                                WHERE CDMANDADO = EM.CDMANDADO)';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICAR_DEVOLUCAO_MANDADO_CARTORIO =
  'SELECT COUNT(1) DEVOLVIDO                 ' + #13 +
  '  FROM %SECGOULTIMACARGA UC,              ' + #13 +
  '       %SECGOCARGA C,                     ' + #13 +
  '       %SECGOLOTECARGA LC,                ' + #13 +
  '       %SESAJLOCAL L,                     ' + #13 +
  '       %SESAJTIPOLOCAL TL                 ' + #13 +
  ' WHERE UC.CDOBJETO = C.CDOBJETO           ' + #13 +
  '   AND UC.CDFORO = C.CDFORO               ' + #13 +
  '   AND UC.NULOTE = C.NULOTE               ' + #13 +
  '   AND UC.CDFORO = LC.CDFORO              ' + #13 +
  '   AND UC.NULOTE = LC.NULOTE              ' + #13 +
  '   AND UC.CDFORORESP = L.CDFORO           ' + #13 +
  '   AND UC.CDTIPOLOCALRESP = L.CDTIPOLOCAL ' + #13 +
  '   AND UC.CDLOCALRESP = L.CDLOCAL         ' + #13 +
  '   AND UC.CDTIPOLOCALRESP = TL.CDTIPOLOCAL' + #13 +
  '   AND UC.NULOTE = %s                     ' + #13 +
  '   AND LC.FLREMETIDO = ''S''              ' + #13 +
  '   AND UC.CDTIPOLOCALORIGEM = %S          ' + #13 +
  '   AND UC.CDTIPOLOCALDESTINO = %S         ';

// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
SQL_VERIFICAR_MANDADO_DEVOLVIDO_CARTORIO =         //OK
  'SELECT COUNT(1) DEVOLVIDO                 ' + #13 +
  '  FROM %SECGOULTIMACARGA UC,              ' + #13 +
  '       %SECGOCARGA C,                     ' + #13 +
  '       %SECGOLOTECARGA LC,                ' + #13 +
  '       %SESAJLOCAL L,                     ' + #13 +
  '       %SESAJTIPOLOCAL TL                 ' + #13 +
  ' WHERE UC.CDOBJETO = C.CDOBJETO           ' + #13 +
  '   AND UC.CDFORO = C.CDFORO               ' + #13 +
  '   AND UC.NULOTE = C.NULOTE               ' + #13 +
  '   AND UC.CDFORO = LC.CDFORO              ' + #13 +
  '   AND UC.NULOTE = LC.NULOTE              ' + #13 +
  '   AND UC.CDFORORESP = L.CDFORO           ' + #13 +
  '   AND UC.CDTIPOLOCALRESP = L.CDTIPOLOCAL ' + #13 +
  '   AND UC.CDLOCALRESP = L.CDLOCAL         ' + #13 +
  '   AND UC.CDTIPOLOCALRESP = TL.CDTIPOLOCAL' + #13 +
  '   AND UC.NULOTE = %s                     ' + #13 +
  '   AND LC.FLREMETIDO = ''S''              ' + #13 +
  '   AND UC.CDTIPOLOCALORIGEM = %S          ' + #13 +
  '   AND UC.CDTIPOLOCALDESTINO = %S         ' + #13 +
  '   AND C.DTRECEBIMENTO IS NOT NULL        ';

//06/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/11/3
SQL_RETORNA_PROCESSO_REL_EXTRATO =                                    //OK
  'SELECT MAX(%S) NUPROCESSO                                         ' + #13 +
  '  FROM %SEFPGPROCESSO EPROC                                       ' + #13 +
  ' WHERE EPROC.CDSITUACAOPROCESSO <> ''C''                          ' + #13 +
  '   AND EXISTS (SELECT 1                                           ' + #13 +
  '                 FROM %SEFPGPROCESSOMV EPM,                       ' + #13 +
  '                      %SEFPGTIPOMVPROCESSO ETP                    ' + #13 +
  '                WHERE EPM.CDPROCESSO = EPROC.CDPROCESSO           ' + #13 +
  '                  AND EPM.DTEXCLUSAO IS NULL                      ' + #13 +
  '                  AND ETP.CDTIPOMVPROCESSO = EPM.CDTIPOMVPROCESSO)' + #13 +
  '   AND EPROC.CDFORO = %S                                          ' + #13 +
  '   AND EPROC.CDVARA = %S                                          ' + #13 +
  '   AND EPROC.NUSEQULTIMAMV = %S                                   ' ;

//07/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/11/3
SQL_RETORNA_REL_CALCULO_IDADE =                                         //OK
  'SELECT %S NUPROCESSO                                                ' + #13 +
  '  FROM %SEFPGPROCESSO EPROC                                         ' + #13 +
  ' WHERE EPROC.CDSITUACAOPROCESSO <> ''C''                            ' + #13 +
  '   AND EPROC.CDVARA = %S                                            ' + #13 +
  '   AND EXISTS (SELECT 1                                             ' + #13 +
  '                 FROM %SEFPGPROCESSOMV EPM,                         ' + #13 +
  '                      %SEFPGTIPOMVPROCESSO ETP                      ' + #13 +
  '                WHERE EPM.CDPROCESSO = EPROC.CDPROCESSO             ' + #13 +
  '                  AND EPM.DTEXCLUSAO IS NULL                        ' + #13 +
  '                  AND ETP.CDTIPOMVPROCESSO = EPM.CDTIPOMVPROCESSO)  ';

//10/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/11/3
SQL_RETORNA_PROCESSO_CONSPROCBASICA =             //OK
  'SELECT %S NUPROCESSO                    ' + #13 +
  '  FROM %SESMDMANDADO EM,                ' + #13 +
  '       %SEFPGPROCESSO EP                ' + #13 +
  ' WHERE EM.CDPROCESSO = EP.CDPROCESSO    ';

//07/08/2015 - ANTONIO.SOUSA - SALT: 186660/11/1
//SQL_RETORNA_PROCESSO_APENSO =
//  'SELECT NUPROCESSO                            ' + #13 +
//  '  FROM (SELECT EP.NUPROCESSO                 ' + #13 +
//  '          FROM EFPGPROCESSO EP,              ' + #13 +
//  '               EFPGdistprocesso EPG          ' + #13 +
//  '         WHERE EP.CDPROCESSO = EPG.CDPROCESSO' + #13 +
//  '           AND EP.CDSITUACAOPROCESSO <> ''C''' + #13 +
//  '           AND EP.CDVARA = 23                ' + #13 +
//  '           AND EP.FLPROCVIRTUAL = ''N''      ' + #13 +
//  '           AND EPG.TPDISTRIBUICAO = ''D''    ' + #13 +
//  '           AND EPG.FLULTDISTRIBUICAO = ''S'' ' + #13 +
//  '      ORDER BY DBMS_RANDOM.VALUE())          ' + #13 +
//  ' WHERE ROWNUM = 1                            ' ;
//
// 12/08/2015 - cesar.almeida - SALT: 186660/11/2
//SQL_PEGAR_NOME_CPF =
//  'SELECT NMPESSOA NOME, CPF                           ' + #13 +
//  '  FROM (SELECT N.NMPESSOA,                          ' + #13 +
//  '               LPAD(EPC.NUDOCUMENTO, 11, ''0'') CPF ' + #13 +
//  '          FROM EFPGPARTE P,                     ' + #13 +
//  '               ESAJTIPOPARTE TP,                    ' + #13 +
//  '               ESAJPESSOA PE,                       ' + #13 +
//  '               EFPGPROCESSO PR,                     ' + #13 +
//  '               ESAJNOME N,                          ' + #13 +
//  '               EFPGPARTEDADOSCOMP PDC,              ' + #13 +
//  '               ESAJCLASSE EC,                       ' + #13 +
//  '               ESAJPESSOADOC EPC                    ' + #13 +
//  '         WHERE P.CDPESSOA = N.CDPESSOA              ' + #13 +
//  '           AND N.TPNOME = ''N''                     ' + #13 +
//  '           AND EPC.CDPESSOA = PE.CDPESSOA           ' + #13 +
//  '           AND EPC.SGTIPODOCUMENTO = ''CPF''        ' + #13 +
//  '           AND PDC.CDPROCESSO(+) = P.CDPROCESSO     ' + #13 +
//  '           AND PDC.NUSEQPARTE(+) = P.NUSEQPARTE     ' + #13 +
//  '           AND P.CDPROCESSO = PR.CDPROCESSO         ' + #13 +
//  '           AND P.CDPESSOA = PE.CDPESSOA             ' + #13 +
//  '           AND P.CDTIPOPARTE = TP.CDTIPOPARTE       ' + #13 +
//  '           AND TP.CDTIPOPARTE IN (2,56)             ' + #13 +
//  '           AND PR.CDPROCESSO = P.CDPROCESSO         ' + #13 +
//  '           AND PR.FLTIPOCLASSE = 0                  ' + #13 +
//  '           AND PR.CDASSUNTOPRINC = 3370             ' + #13 +
//  '           AND EC.FLTIPOCLASSE = PR.FLTIPOCLASSE    ' + #13 +
//  '           AND EC.CDCLASSE = 995                    ' + #13 +
//  '      ORDER BY DBMS_RANDOM.VALUE())                 ' + #13 +
//  ' WHERE ROWNUM = 1                                   ';

//11/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/11/3
SQL_RETORNA_PROCESSO_REG_SENTENCA =                                           //OK
'SELECT %S NUPROCESSO                                                     ' + #13 +
'  FROM %SEEDTDOCEMITIDO E                                                ' + #13 +
'  LEFT JOIN %SEFPGREGSENTENCA R ON (R.CDDOCUMENTO = E.CDDOCUMENTO)       ' + #13 +
'  LEFT JOIN %SEEDTMODELO M ON (M.CDMODELO = E.CDMODELO)                  ' + #13 +
'  LEFT JOIN %SEGGPVINCPROCMVPG VPMP ON (VPMP.CDDOCUMENTO = E.CDDOCUMENTO)' + #13 +
'  LEFT JOIN %SEFPGPROCESSOMV PMV ON (PMV.CDPROCESSO = VPMP.CDPROCESSO    ' + #13 +
'            AND PMV.NUSEQPROCESSOMV = VPMP.NUSEQPROCESSOMV),             ' + #13 +
'       %SEEDTCATEGORIA C,                                                ' + #13 +
'       %SEFPGPROCESSO P                                                  ' + #13 +
' WHERE P.CDPROCESSO = E.CDPROCESSO                                       ' + #13 +
'   AND P.CDSITUACAOPROCESSO <> ''C''                                     ' + #13 +
'   AND C.CDCATEGORIA = E.CDCATEGORIA                                     ' + #13 +
'   AND E.CDCATEGORIA IN (%S)                                             ' + #13 +
'   AND E.FLMODOFINALIZACAO <> ''N''                                      ' + #13 +
'   AND EXISTS (SELECT 1                                                  ' + #13 +
'                FROM %SEGGPVINCPROCMVPG DMV                              ' + #13 +
'               WHERE DMV.CDDOCUMENTO = E.CDDOCUMENTO)                    ' + #13 +
'   AND NOT EXISTS (SELECT 1                                              ' + #13 +
'                    FROM %SEFPGREGSENTENCA RS                            ' + #13 +
'                   WHERE RS.CDDOCUMENTO = E.CDDOCUMENTO                  ' + #13 +
'                     AND RS.FLCANCELADO = ''N'')                         ';

//11/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/11/3
SQL_VERFICA_PROCESSO_REG_SENTENCA =         //OK
  'SELECT COUNT(1) VERIFICA              ' + #13 +
  '  FROM %SEFPGPROCESSOMV EPM,          ' + #13 +
  '       %SEFPGPROCESSO EP              ' + #13 +
  ' WHERE EPM.CDPROCESSO = EP.CDPROCESSO ' + #13 +
  '   AND %S                             ' + #13 +
  '   AND EPM.CDTIPOMVPROCESSO = %S      ' + #13 +
  '   AND EP.NUPROCESSO LIKE %S          ' ;

//19/08/2015 - ANTONIO.SOUSA - SALT: 186660/11/1
SQL_VERIFICA_PROCESSO_CANCELADO =            //OK
  'SELECT COUNT(1) TOTAL             ' + #13 +
  '  FROM %SEFPGPROCESSO             ' + #13 +
  ' WHERE NUPROCESSO LIKE %S         ' + #13 +
  '   AND CDSITUACAOPROCESSO <> ''C''';


//26/08/2015 - CESAR.ALMEIDA - SALT: 186660/13/2
SQL_RETORNA_ENDERECO_CPF =                //OK
  'SELECT COUNT(1) TOTAL           ' + #13 +
  '  FROM %SESAJPESSOAENDERECO PE, ' + #13 +
  '       %SESAJPESSOADOC PD       ' + #13 +
  ' WHERE PE.CDPESSOA = PD.CDPESSOA' + #13 +
  '   AND %S = %S                  ';


{ Data de Criação:  24/08/2015  Responsável: Shirleano.Junior  Salt: 186660/13/4}
SQL_VERIFICAR_LOCAL_PROCESSO_FISICO =                                    //OK
  'SELECT LFS.CDlOCALFISICO                                        ' + #13 +
  '  FROM %SEFPGLOCALPROCESSO LPR,                                 ' + #13 +
  '       %SEFPGLOCALFISICO LFS,                                   ' + #13 +
  '       %SEFPGPROCESSOMV PMV                                     ' + #13 +
  ' WHERE PMV.CDPROCESSO = LPR.CDPROCESSO                          ' + #13 +
  '   AND LPR.CDLOCALFISICO = LFS.CDLOCALFISICO                    ' + #13 +
  '   AND LPR.CDPROCESSO in (%S)                                   ' + #13 +
  '   AND PMV.NUSEQLOCALPROC = (SELECT MAX(NUSEQLOCALPROC)         ' + #13 +
  '                               FROM %SEFPGPROCESSOMV            ' + #13 +
  '                              WHERE CDPROCESSO = LPR.CDPROCESSO)';

SQL_RETORNA_NUPROCESSO_SEM_PENDENCIA =                               //OK
  'SELECT NUPROCESSO                                       ' + #13 +
  '  FROM %SEFPGPROCESSO PRC                               ' + #13 +
  ' WHERE NOT EXISTS (SELECT 1                             ' + #13 +
  '                   FROM %SESAJPENDENCIAPRAZO EPD        ' + #13 +
  '                  WHERE PRC.CDPROCESSO = EPD.CDPROCESSO)' + #13 +
  '   AND PRC.CDSITUACAOPROCESSO <> ''C''                  ' + #13 +
  '   AND PRC.FLPROCVIRTUAL = ''N''                        ';
//--

//25/08/2015 - LUCIANO.FAGUNDES - SALT: 1866660/13/3
SELECT_VERIFICA_ALTERACAO_PAUTA_AUDIENCIA_BLOCO = //OK
  ' SELECT %S DATAINICIO,                 ' + #13 +
  '        %S DATAFIM,                    ' + #13 +
  '        %S HORAINICIO,                 ' + #13 +
  '        %S HORAFIM                     ' + #13 +
  '   FROM %SEGGPAUDIENCIA AUD,           ' + #13 +
  '        %SEFPGPROCESSO PRO             ' + #13 +
  '  WHERE AUD.CDSALA = %S                ' + #13 +
  '    AND AUD.CDVARA = %S                ' + #13 +
  '    AND AUD.CDTIPOAUDIENCIA = %S       ' + #13 +
  '    AND PRO.NUPROCESSO LIKE %S         ' + #13 +
  '    AND AUD.CDPROCESSO = PRO.CDPROCESSO' ;

//25/08/2015 - LUCIANO.FAGUNDES - SALT: 1866660/13/3
SQL_VERIFICA_AUDIENCIA_CANCELADA =                //OK
  '  SELECT COUNT(1) VERIFICADO       ' + #13 +
  '    FROM %SEGGPAUDIENCIA           ' + #13 +
  '   WHERE CDAUDIENCIA = %S          ' + #13 +
  '     AND CDSITUACAOAUDI = %S       ' ;

//19/08/2015 - ANTONIO.SOUSA - SALT: 186660/13/1
SQL_RETORNA_COPIA_FILA =                                //OK
  'SELECT COUNT(1) TOTAL                               ' + #13 +
  '  FROM %SEFPGPROCESSO EP,                           ' + #13 +
  '       %SEWFLHISTOBJETO EHO                         ' + #13 +
  ' WHERE EHO.CDOBJETO = EP.CDOBJETO                   ' + #13 +
  '   AND EHO.CDFILA IN (%S)                           ' + #13 +
  '   AND EXISTS (SELECT 1                             ' + #13 +
  '                 FROM %SEFPGPROCESSO                ' + #13 +
  '                WHERE NUPROCESSO LIKE %S            ' + #13 +
  '                  AND CDOBJETO = EHO.CDOBJETO)      ' + #13 +
  '   AND (NUSEQHIST = (SELECT MAX(NUSEQHIST)          ' + #13 +
  '                       FROM %SEWFLHISTOBJETO        ' + #13 +
  '                      WHERE CDOBJETO = EHO.CDOBJETO)' + #13 +
  '   OR NUSEQHIST = (SELECT MAX(NUSEQHIST)-1          ' + #13 +
  '                     FROM %SEWFLHISTOBJETO          ' + #13 +
  '                    WHERE CDOBJETO = EHO.CDOBJETO)) ' ;

// 02/09/2015 - Rafael.Buss - SALT: 186660/13
SQL_AR_REMETIDO_NAO_RECEBIDO =                                          //OK
  'SELECT COUNT(1) EXISTE                                           ' + #13 +
  '  FROM %SECGOLOTECARGA ELC,                                      ' + #13 +
  '       %SECGOCARGA EC                                            ' + #13 +
  '  LEFT JOIN %SECGOULTIMACARGA EUC ON (EC.CDOBJETO = EUC.CDOBJETO ' + #13 +
  '        AND EC.CDFORO = EUC.CDFORO AND EC.NULOTE = EUC.NULOTE)   ' + #13 +
  ' WHERE ELC.CDFORO = EC.CDFORO                                    ' + #13 +
  '   AND ELC.NULOTE = EC.NULOTE                                    ' + #13 +
  '   AND EC.DTRECEBIMENTO IS NULL                                  ' + #13 +
  '   AND ELC.NULOTE = %S                                           ' + #13 +
  '   AND EC.CDOBJETO IN (SELECT EA.CDOBJETO                        ' + #13 +
  '                         FROM %SESARAR EA                        ' + #13 +
  '                        WHERE EA.CDARTJ = %S)                    ';

//08/09/2015 - Rafael.Buss - SALT: 186660/13
SQL_GERA_GUIA_POSTAGEM_AR =                                            //OK
  'SELECT COUNT(1) CRIADO                                          ' + #13 +
  '  FROM %SESARGUIAPOSTAGEM GP,                                   ' + #13 +
  '       %SESARAGENCIAECT A,                                      ' + #13 +
  '       %SESAJLOCAL L                                            ' + #13 +
  ' WHERE GP.CDFORO = A.CDFORO                                     ' + #13 +
  '   AND GP.CDAGENCIAECT = A.CDAGENCIAECT                         ' + #13 +
  '   AND GP.CDFORO = L.CDFORO                                     ' + #13 +
  '   AND GP.CDTIPOLOCAL = L.CDTIPOLOCAL                           ' + #13 +
  '   AND GP.CDLOCAL = L.CDLOCAL                                   ' + #13 +
  '   AND GP.FLSITUACAOGUIA <> ''F''                               ' + #13 +
  '   AND GP.CDFORO = %S                                           ' + #13 +
  '   AND EXISTS (SELECT 1                                         ' + #13 +
  '                 FROM %SESARITENSGUIA EAIG,                     ' + #13 +
  '                      %SESARAR EA                               ' + #13 +
  '                WHERE EAIG.CDAR = EA.CDAR                       ' + #13 +
  '                  AND EA.CDARTJ = %S                            ' + #13 +
  '                  AND EA.CDTIPOESTADOAR = %S                    ' + #13 +
  '                  AND EAIG.NUGUIAPOSTAGEM = GP.NUGUIAPOSTAGEM)  ';

//02/09/2015 - CESAR.ALEIDA - SALT: 1866660/13/2
SQL_ALTERA_TIPO_ESTADO_AR =                 //OK  - Verificar com César
  'UPDATE %SESARAR               ' + #13 +
  '   SET CDTIPOESTADOAR = ''2'' ' + #13 +
  ' WHERE CDARTJ = %S            ';

SQL_VERIFICA_AR_GERADA =
  'SELECT COUNT(1) TOTAL ' + #13 +
  '  FROM %SESARAR       ' + #13 +
  ' WHERE CDARTJ = %S    ';

SQL_VERIFICA_SITUACAO_AR =        //OK
  'SELECT CDTIPOESTADOAR SIT ' + #13 +
  '  FROM %SESARAR           ' + #13 +
  ' WHERE CDARTJ = %S        ';

//SQL TESTE TestarRemeterARCartorio_1_3_11
SQL_VERIFICA_AR_REMETIDO =                              //OK
  'SELECT COUNT(1) TOTAL                         ' + #13 +
  '  FROM %SESARAR EA,                           ' + #13 +
  '       %SESARTIPOESTADOAR EATE                ' + #13 +
  ' WHERE EA.CDARTJ = %S                         ' + #13 +
  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR' + #13 +
  '   AND EATE.CDTIPOESTADOAR = %S               ' ;

//SQL TESTE TestarReceberARExpedicao_1_3_12
SQL_RECEBIDO_NO_CARTORIO =                                       //OK
'SELECT COUNT(1) TOTAL                                           ' + #13 +
'  FROM %SECGOCARGA EC                                           ' + #13 +
'  LEFT JOIN %SECGOULTIMACARGA EUC                               ' + #13 +
'        ON  EC.CDOBJETO = EUC.CDOBJETO                          ' + #13 +
'        AND EC.CDFORO = EUC.CDFORO                              ' + #13 +
'        AND EC.NULOTE = EUC.NULOTE                              ' + #13 +
'  LEFT JOIN %SECGOLOTECARGA ELC                                 ' + #13 +
'        ON  ELC.CDFORO = EC.CDFORO                              ' + #13 +
'        AND ELC.NULOTE = EC.NULOTE                              ' + #13 +
' WHERE %S                                                       ' + #13 +
'   AND ELC.NULOTE = %S                                          ' + #13 +
'   AND EC.CDOBJETO IN (SELECT EA.CDOBJETO                       ' + #13 +
'                         FROM ESARAR EA                         ' + #13 +
'                        WHERE EA.CDARTJ = %S)                   ';

//SQL TESTE TestarReceberARExpedicao_1_3_12
//SQL_VERIFICAR_SITUACAO_AR =
//  'SELECT COUNT(1) TOTAL                         ' + #13 +
//  '  FROM ESARAR EA,                             ' + #13 +
//  '       ESARTIPOESTADOAR EATE                  ' + #13 +
//  ' WHERE EA.CDARTJ = %S                         ' + #13 +
//  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR' + #13 +
//  '   AND EATE.CDTIPOESTADOAR = 12               ' ;

//SQL TESTE TestarAlterarAR_1_3_13
SQL_VERIFICAR_NUMERO_DOCUMENTO_ALTERADO =            //OK
  'SELECT COUNT(1) TOTAL                         ' + #13 +
  '  FROM %SESARAR EA,                           ' + #13 +
  '       %SESARTIPOESTADOAR EATE                ' + #13 +
  ' WHERE EA.CDARTJ = %S                         ' + #13 +
  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR' + #13 +
  '   AND EATE.CDTIPOESTADOAR = %S               ' + #13 +
  '   AND EA.NUDOCRECEBEDOR = %S                 ' ;

// SQL TESTE TestarJuntadaAR_1_3_14
SQL_VERIFICAR_AR_JUNTADA_PROCESSO =                   //OK
  'SELECT COUNT(1) TOTAL                         ' + #13 +
  '  FROM %SESARAR EA,                           ' + #13 +
  '       %SESARTIPOESTADOAR EATE                ' + #13 +
  ' WHERE EA.CDARTJ = %S                         ' + #13 +
  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR' + #13 +
  '   AND EATE.CDTIPOESTADOAR = %S               ' ;

//SQL TESTE TestarCancelarJuntadaAR_1_3_15 E TestarConsultarJuntadaPendente_1_3_16
SQL_VERIFICA_AR_AGUARDANDO_JUNTADA =                       //OK
  'SELECT COUNT(1) AGUARDANDO                    ' + #13 +
  '  FROM %SESARAR EA,                           ' + #13 +
  '       %SESARTIPOESTADOAR EATE                ' + #13 +
  ' WHERE EA.CDARTJ = %S                         ' + #13 +
  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR' + #13 +             //luciano  - Aguardando Rafael resolver problema da linha da planlha que sumiu
  '   AND EATE.CDTIPOESTADOAR = %S               ' ;

//30/11/2015 - Shirleano.Junior - SALT: 186660/23/4
SQL_VERIFICACAO_TESTE_CONSULTA_AUTOS =                                                         //OK
  'SELECT EP.NUPROCESSO,                                                                ' + #13 +
  '       D.FLPROTOCOLADO PROTOCOLADO,                                                  ' + #13 +
  '       D.FLASSINADO ASSINADO,                                                        ' + #13 +
  '       CASE WHEN D.DTEXCLUSAO IS NULL                                                ' + #13 +
  '            THEN ''N''                                                               ' + #13 +
  '            ELSE ''S'' END EXCLUIDO,                                                 ' + #13 +
  '       D.TPCOPIADO COPIADO,                                                          ' + #13 +
  '       PD.FLJUNTADO LIBERADO_AUTOS,                                                  ' + #13 +
  '       PD.CDDOCUMENTO,                                                               ' + #13 +
  '       PD.NUPAGINAINICIAL AS PAGINI,                                                 ' + #13 +
  '       (CASE D.CDDOCUMENTOEDT WHEN NULL                                              ' + #13 +
  '        THEN (PD.NUPAGINAINICIAL + (SELECT COUNT(EPD.CDDOCUMENTO)                    ' + #13 +
  '                                      FROM %SEDIGPAGINADOC EPD                       ' + #13 +
  '                                     WHERE EPD.CDDOCUMENTO = D.CDDOCUMENTO))         ' + #13 +
  '         ELSE (PD.NUPAGINAINICIAL + D.QTPAGINAS) END) PROXPAGINI,                    ' + #13 +
  '       D.QTPAGINAS,                                                                  ' + #13 +
  '       (SELECT COUNT(EPD.CDDOCUMENTO)                                                ' + #13 +
  '          FROM %SEDIGPAGINADOC EPD                                                   ' + #13 +
  '         WHERE EPD.CDDOCUMENTO = D.CDDOCUMENTO) AS PAGINADOC,                        ' + #13 +
  '       PD.NUORDEM,                                                                   ' + #13 +
  '       (SELECT T.DETIPODOCDIGITAL                                                    ' + #13 +
  '          FROM %SEDIGDOCUMENTO D,                                                    ' + #13 +
  '               %SEDIGTIPODOCDIGITAL T                                                ' + #13 +
  '         WHERE D.CDDOCUMENTO = PD.CDDOCUMENTO                                        ' + #13 +
  '           AND D.CDTIPODOCDIGITAL = T.CDTIPODOCDIGITAL) AS TIPO,                     ' + #13 +
  '       (CASE D.CDFORMATODOC                                                          ' + #13 +
  '        WHEN 1 THEN ''IMAGEM''                                                       ' + #13 +
  '        WHEN 2 THEN ''EDT''                                                          ' + #13 +
  '        WHEN 3 THEN ''RTF''                                                          ' + #13 +
  '        WHEN 6 THEN ''PDF''                                                          ' + #13 +
  '        WHEN 7 THEN ''RTFCUSTAS''                                                    ' + #13 +
  '        WHEN 8 THEN ''IMAGEMCUSTAS''                                                 ' + #13 +
  '        WHEN 9 THEN ''PDF_ESAJ'' END) FORMDOC,                                       ' + #13 +
  '        CASE WHEN %S > 0                                                             ' + #13 +
  '        THEN ''ENCONTROU''                                                           ' + #13 +
  '        ELSE ''NÃO ENCONTROU'' END TITULO_ANOTACAO,                                  ' + #13 +
  '        EAP.NUSEQPAGINA PAGINA_ANOTACAO                                              ' + #13 +
  '  FROM %SEDIGPROCESSODOC PD                                                          ' + #13 +
  '  LEFT JOIN %SEDIGANOTACAOPAGINA EAP ON (EAP.CDDOCUMENTO = PD.CDDOCUMENTO),          ' + #13 +
  '       %SEDIGDOCUMENTO D,                                                            ' + #13 +
  '       %SEFPGPROCESSO EP                                                             ' + #13 +
  ' WHERE EP.NUPROCESSO = %S                                                            ' + #13 +
  '   AND PD.CDDOCUMENTO = D.CDDOCUMENTO                                                ' + #13 +
  '   AND EP.CDPROCESSO = PD.CDPROCESSO                                                 ' + #13 +
  ' ORDER BY 7 ASC                                                                      ';

//{ Data de Criação:  02/09/2015  Responsável: Shirleano.Junior  Salt: 186660/13/4}
//SQL_VERIFICAR_AR_REMETIDO =
//  'SELECT COUNT(1) TOTAL                            ' + #13 +
//  '  FROM ESARAR EA,                                ' + #13 +
//  '       ESARTIPOESTADOAR EATE                     ' + #13 +
//  ' WHERE EA.CDARTJ = %S                            ' + #13 +
//  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR   ' + #13 +
//  '   AND EATE.CDTIPOESTADOAR = 4                   ' ;


{ Data de Criação:  03/09/2015  Responsável: Shirleano.Junior  Salt: 186660/13/4}
SQL_VERIFICA_DEVOLUCAO_AR =                                   //OK
  'SELECT COUNT(1) TOTAL                          ' + #13 +
  '  FROM %SESARAR EA,                            ' + #13 +
  '       %SESARTIPOESTADOAR EATE                 ' + #13 +
  ' WHERE EA.CDARTJ = %S                          ' + #13 +
  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR ' + #13 +
  '   AND EATE.CDTIPOESTADOAR = %S                ';

//03/09/2015 - Rafael.Buss - SALT: 186660/13
//SQL_VERIFICA_GUIA_POSTAGEM =
//  'SELECT COUNT(1) CRIOU                                                           ' + #13 +
//  '  FROM ESARGUIAPOSTAGEM GP,                                                     ' + #13 +
//  '       ESARAGENCIAECT A,                                                        ' + #13 +
//  '       ESAJLOCAL L                                                              ' + #13 +
//  ' WHERE GP.CDFORO = A.CDFORO                                                     ' + #13 +
//  '   AND GP.CDAGENCIAECT = A.CDAGENCIAECT                                         ' + #13 +
//  '   AND GP.CDFORO = L.CDFORO                                                     ' + #13 +
//  '   AND GP.CDTIPOLOCAL = L.CDTIPOLOCAL                                           ' + #13 +
//  '   AND GP.CDLOCAL = L.CDLOCAL                                                   ' + #13 +
//  '   AND GP.FLSITUACAOGUIA <> ''F''                                               ' + #13 +
//  '   AND GP.CDFORO = 23                                                           ' + #13 +
//  '   AND EXISTS (SELECT 1                                                         ' + #13 +
//  '                 FROM ESARITENSGUIA EAIG,                                       ' + #13 +
//  '                      ESARAR EA                                                 ' + #13 +
//  '                WHERE EAIG.CDAR = EA.CDAR                                       ' + #13 +
//  '                  AND EA.CDARTJ = %S                                            ' + #13 +
//  '                  AND EA.CDTIPOESTADOAR = 7                                     ' + #13 +
//  '                  AND EAIG.NUGUIAPOSTAGEM = GP.NUGUIAPOSTAGEM)                  ';

//09/09/2015 - shirleano.junior - SALT: 186660/15/4
//SQL_VERIFICAR_AR_CANCELADA =
//  'SELECT COUNT(1) CANCELADA                        ' +#13 +
//  '  FROM ESARAR EA,                                ' +#13 +
//  '       ESARTIPOESTADOAR EATE                     ' +#13 +
//  ' WHERE EA.CDARTJ = %S                            ' +#13 +
//  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR   ' +#13 +
//  '   AND EATE.CDTIPOESTADOAR = 18                  ';

//25/08/2015 - LUCIANO.FAGUNDES - SALT: 1866660/13/3
SQL_VERIFICA_OBSERVACAO_PROCESSO_FLUXO_TRABALHO =                               //OK
  'SELECT PRO.DEOBSERVACAO OBSERVACAO, HIS.DEOBSERVACAO OBSERVACAO1   ' + #13 +
  '  FROM %SEFPGPROCESSO PRO, EWFLHISTOBJETO HIS                      ' + #13 +
  ' WHERE NUPROCESSO LIKE %S                                          ' + #13 +
  '   AND PRO.CDOBJETO = HIS.CDOBJETO                                 ' + #13 +
  '   AND HIS.NUSEQHIST = (SELECT MAX(NUSEQHIST)                      ' + #13 +
  '                          FROM EWFLHISTOBJETO                      ' + #13 +
  '                         WHERE CDOBJETO = HIS.CDOBJETO)            ' ;

//04/09/2015 - LEANDRO.HUMBERT - SALT: 1866660/13/3
SQL_VERIFICA_OBSERVACAO_DOCUMENTO =          //OK
  'select OBS.DEOBSERVACAO        ' + #13 +
  '  from %SEEDTOBSERVACAODOC OBS ' + #13 +
  ' where OBS.CDDOCUMENTO = %S    ' ;

//14/09/2015 - ANTONIO.SOUSA - SALT: 186660/15/1
SQL_VERIFICAR_PARTE_INDICIADO =                     //OK
  'SELECT COUNT(1) PESSOACADASTRADA       ' + #13 +
  '  FROM %SESAJNOME EN,                  ' + #13 +
  '       %SEFPGPROCESSO EP,              ' + #13 +
  '       %SEFPGPARTE EPT                 ' + #13 +
  ' WHERE EPT.CDPROCESSO = EP.CDPROCESSO  ' + #13 +
  '   AND EN.CDPESSOA = EPT.CDPESSOA      ' + #13 +
  '   AND EN.NMPESSOA LIKE %S             ' + #13 +
  '   AND EP.NUPROCESSO LIKE %S           ' ;

//14/09/2015 - ANTONIO.SOUSA - SALT: 186660/15/1
SQL_VERIFICAR_HISTORICO_PARTE =                   //OK
  'SELECT COUNT(1) TOTAL                ' + #13 +
  '  FROM %SEAIPHISTORICOPARTE ET,      ' + #13 +
  '       %SEFPGPARTE EP,               ' + #13 +
  '       %SEFPGPROCESSO EPR            ' + #13 +
  ' WHERE ET.CDPROCESSO = EP.CDPROCESSO ' + #13 +
  '   AND ET.CDPROCESSO = EPR.CDPROCESSO' + #13 +
  '   AND EPR.NUPROCESSO LIKE %S        ' + #13 +
  '   AND EP.FLREUPRESO = ''S''         ';

//16/09/2015 - ANTONIO.SOUSA - SALT: 186660/15/1
SQL_VERIFICAR_PARCELAS_MULTA =                                  //OK
  'SElECT COUNT(1) TOTAL                             ' + #13 +
  '  FROM %SEAIPHISTMULTA EM                         ' + #13 +
  ' WHERE EM.CDPROCESSO = (SELECT CDPROCESSO         ' + #13 +
  '                          FROM EFPGPROCESSO       ' + #13 +
  '                         WHERE NUPROCESSO like %S)' ;

//10/09/2015 - LEANDRO.HUMBERT - SALT: 186660/15/7
SQL_RETORNA_DOC_EMITIDO_2 =                    //OK
  'SElECT COUNT(1) TOTAL        ' + #13 +
  '  FROM %SEEDTDOCEMITIDO EDOC ' + #13 +
  ' WHERE CDDOCUMENTO = %S      ';

SQL_RETORNA_DOC_EMITIDO_GGP =                                //OK
  'SELECT cdDocumento, nuPrazoEdital, nuPrazoAto ' + #13 +
  '  FROM %SEGGPDOCEMITIDO EDOC                  ' + #13 +
  ' WHERE CDDOCUMENTO = %S                       ' ;

//14/09/2015 - Rafael.Buss - SALT: 186660/13/8
SQL_LIBEROU_DOCUMENTO_AUTOS =                         //OK
' SELECT COUNT(1) SALVOU                        ' + #13 +
'   FROM %SEEDTDOCEMITIDO DOE,                  ' + #13 +
'        %SEDIGDOCUMENTO DOC                    ' + #13 +
'  WHERE DOE.CDDOCUMENTO = DOC.CDDOCUMENTOEDT   ' + #13 +
'    AND DOC.CDDOCUMENTOEDT = %S                ';

//14/09/2015 - LEANDRO.HUMBERT - SALT: 186660/15/7
SQL_RETORNA_VARA_PROCESSO =           //OK
'SELECT P.CDVARA           ' + #13 +
'  FROM %SEFPGPROCESSO P   ' + #13 +
' WHERE P.NUPROCESSO =  %S ';

//21/09/2015 - ANTONIO.SOUSA - SALT: 186660/19/3
SQL_VERIFICAR_CERTIDAO_EMITIDA =                             //OK
  'SELECT COUNT(1) TOTAL                       ' + #13 +
  '  FROM %SESGCPEDIDO@DBLINK_INDTINT EPL,     ' + #13 +
  '       %SESGCSOLICITANTE@DBLINK_INDTINT ESAL' + #13 +
  ' WHERE EPL.CDSITUACAO = %S                  ' + #13 +
  '   %S                                       ' + #13 +
  '  AND ESAL.CDPEDIDO = EPL.CDPEDIDO          ' + #13 +
  '  AND EPL.NUPEDIDO = %S                     ' ;


//22/09/2015 - ANTONIO.SOUSA - SALT: 186660/19/3
SQL_RETORNAR_JUNTADA_PROCESSO_DEPENDENTE =                               //OK
  'SELECT COUNT(1) TOTAL                                     ' + #13 +
  '   FROM %SEFPGPROCESSOMV EPM,                             ' + #13 +
  '        %SEFPGPROCESSO EP                                 ' + #13 +
  '  WHERE EPM.CDPROCESSO = EP.CDPROCESSO                    ' + #13 +
  '    AND EP.NUPROCESSO LIKE %S                             ' + #13 +
  '    AND EPM.NUSEQPROCESSOMV = (SELECT MAX(NUSEQPROCESSOMV)' + #13 +
  '               FROM %SEFPGPROCESSOMV                      ' + #13 +
  '              WHERE CDPROCESSO = EP.CDPROCESSO)           ' + #13 +
  '    AND EPM.CDTIPOMVPROCESSO in (%S)    ' ;

//22/09/2015 - ANTONIO.SOUSA - SALT: 186660/19/3
SQL_VERICAR_COPIA_PARTES =                                                //OK
  'SELECT %S TOTAL                                                  ' + #13 +
  '  FROM (SELECT EP.CDPARTEATIVAPRINC PTATIVACONTESTACAO,          ' + #13 +
  '               EP.CDPARTEPASSIVPRINC PTPASSIVACONTESTACAO,       ' + #13 +
  '               0 PTATIVA,                                        ' + #13 +
  '               0 PTPASSIVA                                       ' + #13 +
  '          FROM %SEFPGPROCESSO EP,                                ' + #13 +
  '               %SESAJCLASSE EC                                   ' + #13 +
  '         WHERE EP.NUPROCESSO LIKE %S                             ' + #13 +
  '           AND EC.CDCLASSE = EP.CDCLASSEPROCESSO                 ' + #13 +
  '           AND UPPER(EC.DECLASSE) = UPPER(%S)                    ' + #13 +
  '     UNION ALL                                                   ' + #13 +
  '        SELECT 0 PTATIVACONTESTACAO,                             ' + #13 +
  '               0 PTPASSIVACONTESTACAO,                           ' + #13 +
  '               EP.CDPARTEATIVAPRINC PTATIVA,                     ' + #13 +
  '               EP.CDPARTEPASSIVPRINC PTPASSIVA                   ' + #13 +
  '          FROM %SEFPGPROCESSO EP,                                ' + #13 +
  '               %SESAJCLASSE EC                                   ' + #13 +
  '         WHERE EP.NUPROCESSO LIKE %S                             ' + #13 +
  '           AND EC.CDCLASSE = EP.CDCLASSEPROCESSO                 ' + #13 +
  '           AND UPPER(EC.DECLASSE) <> UPPER(%S))                  ' ;

//22/09/2015 - ANTONIO.SOUSA - SALT: 186660/19/3
SQL_PETICAO_SALVA =                                           //OK
  'SELECT COUNT(1) TOTAL                      ' + #13 +
  '  FROM %SEFPGPROCESSO EP,                  ' + #13 +
  '       %SESAJCLASSE EC                     ' + #13 +
  ' WHERE EP.NUPROCESSO LIKE %S               ' + #13 +
  '   AND EC.CDCLASSE = EP.CDCLASSEPROCESSO   ' + #13 +
  '   AND UPPER(EC.DECLASSE) = UPPER(%S)      ' ;
//-----------
//24/09/2015 - ANTONIO.SOUSA - SALT: 186660/19/3
SQL_VERIFICA_CANCELAMENTO_JUNTADA =                                 //OK
  'SELECT COUNT(1) TOTAL                                   ' + #13 +
  '  FROM %SEFPGPROCESSOAPENSO EPA                         ' + #13 +
  ' WHERE CDPROCESSOAPENSO = %S                            ' + #13 +
  '   AND NUSEQAPENSO = (SELECT MAX(NUSEQAPENSO)           ' + #13 +
  '                       FROM %SEFPGPROCESSOAPENSO        ' + #13 +
  '                      WHERE CDPROCESSO = EPA.CDPROCESSO)' ;

//25/09/2015 - ANTONIO.SOUSA - SALT: 186660/19/3
SQL_RETORNA_SENHA_GERADA =                                                //OK
  'SELECT COUNT(1) TOTAL                                       ' + #13 +
  ' FROM %SEFPGSENHAPROCESSO ES                                ' + #13 +
  'WHERE ES.NUSEQSENHA = (SELECT MAX(EPS.NUSEQSENHA)           ' + #13 +
  '                      FROM %SEFPGSENHAPROCESSO EPS,         ' + #13 +
  '                           %SEFPGPROCESSO EP                ' + #13 +
  '                     WHERE EPS.CDPROCESSO = EP.CDPROCESSO   ' + #13 +
  '                       AND EP.CDPROCESSO = ES.CDPROCESSO)   ' + #13 +
  '  AND ES.CDPROCESSO = %S                                    ' + #13 +
  '  AND UPPER(ES.NMOUTROINTERESSADO) = UPPER(%S)              ' ;

//25/09/2015 - ANTONIO.SOUSA - SALT: 186660/19/3
SQL_VERIFICA_OFICIO_IMPRESSO =                         //OK
  'SELECT COUNT(1) TOTAL                   ' + #13 +
  '  FROM %SEFPGSENHAPROCAUDIT             ' + #13 +
  ' WHERE  UPPER(DEOPERACAO) LIKE UPPER(%S)' ;

SQL_VERIFICA_EMAIL_RECEBIDO =                                //OK
  'SELECT COUNT(1) TOTAL                       ' + #13 +
  '  FROM %SEFPGSENHAPROCESSO                  ' + #13 +
  ' WHERE DEEMAIL IS NOT NULL                  ' + #13 +
  '   AND UPPER(NMOUTROINTERESSADO) = UPPER(%S)' ;

//25/09/2015 - shirleano.junior - SALT: 186660/19/4
SQL_RETORNA_PETICAO_MARCADA_SIGILO_CONSULTA =
	'SELECT COUNT(1) ENCONTROU                                        ' + #13 +
	'  FROM %SEFPGPROCESSOAPENSO EPA,                                 ' + #13 +
	'       %SEFPGPROCESSO EP,                                        ' + #13 +
	'       %SEFPGPROCESSOMV EPV,                                     ' + #13 +
	'       %SEFPGTIPOMVPROCESSO ETMP                                 ' + #13 +
	' WHERE EPA.CDPROCESSO = EP.CDPROCESSO                            ' + #13 +
	'   AND EP.NUPROCESSO LIKE %S          	                          ' + #13 +
	'   AND %S = %S                                                   ' + #13 +
	'   AND EPV.CDPROCESSO = EP.CDPROCESSO                            ' + #13 +
	'   AND EPV.NUSEQPROCESSOMV = (SELECT MAX(NUSEQPROCESSOMV)        ' + #13 +
	'                                FROM %SEFPGPROCESSOMV            ' + #13 +
	'                               WHERE CDPROCESSO = EPV.CDPROCESSO)' + #13 +
	'   AND ETMP.CDTIPOMVPROCESSO = EPV.CDTIPOMVPROCESSO              ';



// 28/09/2015 - cesar.almeida - SALT: 186660/19/2
SQL_VERIFICA_MANDADO_EXCEPCIONAL =
  'SELECT NUMANDADO                     ' + #13 +
  '  FROM %SESMDMANDADO EM,             ' + #13 +
  '       %SEFPGPROCESSO EP             ' + #13 +
  ' WHERE EM.CDMODELO = %s              ' + #13 +
  '   AND EM.CDPROCESSO = EP.CDPROCESSO ' + #13 +
  '   AND EP.NUPROCESSO LIKE %s         ';

//28/09/2015 - Leandro.Humbert - SALT: 186660/19/1
SQL_RETORNA_PARTE_USUARIO_NET =
  'SELECT EN.CDPESSOA, EN.NMPESSOA        ' + #13 +
  '          FROM %SEFPGPESSOAUSUNET EPN, ' + #13 +
  '       %SESAJNOME EN                   ' + #13 +
  ' WHERE EPN.CDUSUARIONET = %s           ' + #13 +
  '   AND EPN.CDPESSOA = EN.CDPESSOA      ' + #13 +
  '   %s                                  ';

//01/10/2015 - LUCIANO.FAGUNDES - SALT: 186660/19/5
SQL_VERIFICA_PROCESSO_UNIFICADO =                                                       //*****Fazer****//
  ' SELECT COUNT(1) TOTAL                                           ' + #13 +
  '   FROM %SEFPGPROCESSO EP,                                       ' + #13 +
  '        %SEFPGPROCESSOMV EPM,                                    ' + #13 +
  '        %SEFPGPROCESSOAPENSO EPA                                 ' + #13 +
  '  WHERE EPM.CDPROCESSO = EP.CDPROCESSO                           ' + #13 +
  '    AND EPA.CDPROCESSOAPENSO = EP.CDPROCESSO                     ' + #13 +
  '    AND %S                                                       ' + #13 +
  '    AND EPM.NUSEQPROCESSOMV = (SELECT MAX(NUSEQPROCESSOMV)       ' + #13 +
  '                                 FROM EFPGPROCESSOMV             ' + #13 +
  '                                WHERE CDPROCESSO = EP.CDPROCESSO)' + #13 +
  '    AND EP.NUPROCESSO LIKE %S                                    ' ;

//25/10/2016 - Raphael.Whitlock - Task: 67003
SQL_VERIFICA_PROCESSO_NOVO_DESMEMBRADO =
  'SELECT COUNT(1) ACHOU                  ' + #13 +
  '  FROM %SEFPGPARTE PA                  ' + #13 +
  '  JOIN %SEFPGPROCESSO PR ON            ' + #13 +
  '       PR.CDPROCESSO = PA.CDPROCESSO   ' + #13 +
  '  JOIN %SESAJTIPOPARTE TP ON           ' + #13 +
  '       TP.CDTIPOPARTE = PA.CDTIPOPARTE ' + #13 +
  '  JOIN %SESAJNOME N ON                 ' + #13 +
  '       N.CDPESSOA = PA.CDPESSOA AND    ' + #13 +
  '       N.TPNOME = ''N''                ' + #13 +
  ' WHERE N.NMPESSOA like %S              ' + #13 +
  '   AND PA.FLSITUACAO = %S              ' + #13 +
  '   AND PR.NUPROCESSO like %S 				  ' ;


// 28/09/2015  - Leandro.Humbert - SALT: 186660/19/1
SQL_INCLUI_USUARIO_NET =
  'INSERT INTO %SEFPGPESSOAUSUNET (CDPESSOA, CDUSUARIONET) ' + #13 +
  'VALUES (%s,%s)                                        ';

SQL_VERIFICAR_ENTRANHAMENTO =
  'SELECT COUNT(1) VERIFICOU                          ' + #13 +
  '  FROM %SEFPGPROCESSOAPENSO PA,                    ' + #13 +
  '       %SEFPGPROCESSOMV PM,                        ' + #13 +
  '       %SEFPGTIPOMVPROCESSO PTM                    ' + #13 +
  ' WHERE PA.CDPROCESSO = PM.CDPROCESSO               ' + #13 +
  '   AND PM.CDTIPOMVPROCESSO = PTM.CDTIPOMVPROCESSO  ' + #13 +
  '   AND PTM.CDTIPOMVPROCESSO = %S                   ' + #13 +
  '   AND %S = %S                                     ' + #13 +
  '   AND PA.CDPROCESSO = %S                          ' + #13 +
  '   AND PA.CDPROCESSOAPENSO = %S                    ';

// 02/10/2015  - Leandro.Humbert - SALT: 186660/19/1
SQL_RETORNA_ARQUIVO_MULTIMIDIA =                       //OK
  'SELECT COUNT(1) SALVOU                 ' + #13 +
  '  FROM %SEEDTARQMULTIMIDIA EAM,        ' + #13 +
  '       %SEFPGPROCESSO EP               ' + #13 +
  ' WHERE EP.NUPROCESSO = %S              ' + #13 +
  '   AND EAM.CDPROCESSO = EP.CDPROCESSO  ' + #13 +
  '   AND EAM.NMARQMULTIMIDIA = %S        ';

// 02/10/2015  - Leandro.Humbert - SALT: 186660/19/1
SQL_RETORNA_MOVIMENTCAOCATEGORIA =
 'SELECT COUNT(1) SALVOU      ' + #13 +
 '  FROM %sEGGPTPMVCATEGPG    ' + #13 +
 ' WHERE CDCATEGORIA = %s     ' + #13 +
 '   AND CDTIPOMVPROCESSO = %s';

//08/10/2015 - ANTONIO.SOUSA - SALT: 186660/20/2
SQL_VERIFICAR_VICULACAO_AGENTE_VARA =
  'SELECT COUNT(1) TOTAL       ' + #13 +
  '  FROM %SESAJLOCALAGENTE    ' + #13 +
  ' WHERE CDFORO = %S          ' + #13 +
  '   AND CDLOCAL = %S         ' + #13 +
  '   AND CDAGENTE = %S        ' ;
// 10/10/2015  - Leandro.Humbert - SALT: 186660/20/8
SQL_RETORNA_SITUACAO_MANDADO =                              //OK
 'SELECT COUNT(1) TOTAL                         ' + #13 +
 '  FROM %SesmdMandado MD,                      ' + #13 +
 '       %SesmdSituacaoMand SM                  ' + #13 +
 ' WHERE MD.cdSituacaoMand =  SM.cdSituacaoMand ' + #13 +
 '   and MD.cdSituacaoMand =  %s                ' + #13 +
 '   and MD.NUMANDADO = %s                      ';

// 10/10/2015  - Leandro.Humbert - SALT: 186660/20/8
SQL_RETORNA_DISTRIBUICAO_MANDADO =                //OK
 'SELECT COUNT(1) TOTAL             ' + #13 +
 '  FROM %SesmdMandado MD,          ' + #13 +
 '       %SesmdDistMandado DM       ' + #13 +
 ' WHERE MD.cdMandado = DM.cdMandado' + #13 +
 '   and DM.cdTipoDistMand = %s     ' + #13 +
 '   and DM.cdAgente = %s           ' + #13 +
 '   and MD.nuMandado = %s          ';

// 10/10/2015  - Leandro.Humbert - SALT: 186660/20/8
SQL_RETORNA_GRJ =                          //OK
 'SELECT COUNT(1) TOTAL      ' + #13 +
 '  FROM %SECCPGRJEMITIDA    ' + #13 +
 ' where cdForo = %s         ' + #13 +
 '   and nuGrjEmitida = %s   ';

//08/10/2015 - ANTONIO.SOUSA - SALT: 186660/20/2
// 20/01/2016 - Felipe.s SALT:186660/23/8
SQL_VERIFICAR_CARGA_REMETIDA_LOTE =                //OK
  'SELECT COUNT(1) REMETIDO           ' + #13 +
  '  FROM %SECGOCARGA EC,             ' + #13 +
  '       %SECGOLOTECARGA ELC         ' + #13 +
  ' WHERE ELC.NULOTE = EC.NULOTE      ' + #13 +
  '   AND EC.DTRECEBIMENTO IS NOT NULL' + #13 +
  '   AND EC.NULOTE = %S              ' + #13 +
  '   AND ELC.CDTIPOLOCALDESTINO = %S ' ;

//16/10/015 - Luciano.Fagundes - Salt: 186660/20/4
SQL_VERIFICA_RECEBIMENTO_NULOTE =                             //OK
  'SELECT DTRECEBIMENTO                           ' + #13 +
  '  FROM %SECGOCARGA                             ' + #13 +
  ' WHERE NULOTE = %S                             ' + #13 +
  '   AND CDFORO = %S                             ' + #13 +    //luciano
  '   AND DTRECEBIMENTO IS NOT NULL               ' + #13 +
  '   AND CDOBJETO =  (SELECT MAX(CDOBJETO)       ' + #13 +
  '                      FROM %SEFPGPROCESSO      ' + #13 +
  '                     WHERE NUPROCESSO LIKE %S) ' ;

// 15/10/2015  - Felipe.Santos - SALT: 186660/20/8
SQL_RETORNA_SITUACAO_MANDADO_ATUALIZADO =                         //OK
'SELECT D.CDMANDADO,                                   ' + #13 +
'       D.CDFORO,                                      ' + #13 +
'       D.CDTIPODISTMAND,                              ' + #13 +
'       D.CDAGENTE,                                    ' + #13 +
'       D.DTDISTRIBUICAO,                              ' + #13 +
'       D.QTDILIGENCIA,                                ' + #13 +
'       D.QTKM,                                        ' + #13 +
'       D.CDSITUACAOMAND AS CDSITMANDDIST,             ' + #13 +
'       M.NUMANDADO,                                   ' + #13 +
'       M.CDCENTRAL,                                   ' + #13 +
'       M.CDSITUACAOMAND,                              ' + #13 +
'       M.CDZONA                                       ' + #13 +
'  FROM %SESMDDISTMANDADO D                            ' + #13 +
'  JOIN %SESMDMANDADO M ON (D.CDMANDADO = M.CDMANDADO) ' + #13 +
' WHERE M.NUMANDADO = %s                               ';

// 27/10/2015 - Felipe.s SALT: 186660/20/8
SQL_RETORNA_SITUACAO_MANDADO_ATUALIZADO_NAO_DIST =  //OK
  'SELECT M.CDMANDADO,       ' + #13 +
  '       M.CDFORO,          ' + #13 +
  '       M.CDSITUACAOMAND,  ' + #13 +
  '       M.NUMANDADO,       ' + #13 +
  '       M.CDCENTRAL,       ' + #13 +
  '       M.CDZONA,          ' + #13 +
  '       M.DTCADASTRO       ' + #13 +
  '  FROM %SESMDMANDADO M    ' + #13 +
  ' WHERE M.NUMANDADO = %S   ';

// 15/10/2015  - Felipe.Santos - SALT: 186660/20/8
SQL_RETORNA_ULTIMA_MOV_FLUXO =                         //OK
  'SELECT HIST.nuSeqHist,                          ' + #13 +
  '       FILA.cdFila,                             ' + #13 +
  '       FILA.deFila                              ' + #13 +
  '  FROM %SEWFLHISTOBJETO HIST,                  ' + #13 +
  '       %SEWFLFILATRABALHO FILA                  ' + #13 +
  ' WHERE HIST.cdFila = FILA.cdFila                ' + #13 +
  '   AND HIST.CDOBJETO IN (select CDOBJETO        ' + #13 +
  '                           from ESMDMANDADO     ' + #13 +
  '                          where NUMANDADO = %s) ' + #13 +
  'order by HIST.nuSeqHist desc                    ';

//19/10/2015 - ANTONIO.SOUSA - SALT: 186660/21/4
SQL_AFASTAR_AGENTE =                  //OK
  'UPDATE %SESMDVAGAAGENTE ' +#13 +
  '   SET DTTERMINO = %S   ' +#13 +
  ' WHERE CDAGENTE = %S    ' +#13 +
  '   AND NUSEQVAGA = %S   ';

//19/10/2015 - ANTONIO.SOUSA - SALT: 186660/21/4
SQL_INCLUIR_AGENTE =                          //OK
  'UPDATE %SESMDVAGAAGENTE ' + #13 +
  '   SET DTINICIO = %S    ' + #13 +
  ' WHERE CDAGENTE = %S    ' + #13 +
  '   AND NUSEQVAGA = %S   ' ;

//19/10/2015 - ANTONIO.SOUSA - SALT: 186660/21/4
SQL_AFASTAR_AGENTE_2 =                                                    //OK
  'UPDATE %SESMDVAGAAGENTE                                    ' + #13 +
  '   SET DTTERMINO = %S                                      ' + #13 +
  ' WHERE CDFORO = %S                                         ' + #13 +
  '   AND CDZONA = %S                                         ' + #13 +
  '   AND NUSEQVAGA = %S                                      ' + #13 +
  '   AND CDAGENTE = %S                                       ' ;

//20/10/2015 - ANTONIO.SOUSA - SALT: 186660/24/1
SQL_INCLUIR_AGENTE_2 =                                                     //OK
  'UPDATE %SESMDVAGAAGENTE                                    ' + #13 +
  '   SET DTINICIO =  %S                                      ' + #13 +
  ' WHERE CDFORO = %S                                         ' + #13 +
  '   AND CDZONA = %S                                         ' + #13 +
  '   AND NUSEQVAGA = %S                                      ' + #13 +
  '   AND CDAGENTE = %S                                       ' ;

//20/10/2015 - ANTONIO.SOUSA - SALT: 186660/24/1
SQL_VERIFICAR_TRANFERENCIA_MANDADO =                           //OK
  'SELECT COUNT(1) TOTAL                            ' + #13 +
  '  FROM %SESMDMANDADO EM,                         ' + #13 +
  '       %SESMDDISTMANDADO EDM                     ' + #13 +
  'WHERE EM.CDMANDADO = EDM.CDMANDADO               ' + #13 +
  '  AND EM.CDPROCESSO = (SELECT CDPROCESSO         ' + #13 +
  '                         FROM EFPGPROCESSO       ' + #13 +
  '                        WHERE NUPROCESSO LIKE %S)' + #13 +
  '  AND EDM.CDAGENTE = %S                          ' ;

//21/10/2015 - ANTONIO.SOUSA - SALT: 186660/21/4
SQL_RETORNA_USUARIO_AGENTE =           //OK
  'SELECT CDUSUARIO        ' + #13 +
  '  FROM %SESEGUSUARIO    ' + #13 +
  ' WHERE NMUSUARIO like %S' ;

//22/10/2015 - ANTONIO.SOUSA - SALT: 186660/21/4
SQL_RETORNA_AGENTE_DOC_EMITIDO =                           //OK
  'SELECT ESU.NMUSUARIO                      ' + #13 +
  '  FROM %SEEDTDOCEMITIDO ED,               ' + #13 +
  '       %SESEGUSUARIO ESU                  ' + #13 +
  ' WHERE ED.CDUSUARIOCRIACAO = ESU.CDUSUARIO' + #13 +
  '   AND ED.CDDOCUMENTO = %S                ' + #13 +
  '   AND ED.CDPROCESSO = %S                 ' ;

//26/10/2015 - ANTONIO.SOUSA - SALT: 186660/21/4
SQL_ALTERA_DTCUMPRIMENTO_DTVENCTOPRAZO =                                          //*******Fazer******//
  'UPDATE %SESAJPENDENCIAPRAZO                     ' + #13 +
  '   SET DTCUMPRIMENTO = NULL,                    ' + #13 +
  '       DTVENCTOPRAZO = %S                       ' + #13 +
  ' WHERE CDPROCESSO = (SELECT CDPROCESSO          ' + #13 +
  '                       FROM EFPGPROCESSO        ' + #13 +
  '                      WHERE NUPROCESSO LIKE %S) ' ;

//29/10/2015 - ANTONIO.SOUSA - SALT: 186000/21/4
SQL_VERIFICAR_AGENTE_MANDADO_DISTRIBUIDO =                                       //OK
  'SELECT EDM.CDAGENTE                                                 ' + #13 +
  '  FROM %SESMDDISTMANDADO EDM,                                       ' + #13 +
  '       %SESMDMANDADO EM,                                            ' + #13 +
  '       %SEFPGPROCESSO EP                                            ' + #13 +
  ' WHERE EDM.CDMANDADO = EM.CDMANDADO                                 ' + #13 +
  '   AND EM.CDPROCESSO = EP.CDPROCESSO                                ' + #13 +
  '   AND EP.NUPROCESSO LIKE %S                                        ' + #13 +
  '   AND EDM.NUSEQDISTMANDADO = (SELECT MAX(EMDT.NUSEQDISTMANDADO)    ' + #13 +
  '                                 FROM %SESMDDISTMANDADO EMDT        ' + #13 +
  '                                WHERE EMDT.CDMANDADO = EM.CDMANDADO)' ;

//29/10/2015 - ANTONIO.SOUSA - SALT: 186000/21/4
SQL_VERIFICA_DADOS_MANDADO_REDISTRIBUIDO =                                    //OK
  'SELECT EDM.CDTIPODISTMAND,                                      ' + #13 +
  '       EDM.CDMANDADO,                                           ' + #13 +
  '       EHM.CDTIPOOPERACAO,                                      ' + #13 +
  '       EHM.DTOPERACAO,                                          ' + #13 +
  '       EHM.DEOBSERVACAO,                                        ' + #13 +
  '       EHM.CDSITUACAOMAND,                                      ' + #13 +
  '       EP.CDFORO,                                               ' + #13 +
  '       EM.CDZONA                                                ' + #13 +
  '  FROM %SESMDDISTMANDADO EDM,                                   ' + #13 +
  '       %SESMDHISTMANDADO EHM,                                   ' + #13 +
  '       %SESMDMANDADO EM,                                        ' + #13 +
  '       %SEFPGPROCESSO EP                                        ' + #13 +
  ' WHERE EDM.CDMANDADO = EHM.CDMANDADO                            ' + #13 +
  '   AND EDM.NUSEQDISTMANDADO = EHM.NUSEQDISTMANDADO              ' + #13 +
  '   AND EHM.CDMANDADO = EM.CDMANDADO                             ' + #13 +
  '   AND EM.CDPROCESSO = EP.CDPROCESSO                            ' + #13 +
  '   AND EP.NUPROCESSO LIKE %S                                    ' + #13 +
  '   AND EHM.NUSEQDISTMANDADO = (SELECT MAX(NUSEQDISTMANDADO)     ' + #13 +
  '                                 FROM ESMDHISTMANDADO           ' + #13 +
  '                                WHERE CDMANDADO = EHM.CDMANDADO)' ;

//30/10/2015 - ANTONIO.SOUSA - SALT: 186660/21/4
SQL_RETORNA_CDMANDADO =                                          //OK
  'SELECT CDMANDADO                                ' + #13 +
  '  FROM %SESMDMANDADO                            ' + #13 +
  '  where CDPROCESSO = (SELECT CDPROCESSO         ' + #13 +
  '                        FROM %SEFPGPROCESSO     ' + #13 +
  '                       WHERE NUPROCESSO LIKE %S)' ;

//29/10/2015 - Rafael.Buss - SALT: 186660
SQL_RETORNA_PROCESSO_DOCUMENTO_ASSINADO =
  'SELECT NUPROCESSO                                        ' + #13 +
  '  FROM (SELECT PRO.NUPROCESSO                            ' + #13 +
  '          FROM EEDTDOCEMITIDO EDT,                       ' + #13 +
  '               EFPGPROCESSO PRO                          ' + #13 +
  '         WHERE EDT.FLASSINATDIGITAL = ''S''              ' + #13 +
  '           AND PRO.CDSITUACAOPROCESSO <> ''C''           ' + #13 +
  '           AND TRUNC(EDT.DTFINALIZACAO) = TRUNC(SYSDATE) ' + #13 +
  '           AND PRO.CDPROCESSO = EDT.CDPROCESSO)          ';// + #13 +
  //'         ORDER BY DBMS_RANDOM.VALUE())                   ' + #13 +
  //' WHERE ROWNUM = 1                                        ';

// 21/10/2015 leandro.humbert SALT:186660/20/8
// 05/11/2015 - Felipe.s SALT: 186660/22/5
SQL_RETORNA_DIGDOCUMENTO =                                     //OK
  'SELECT DOC.CDDOCUMENTO,                                                 ' + #13 +
  '       DOC.CDTIPODOCDIGITAL,                                            ' + #13 +
  '       DOC.FLASSINADO                                                   ' + #13 +
  '  FROM %SEDIGDOCUMENTO DOC                                              ' + #13 +
  ' WHERE DOC.CDDOCUMENTO IN (SELECT CDDOCUMENTO                           ' + #13 +
  '                             FROM %SEDIGPROCESSODOC                     ' + #13 +
  '                            WHERE CDPROCESSO = (SELECT MAX(CDPROCESSO)  ' + #13 +
  '                                                  FROM %SEFPGPROCESSO   ' + #13 +
  '                                                 WHERE NUPROCESSO = %S))';

// 22/10/2015 - Felipe.s SALT:186660/20/8
SQL_VERIFICA_STATUS_SIGILO =
'  select  DOC.CDDOCUMENTO,                      ' + #13 + //OK
'          PROC.NUPROCESSO,                      ' + #13 +
'          DOC.FLSIGILOEXTERNO,                  ' + #13 +
'          DIGPROC.CDPROCESSO                    ' + #13 +
'     from %SEDIGDOCUMENTO DOC,                  ' + #13 +
'          %SEDIGPROCESSODOC DIGPROC,            ' + #13 +
'          %SEFPGPROCESSO PROC                   ' + #13 +
'    where DOC.CDDOCUMENTO = DIGPROC.CDDOCUMENTO ' + #13 +
'      and DIGPROC.CDPROCESSO = PROC.CDPROCESSO  ' + #13 +
'      and PROC.NUPROCESSO = %s                  ';

// 23/10/2015 - Felipe.s SALT:186660/20/8
SQL_VERIFICA_EXISTENCIA_LOTE =
'  select COUNT(1) EXISTE ' + #13 + //OK
'    from %SECGOCARGA     ' + #13 +
'   where NULOTE = %s     ';

SQL_VALIDA_LOCAL_REMESSA_PENDENTE =                      //OK
'SELECT DISTINCT CDLOCALDESTINO                ' + #13 +
'  FROM %SECGOCARGA EC                         ' + #13 +
' WHERE EC.DTRECEBIMENTO IS NULL               ' + #13 +
'   AND EC.NULOTE = %s                         ' + #13 +
'   AND EC.CDFORO = %s                         ' + #13 +
'   AND EC.CDTIPOLOCALDESTINO = %s             ';

SQL_VERIFICA_CANCELAMENTO_PROCESSO =                   //OK
  'SELECT COUNT(1) TOTAL             ' + #13 +
  '  FROM %SEFPGPROCESSO             ' + #13 +
  ' WHERE NUPROCESSO LIKE %S         ' + #13 +
  '   AND CDSITUACAOPROCESSO =  ''C''';

// 10/11/2015 leandro.humbert SALT:186660/22/5
SQL_VERIFICA_VINCRECOLMAND =                                       //OK
'SELECT COUNT(1) EXISTE                        ' + #13 +
'  from %SEFPGVINCRECOLMAND                    ' + #13 +
' where CDPROCESSO in (select cdprocesso       ' + #13 +
'                        from %Sefpgprocesso   ' + #13 +
'                       where nuprocesso = %s) ' + #13 +
'  and CDMANDADO in (select cdmandado          ' + #13 +
'                      from %Sesmdmandado      ' + #13 +
'                     where numandado = %s)    ' + #13 +
'  and CDCALCULOGRJ = %s                       ' + #13 +
'  %S                                          ';

// 10/11/2015 leandro.humbert SALT:186660/22/5
SQL_VERIFICA_PUBLICAPESSOA =
'select COUNT(1)EXISTE                                ' + #13 +  //OK
'  from %SEFPGPUBLICAPESSOA                           ' + #13 +
'  where CDPROCESSO in (                              ' + #13 +
'     select cdprocesso from efpgprocesso             ' + #13 +
'     where nuprocesso = %s)                          ' + #13 +
'  and %S = %S                                        ';

//13/11/2015 - ANTONIO.SOUSA - SALT: 186660/22/1
SQL_RETORNA_LOTACAO_USUARIO =                 //OK
  'SELECT COUNT(1) TOTAL      ' + #13 +
  '  FROM %SESAJUSUARIOLOTACAO' + #13 +
  ' WHERE CDUSUARIO = %S      ' ;

//25/11/2015 - Shirleano.Junior - SALT: 186660/23/4
SQL_RETORNA_NUPROCESSO_COMPLETO =                                 //OK
  'SELECT NUPROCESSO FROM %SEFPGPROCESSO WHERE NUPROCESSO LIKE %S';

//07/12/2015 - ANTONIO.SOUSA - SALT: 186660/23/1
SQL_VERIFICA_SITUACAO_PROCESSO =
  'SELECT COUNT(1) TOTAL          ' + #13 +
  '  FROM %SEFPGPROCESSO          ' + #13 +
  ' WHERE CDSITUACAOPROCESSO = %S ' + #13 +
  '   AND NUPROCESSO = %S         ' ;

SQL_VERIFICA_TIPO_SIGILO_PROCESSO_DEPENDENTE =
  'SELECT COUNT(1) TOTAL                         ' + #13 +
  '  FROM %SVSAJPROCESSO                         ' + #13 +
  ' WHERE CDPROCESSO = (SELECT CDPROCESSO        ' + #13 +
  '                       FROM %SEFPGPROCESSO    ' + #13 +
  '                      WHERE NUPROCESSO = %S   ' + #13 +
  '                        AND NUNIVELDEPEND = 1)' + #13 +
  '   AND TPSIGILO = %S                          ' ;

SQL_RETORNA_PROCESSO_REATIVADO =
  'SELECT COUNT(1) TOTAL             ' + #13 +
  '  FROM %SEFPGPROCESSO             ' + #13 +
  ' WHERE CDSITUACAOPROCESSO <> ''C''' + #13 +
  '   AND NUPROCESSO = %S            ' ;

SQL_VERIFICAR_JUNTADA =
  'SELECT COUNT(1) TOTAL                     ' + #13 +
  '      FROM %SEFPGPROCESSO EP,             ' + #13 +
  '           %SEFPGPROCESSOAPENSO EPA       ' + #13 +
  '     WHERE EP.CDPROCESSO = EPA.CDPROCESSO ' + #13 +
  '       AND EP.NUPROCESSO = %S             ' ;

SQL_VERIFICA_FORO_DESTINO =
  'SELECT CASE WHEN EP.CDFORODESTINO IS NOT NULL' + #13 +
  '       THEN 1                                ' + #13 +
  '       ELSE 0 END ENCONTROU                  ' + #13 +
  '  FROM %SEFPGPROCESSO EP                     ' + #13 +
  ' WHERE NUPROCESSO like %S                    ' + #13 +
  ' AND CDFORODESTINO = %S                      ' ;

SQL_RETORNA_SIGLA_CLIENTE =
  'SELECT %S AS CLIENTE       ' + #13 +
  '  FROM %SEPADVALORPARAMETRO' + #13 +
  ' WHERE CDSISTEMA = 90      ' + #13 +
  '   AND CDPARAMETRO = 1032  ' ;

//jcf:format=on

implementation

end.

