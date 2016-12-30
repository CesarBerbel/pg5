unit ufpgConstanteSQL;

interface

uses
  SysUtils, uspFuncoesSQL, uspAplicacao, uspDatabase;


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
//  'SELECT COUNT(1) QTDE                                                                                              ' + #13 +    esse n�o existe em outro lugar
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
'                  AND NUPROCESSO = %S                  ' + #13 +
'                  AND CDPROCESSO = EP.CDPROCESSOPRINC) ' + #13 +
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

{ Data de Cria��o:  01/07/2015  Respons�vel: Shirleano.Junior  Salt:186660/6/5 }
SQL_VERIFICA_CADASTRO_PROCESSO_PROTOCOLO =
  'SELECT COUNT(1) TOTAL                            ' + #13 +
  '  FROM %SEFPGPROCESSO EP                         ' + #13 +
  ' WHERE EP.FLPROCVIRTUAL = ''S''                  ' + #13 +
  '   AND NUPROCESSO = %S                           ' + #13 +
  '   AND EXISTS (SELECT 1                          ' + #13 +
  '                 FROM %SEFPGPROCESSOMV           ' + #13 +
  '                WHERE CDPROCESSO = EP.CDPROCESSO)';

{ Data de Cria��o:  02/07/2015  Respons�vel: Shirleano.Junior  Salt: 186660/6/5}
SQL_VERIFICA_ALTERACAO_DADOS_PESSOA =
  'SELECT COUNT(1) TOTAL                 ' + #13 +
  '  FROM %SESAJNOME NM, ESAJPESSOADOC PC' + #13 +
  ' WHERE NM.CDPESSOA = PC.CDPESSOA      ' + #13 +
  '   AND NM.NMPESSOA = %S               ' + #13 +
  '   AND PC.DEORGAOEXPEDIDOR = %S       ' ;

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


{ Data de Cria��o:  24/08/2015  Respons�vel: Shirleano.Junior  Salt: 186660/13/4}
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
SQL_ALTERA_TIPO_ESTADO_AR =                 //OK  - Verificar com C�sar
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
  '        ELSE ''N�O ENCONTROU'' END TITULO_ANOTACAO,                                  ' + #13 +
  '        EAP.NUSEQPAGINA PAGINA_ANOTACAO                                              ' + #13 +
  '  FROM %SEDIGPROCESSODOC PD                                                          ' + #13 +
  '  LEFT JOIN %SEDIGANOTACAOPAGINA EAP ON (EAP.CDDOCUMENTO = PD.CDDOCUMENTO),          ' + #13 +
  '       %SEDIGDOCUMENTO D,                                                            ' + #13 +
  '       %SEFPGPROCESSO EP                                                             ' + #13 +
  ' WHERE EP.NUPROCESSO = %S                                                            ' + #13 +
  '   AND PD.CDDOCUMENTO = D.CDDOCUMENTO                                                ' + #13 +
  '   AND EP.CDPROCESSO = PD.CDPROCESSO                                                 ' + #13 +
  ' ORDER BY 7 ASC                                                                      ';

//{ Data de Cria��o:  02/09/2015  Respons�vel: Shirleano.Junior  Salt: 186660/13/4}
//SQL_VERIFICAR_AR_REMETIDO =
//  'SELECT COUNT(1) TOTAL                            ' + #13 +
//  '  FROM ESARAR EA,                                ' + #13 +
//  '       ESARTIPOESTADOAR EATE                     ' + #13 +
//  ' WHERE EA.CDARTJ = %S                            ' + #13 +
//  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR   ' + #13 +
//  '   AND EATE.CDTIPOESTADOAR = 4                   ' ;


{ Data de Cria��o:  03/09/2015  Respons�vel: Shirleano.Junior  Salt: 186660/13/4}
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
//01/10/2015 - LUCIANO.FAGUNDES - SALT: 186660/19/5
SQL_VERIFICA_PROCESSO_NOVO_DESMEMBRADO =                                                        //****Fazer****//
  'SELECT EFPPA.FLSITUACAO,                                                      ' + #13 +
  '       ESAN.NMPESSOA AS NOME                                                  ' + #13 +
  '  FROM %SEFPGPROCESSO EFPP,                                                   ' + #13 +
  '       %SEFPGPARTE EFPPA,                                                     ' + #13 +
  '       %SESAJNOME ESAN,                                                       ' + #13 +
  '       %SESAJTIPOPARTE ESATATI,                                               ' + #13 +
  '       %SESAJTIPOPARTE ESATPAS                                                ' + #13 +
  ' WHERE EFPP.CDPROCESSO = EFPPA.CDPROCESSO                                     ' + #13 +
  '   AND EFPPA.CDPESSOA = ESAN.CDPESSOA                                         ' + #13 +
  '   AND EFPPA.CDTIPOPARTE = ESATATI.CDTIPOPARTE                                ' + #13 +
  '   AND EFPPA.CDTIPOPARTE = ESATPAS.CDTIPOPARTE                                ' + #13 +
  '   AND EFPP.CDPROCESSO = (SELECT CDPROCESSO                                   ' + #13 +
  '                            FROM EFPGPROCESSO                                 ' + #13 +
  '                           WHERE NUPROCESSO LIKE %S)                          ' + #13 +
  '   AND EFPPA.FLPRINCIPAL = ''S''                                              ' + #13 +
  '   AND ESAN.TPNOME = ''N''                                                    ' + #13 +
  '   AND (((EFPPA.CDPESSOA = EFPP.CDPARTEATIVAPRINC)                            ' + #13 +
  '   AND (EFPPA.TPPARTE = 1)) OR  ((EFPPA.CDPESSOA = EFPP.CDPARTEPASSIVPRINC)   ' + #13 +
  '   AND (EFPPA.TPPARTE = 2)))                                                  ' ;


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

//19/04/2016 - ANTONIO.SOUSA - SALT: 186660/23/1
SQL_VERIFICA_PROCESSO_EXCEPCIONAL =
  'SELECT COUNT(1) TOTAL    ' + #13 +
  '  FROM %SEFPGPROCESSO    ' + #13 +
  ' WHERE NUPROCESSO LIKE %S' + #13 +
  ' AND FLEXCEPCIONAL = ''S'' ' ;

//jcf:format=on

// 20/11/2015  - Carlos.Gaspar - SALT: 186660/23/7
function RetornaVerificacaoSentenca(psTipoMvProcesso: string; psNuProcesso: string): WideString;

function RetronaLotacaoUsuario(psCdAgente: string): WideString;

function RetornaPublicaPessoa(psNuProcesso: string): WideString;

function RetornaVerificaVincrecolMand(psNuProcesso, psNuMandado, psCdCalculoGRJ: string): WideString;

function RetornaVerificaCancelamentoProcesso(psNuProcesso: string): WideString;

function RetornaValidarLocalRemessaPendente(psNuLote: string; psNuForo: string;
  psCdTipoLocalDestino: string): WideString;

function RetornaVerificarStatusSigilo(psNuProcesso: string): WideString;

function RetornaVerificarExistenciaLote(psNuLote: string): WideString;

function RetornaDigDocumento(psNuProcesso: string): WideString;

function RetornaCdMandado(psNuProcesso: string): WideString;

function RetornaVerificarDadosMandadoRedistribuido(psNuProcesso: string): WideString;

function RetornaVerificarAgenteMandadoDistribuido(psNuProcesso: string): WideString;

function RetornaAgenteDocEmitido(pscdDocumento: string; psCdProcesso: string): WideString;

function RetornaVerificarTransferenciaMandado(psNuProcesso: string;
  psCdAgente: string): WideString;

function RetornaCdUsuarioAgente(psNomeAgente: string): WideString;

function RetornarIncluirAgente2(psData: string; psCdForo: string; psCdZona: string;
  psNuVaga: string; psCdAgente: string): WideString;

function RetornarAfastarAgente2(psData: string; psCdForo: string; psCdZona: string;
  psNuVaga: string; psCdAgente: string): WideString;

function RetornarIncluirAgente(psData: string; psNuVaga: string; psCdAgente: string): WideString;

function RetornarAfastarAgente(psData: string; psNuVaga: string; psCdAgente: string): WideString;

function RetornarUltimaMovimentacaoFluxo(psNuMandado: string): WideString;

function RetornarSituacaoMandadoAtualizadoNaoDistribuido(psNuMandado: string): WideString;

function RetornarSituacaoMandadoAtualizado(psNuMandado: string): WideString;

function RetornarVerificarRecebimentoNumeroLote(psNuLote: string; psCdForo: string;
  psNuProcesso: string): WideString;

function RetornarVerificarCargaRemetidaLote(psNuLote: string;
  psCdTipoLocalDestino: string): WideString;

function RetornarGRJ(psCdForo: string; psNuGrjEmitida: string): WideString;

function RetornarDistribuicaoMandado(psCdTipoDistMand: string; psCdAgente: string;
  psNuMandado: string): WideString;

//C�sar fez aqui
function RetornarFilaProcessoSql(psNuprocesso: string; psFila: string): WideString;

function RetornarProcessoSql(psSituacao: string): WideString;

function RetornarAudienciaMarcadaSql(psNuprocesso: string): WideString;

function RetornarDocumentoEmitidoSql(psNuprocesso: string): WideString;

function RetornarMudouVaraSql(psNuprocesso: string; psUnicaVara: boolean): WideString;

function RetornarCadastroContatoSql(psNuCPF: string): WideString;

function RetornarCdProcessoSql(psNuprocesso: string): WideString;

function VerificarCadastroParteSql(psNuPessoa: string; psNuprocesso: string): WideString;

function RetornarMudouVagaSql(psCdVaga: string; psNuprocesso: string): WideString;

function RetornarRealmenteEncaminhouSql(psNuprocesso: string): WideString;

function VerificarCadastroBemSql(psNuprocesso: string): WideString;

//function VerificarPeticaoExcepcionalInicialSql(psNuProtocolo: string): WideString;

function VerificarPeticaoCadastradaSql(psNuprocesso, psNuClasseProcesso: string): WideString;

function RetornarNumeroProcessoSql: WideString;

//function SqlChecarProtocoloDocumento(psNuprocesso: string; psNuProtocolo: string): WideString;

//function ChecarProtocoloSql(psNuProtocolo: string): WideString;

function RetornarDataAudienciaSql(psCDVara, psCDSala: string): WideString;

function PropriedadesDocumentoSql(psNuProcesso: string; psCdDocumento: string): WideString;

function VerificarPeticaoInicialSql(psNuProcesso: string; psTpSigilo: string): WideString;

function RetornarProcessoMovUnitariaSql(psNomePessoa: string): WideString;

function VerificarMovUnitariaSql(psTpMovimentacao, psNuProcesso: string): WideString;

function VerificarAssuntoInseridoSql(psNuProcesso: string): WideString;

function VerificarApensamentoSql(psCdProcesso: string): WideString;

function VerificarNuProcessoSql(psNuProcesso: string): WideString;

function RetornarProcessosMovimentacoesLoteSql: WideString;

function VerifcarMovimetacoesLoteSql(psNuProcessos: string): WideString;

function VerifcarExclusaoMovimetacaoSql(psCdProcesso: string): WideString;

function RetornarProcessoEmissaoDocDtAlteradaSql: WideString;

function VerificarDtMovDocumentoSql(psNuprocesso: string): WideString;

function VerificarPeticaoIntermdiariaSql(psNuprocesso: string): WideString;

function RetornarProcessoNaoFinalizadoSql: WideString;

function VerifcarRecadoInseridoSql(psCdUsuarioDestino, psDeRecado: string): WideString;

function VerifcarAutoTextoSql(psCdUsuario, psNmAbrevAutoTexto, psCdGrupo: string): WideString;

function RetornarProcessoApreensaoSql: WideString;

function VerificarProcessoFisicoApreensaoSql(psNuProcesso, psCdCategoriaBem: string): WideString;

function RetornarProcessoEdicaoDocSql: WideString;

function VerifcarpeticaoDiversaSql(psNuProcesso: string): WideString;

function RetornarDocEmitidoSql(psCategoria, psModelo, psNuProcesso: string): WideString;

function VerifcarCadastroProcessoProtocoloSql(psNuProcesso: string): WideString;

function RetornarProcessoBemSql(psNuProcesso: string): WideString;

function VerifcarAlteracaoDadosPessoaSql(psNmPessoa, psDeOrgaoExp: string): WideString;

function VerificarDistribuicaoProcessosSql(psNuProcesso: string): WideString;

function RetornarProcessoAlteracaoSql: WideString;

function RetornarNomeDocSql(psNuProcesso, psCategoria, psModelo: string): WideString;

function RetornarProcessoExpedienteFinalSql: WideString;

function VerificarProcessoLiberadoAutosSql(psNuProcesso, psCdCategoria, psCdModelo: string): WideString;

function RetornarCorrecaoClasseSql(psNuProcesso: string): WideString;

function RetornarProcessoSimplesSql: WideString;

function RetornarProcessoDocumentoCompartilharSql: WideString;

function VerificarExisteProcessoDistribuicaoSql(psData, psCDForo, psCDTipoCartorio: string): WideString;

function VerificarEncaminhamentoSql(psNuProcesso: string): WideString;

function RetornarDocumentoProcessoSql(psNuProcesso: string): WideString;

function RetornarProcessoDistribuidoSemPendenciaSql: WideString;

function RetornarProcessoLocalFisicoSql(psCdForo: string): WideString;

function RetornarProcessoVisualizaDocSql: WideString;

function RetornarProcessoVirtualizadoSql(psNuProcesso: string): WideString;

function VerificarProcessoDependenteSql(psNuProcesso: string): WideString;

function VerificarPeticaoIntermediariaSql(psNuProcesso: string): WideString;

function VerificarDistribuicaoProcessoSql(psNuProcesso: string): WideString;

function VerificarProcessoFisicoSql(psNuProcesso: string): WideString;

function VerificarProcessoRemetidoSql(psNuLote, psNuProcesso, psTpLocalDestino: string): WideString;

function VerificarProcessoRecebidoSql(psNuLote, psNuProcesso, psTpLocalDestino: string): WideString;

function VerificarMovimentacaoProcessoSql(psNuProcesso, psCDTipoMVProcesso: string): WideString;

function VerificarMandadoEmetidoSql(psCDCategoria, psCDModelo, psNuprocesso,
  psCDAssuntoPrinc: string): WideString;

function VerificarMandadoCriadoSql(psCDModelo, psNuprocesso: string): WideString;

function VerificarIntimacaoEmitidaSql(psCDCategoria, psCDModelo, psNuprocesso,
  psCDAssuntoPrinc: string): WideString;

function VerificarIntimacaoCriadaSql(psCDModelo, psNuprocesso: string): WideString;

function RetornaProcessoDemonsDistribSql(pscdForo: string): WideString;

function RetornarAtualizarDtCumprimentoDtVenctoPrazo(psDataVenctoPrazo: string;
  psNuProcesso: string): WideString;

function RetornarVerificarProcessoNovoDesmembrado(psNuProcesso: string): WideString;

function RetornarVerificarProcessoUnificado(psNuProcesso: string): WideString;

function RetornarVerificarEmailRecebido(psNmParte: string): WideString;

function RetornarVerificarOficioImpresso(psDeOperacao: string): WideString;

//function RetornarVerificarProcessoUnificado(psCdProcesso: string;
//  psNmOutroInteressado: string): WideString;

function RetornarVerificarTesteConsultaAutos(psNuProcesso: string; psAnotacao: string): WideString;

function RetornarVerificarCancelamentoJuntada(psCdProcessoApenso: string): WideString;

function RetornarPeticaoSalva(psNuProcesso: string; psDeClasse: string): WideString;

function RetornarVerificarCopiaPartes(psNuProcesso: string; psDeClasse: string): WideString;

function RetornarJuntadaProcessoDependente(psNuProcesso: string;
  psCdTipoMvProcesso: string): WideString;

function RetornarVerificarCertidaoEmitida(psCdSituacao: string; psNuPedido: string): WideString;

function RetornarVaraDoProcesso(psNuProcesso: string): WideString;

function RetornarLiberouDocumentoAutos(psCdDocumentoEdt: string): WideString;

function RetornarNuProcessoCompleto(psNuProcesso: string): WideString;

function RetornarDocumentoEmitdoGGP(psCdDocumento: string): WideString;

function RetornarDocumentoEmitdo2(psCdDocumento: string): WideString;

function RetornarVerificarHistoricoParte(psNuProcesso: string; psQtde: string): WideString;

function RetornarVerificarParteIndiciado(psNmPessoa: string; psNuProcesso: string): WideString;

function RetornarVerificarObservacaoDocumento(psCdDocumnento: string): WideString;

function RetornarVerificarObservacaoProcessoFluxoTrabalho(psNuProcesso: string): WideString;

function RetornarVerificarDevolucaoAR(psCdARTJ: string; psCdTipoEstadoAR: string): WideString;

function RetornarVerificarARAguardandoJuntada(psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;

function RetornarVerificarARJuntadaProcesso(psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;

//  psCdTipoEstadoAR: string; psNuDocRecebedor: string): WideString;

function RetornarVerificarParcelasMulta(psNuProcesso: string): WideString;

function RetornarMovimentacaoCategoria(psCdCategoria: string;
  psCdTipoMvProcesso: string): WideString;

function RetornarVerificarARRemetido(psCdARTJ: string; psCdTipoEstadoAR: string): WideString;

function RetornarRecebidoNoCartorio(psNuLote: string; psCdARTJ: string): WideString;

function RetornarVerificarNumeroDocumentoAlterado(psCdARTJ: string;
  psCdTipoEstadoAR: string; psNuDocRecebedor: string): WideString;

function RetornarVerificarSituacaoAR(psCdARTJ: string): WideString;

function RetornarSituacaoMandado(psCdSituacaoMandado: string; psNuMandado: string): WideString;

function RetornarVerificarVinculacaoAgenteVara(psCdForo: string; psCdLocal: string;
  psCdAgente: string): WideString;

function RetornarVerificarEntranhamento(psCdTipoMvProcesso: string; psData: string;
  psCdProcesso: string; psCdProcessoApenso: string): WideString;

function RetornarParteUsuarioNet(psCdUsuarioNet: string; psDados: string): WideString;

function RetornarVerificarMandadoExcepcional(psCdModelo: string; psNuProcesso: string): WideString;

function RetornarProcessoDocumentoAssinado: WideString;

function RetornarProcessoRelAnaliticoSql(psCdForo, psCDVara, psCdUltimMv: string): WideString;

function RetornarPeticaoMarcadaSigiloConsulta(psNuProcesso: string): WideString;

function RetornarVerificarARGerada(psCdARTJ: string): WideString;

function RetornarAlteraTipoEstadoAR(psCdARTJ: string): WideString;

function RetornarArquivoMultiMidia(psNuProcesso: string; psNmArqMultiMidia: string): WideString;

function RetornarGerarGuiaPostagemAR(psCdForo: string; psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;

function RetornarARRemetidoNaoRecebido(psNuLote: string; psCdARTJ: string): WideString;

function RetornarCopiaFila(psCdFila: string; psNuprocesso: string): WideString;

function RetornarNuProcessoSemPendencia(pnQtdeLinhas: integer): WideString;

function RetornarVerificarLocalProcessoFisico(psCdProcesso: string): WideString;

function RetornarEnderecoCPF(psNuDocumento: string): WideString;

function RetornarVerificarProcessoCancelado(psNuProcesso: string): WideString;

function RetornarVerificarProcessoRegSentenca(psCdTipoMvProcesso: string;
  psNuProcesso: string): WideString;

function RetornarProcessoRegistroSentenca(psCdCategoria: string;
  pnQtdeLinhas: integer): WideString;

function RetornarProcessoConsProcBasica(pnQtdeLinhas: integer): WideString;

function RetornarIncluirUsuarioNet(psCdPessoa: string; psCdUsuarioNet: string): WideString;

function RetornarProcessoRelExtrato(pnQtdeLinhas: integer;
  psCdForo, psCDVara, psCdUltimMv: string): WideString;

function RetornarRelCalculoIdade(psCdVara: string; pnQtdeLinhas: integer): WideString;

function RetornarVerificarMandadoDevolvidoCartorio(psNuLote: string;
  psCdTipoLocalOrigem: string; psCdTipoLocalDestino: string): WideString;

function RetornarVerificarDevolvicaoMandadoCartorio(psNuLote: string;
  psCdTipoLocalOrigem: string; psCdTipoLocalDestino: string): WideString;

function RetornarSenhaGerada(psCdProcesso: string; psNmOutroInteressado: string): WideString;

function RetornarVerificarAlteracaoPautaAudienciaBloco(psCdSala: string;
  psCdVara: string; psCdTipoAudiencia: string; psNuProcesso: string): WideString;

function RetornarVerificarAudienciaCancelada(psCdAudiencia: string;
  psCdSituacaoAudi: string): WideString;

function VerificarMandadoRemetidoCMSql(psNuLote, psCDTipoLocalOrigemSQL,
  psCDTipoLocalDestinoSQL: string): WideString;

function RetornarVerficarSituacaoProcesso(psSituacaoProcesso: string;
  psNuProcesso: string): WideString;

function RetornarVerficarSigiloProcessoSQL(psNuProcesso: string; psTipoSigilo: string): WideString;

function VerificarMandadoDistribuidoAgenteSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;

function VerificarMandadoAgenteSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;

function VerificarMandadoDistribuidoCentralSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;

function VerificarSituacaoMandadoSql(psNuprocesso, psSituacao, psOficialJustica,
  psCDTipoOperacaoSQL2: string): WideString;

function RetornarVerficarProcessoReativadoSQL(psNuProcesso: string): WideString;

function VerificarJuntadaSql(psNuprocesso: string): WideString;

function VerificarForoProcessoSql(psNuprocesso: string; psCdForo: string): WideString;

function VerificarProcessoExcepcionalSql(psNuprocesso: string): WideString;

implementation

//C�sar fez isso aqui

function RetornarFilaProcessoSql(psNuprocesso: string; psFila: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_FILA_PROCESSO, [sEsquema, sEsquema, psFila,
    sEsquema, quotedstr(psNuprocesso + '%'), sEsquema]);
end;

function RetornarProcessoSql(psSituacao: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNA_PROCESSO, [sEsquema, sEsquema, psSituacao,
      FoFuncoesSQL.dthr('01/01/2015')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarAudienciaMarcadaSql(psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_AUDIENCIA_MARCADA, [sEsquema, sEsquema, sEsquema,
    quotedstr(psNuprocesso)]);
end;

function RetornarDocumentoEmitidoSql(psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_DOCUMENTO_EMITIDO, [sEsquema, sEsquema, quotedstr(psNuprocesso)]);
end;

function RetornarMudouVaraSql(psNuprocesso: string; psUnicaVara: boolean): WideString;
var
  sEsquema: string;
  sSelect: string;
  sCondicao: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  if psUnicaVara then
  begin
    sSelect := 'SELECT CASE WHEN EDP1.CDVARA <> EDP.CDVARA      ' + #13 +
      '       THEN 1                                   ' + #13 +
      '       ELSE 0 END ENCONTROU                     ';
    sCondicao := '    AND EDP.NUSEQDISTRIB = (EDP1.NUSEQDISTRIB-1)';
  end
  else
  begin
    sSelect := ' SELECT COUNT(1) TOTAL                          ';
    sCondicao := ' ';
  end;

  result := Format(SQL_RETORNA_MUDOU_VARA, [sSelect, sEsquema, sEsquema,
    quotedstr(psNuprocesso), sCondicao]);
end;

function RetornarCadastroContatoSql(psNuCPF: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_CADASTRO_CONTATO, [sEsquema, quotedstr(psNuCPF)]);
end;

function RetornarCdProcessoSql(psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_CDPROCESSO, [sEsquema, quotedstr(psNuprocesso + '%')]);
end;

function VerificarCadastroParteSql(psNuPessoa: string; psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_CADASTRO_PARTE, [sEsquema, sEsquema,
    quotedstr(psNuPessoa), sEsquema, quotedstr(psNuprocesso + '%')]);
end;

function RetornarMudouVagaSql(psCdVaga: string; psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_MUDOU_VAGA, [psCdVaga, sEsquema, sEsquema,
    quotedstr(psNuprocesso + '%')]);
end;

function RetornarRealmenteEncaminhouSql(psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_REALMENTE_ENCAMINHOU, [sEsquema, quotedstr(psNuprocesso + '%')]);
end;

function VerificarCadastroBemSql(psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_CADASTRO_BEM, [sEsquema, sEsquema, sEsquema,
    quotedstr(psNuprocesso)]);
end;

//function VerificarPeticaoExcepcionalInicialSql(psNuProtocolo: string): WideString;
//var
//  FospAplicacao: TspAplicacao;
//  sEsquema: string;
//begin
//  FospAplicacao := TspAplicacao.Create;
//  try
//    sEsquema := FospAplicacao.spEsquema + '.';
//  finally
//    result := Format(SQL_VERIFICA_PETICAO_EXCEPCIONAL_INICIAL,
//      [sEsquema, quotedstr(psNuProtocolo)]);
//    FreeAndNil(FospAplicacao);
//  end;
//end;

function VerificarPeticaoCadastradaSql(psNuprocesso, psNuClasseProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    result := Format(SQL_VERIFICA_PETICAO_CADASTRADA, [sEsquema, sEsquema,
      quotedstr(psNuprocesso), FoFuncoesSQL.DateTimeToDate('DTUSUINCLUSAO'),
      FoFuncoesSQL.DataAtualTruncada, psNuClasseProcesso]);
  finally
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarNumeroProcessoSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUMERO_PROCESSO,
      [sEsquema, FoFuncoesSQL.dthr('01/01/2015')]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

//function SqlChecarProtocoloDocumento(psNuprocesso: string; psNuProtocolo: string): WideString;
//var
//  FospAplicacao: TspAplicacao;
//  sEsquema: string;
//begin
//  FospAplicacao := TspAplicacao.Create;
//  try
//    sEsquema := FospAplicacao.spEsquema + '.';
//  finally
//    result := Format(SQL_CHECAR_PROTOCOLO_DOCUMENTO, [sEsquema, sEsquema,
//      quotedstr(psNuprocesso + '%'), psNuProtocolo]);
//    FreeAndNil(FospAplicacao);
//  end;
//end;

//function ChecarProtocoloSql(psNuProtocolo: string): WideString;
//var
//  FospAplicacao: TspAplicacao;
//  sEsquema: string;
//begin
//  FospAplicacao := TspAplicacao.Create;
//  try
//    sEsquema := FospAplicacao.spEsquema + '.';
//  finally
//    result := Format(SQL_CHECAR_PROTOCOLO, [sEsquema, quotedstr(psNuProtocolo)]);
//    FreeAndNil(FospAplicacao);
//  end;
//end;

function PropriedadesDocumentoSql(psNuProcesso: string; psCdDocumento: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_PROPRIEDADES_DOCUMENTO, [sEsquema, sEsquema, sEsquema,
    quotedstr(psNuProcesso), quotedstr(psCdDocumento)]);
end;

function VerificarPeticaoInicialSql(psNuProcesso: string; psTpSigilo: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERICAR_PETICAO_INICIAL, [sEsquema, quotedstr(psNuProcesso + '%'),
    quotedstr(psTpSigilo)]);
end;

{
Esse Aqui tem que ver como fazer
N�o est� sendo usado em nenhuma UNIT
verificar quem fez este SQL
function RETORNAR_NOME_PARTE_EXISTE(psNomePessoa: string): WideString;
var
  FospAplicacao: TspAplicacao;
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FospAplicacao := TspAplicacao.Create;
  try
    sEsquema := FospAplicacao.spEsquema + '.';
  finally
    result := Format(SQL_RETORNAR_NOME_PARTE_EXISTE, [sEsquema, quotedstr(psNuProcesso + '%'), quotedstr(psTpSigilo)]);
    FreeAndNil(FospAplicacao);
    FreeAndNil(FoFuncoesSQL);
  end;
end;


}

function RetornarProcessoMovUnitariaSql(psNomePessoa: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNAR_PROCESSO_MOV_UNITARIA,
      [sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMovUnitariaSql(psTpMovimentacao, psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_MOV_UNITARIA, [sEsquema, sEsquema,
    quotedstr(psTpMovimentacao), quotedstr(psTpMovimentacao), sEsquema,
    quotedstr(psNuProcesso + '%')]);
end;

// 26/05/2015 - MURILO.CRISTIANO - SALT: 186660/2/2
//SQL_RETORNA_QTDE_REGISTRO_PAUTA_AUD_TABELADO =
//  'SELECT COUNT(1) QTDE                                                                                              ' + #13 +      Esse SQL n�o foi localizado
//  '  FROM EGGPAUDIENCIA EPA                                                                                          ' + #13 +      em lugar nenhum
//  ' WHERE TO_DATE(EPA.DTINICIO, ''DD/MM/YYYY'') BETWEEN TO_DATE(%S, ''DD/MM/YYYY'') AND TO_DATE(%S, ''DD/MM/YYYY'')  ';

function VerificarAssuntoInseridoSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_ASSUNTO_INSERIDO, [sEsquema, sEsquema,
    quotedstr(psNuProcesso + '%')]);
end;

function VerificarApensamentoSql(psCdProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_APENSAMENTO, [sEsquema, quotedstr(psCdProcesso), sEsquema]);
end;

function VerificarNuProcessoSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_NUPROCESSO, [sEsquema, quotedstr(psNuProcesso + '%')]);
end;

function RetornarProcessosMovimentacoesLoteSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNAR_PROCESSOS_MOVIMENTACOES_LOTE,
      [sEsquema, sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerifcarMovimetacoesLoteSql(psNuProcessos: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_CHECAR_MOVIMENTACOES_LANCADAS_EM_LOTE, [sEsquema, sEsquema, psNuProcessos]);
end;

//05/12/2015 - leandro.humbert
function VerifcarExclusaoMovimetacaoSql(psCdProcesso: string): WideString;
var
  sEsquema: string;
  FoFuncoesSQL: TspFuncoesSQL;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_EXCLUSAO_MOVIMENTACAO,
      [sEsquema, QuotedStr(psCdProcesso), FoFuncoesSQL.DateTimeToDate('EPM.DTEXCLUSAO'),
      FoFuncoesSQL.DataAtualTruncada, sEsquema, FoFuncoesSQL.DateTimeToDate('DTEXCLUSAO'),
      FoFuncoesSQL.DataAtualTruncada]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoEmissaoDocDtAlteradaSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_EMISSAO_DOC_DTALTERADA,
      [sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarDtMovDocumentoSql(psNuprocesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_DTMOV_DOCUMENTO, [sEsquema, sEsquema,
      quotedstr(psNuProcesso + '%'), FoFuncoesSQL.DateTimeToDate('PROMV.DTULTALTERACAO'),
      FoFuncoesSQL.DataAtualTruncada]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarPeticaoIntermdiariaSql(psNuprocesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_PETICAO_INTERMEDIARIA,
      [sEsquema, quotedstr(psNuProcesso + '%'), FoFuncoesSQL.DateTimeToDate('DTRECEBIMENTO'),
      FoFuncoesSQL.DataAtualTruncada]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoNaoFinalizadoSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUPROCESSO_NAOFINALIZADO,
      [sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerifcarRecadoInseridoSql(psCdUsuarioDestino, psDeRecado: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_RECADO_INSERIDO, [sEsquema, quotedstr(psCdUsuarioDestino),
    quotedstr(psDeRecado)]);
end;

function VerifcarAutoTextoSql(psCdUsuario, psNmAbrevAutoTexto, psCdGrupo: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_AUTOTEXTO, [sEsquema, sEsquema, quotedstr(psCdUsuario),
    quotedstr(psNmAbrevAutoTexto), psCdGrupo]);
end;

function RetornarProcessoApreensaoSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUPROCESSO_FISICO_APREENSAO,
      [sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarProcessoFisicoApreensaoSql(psNuProcesso, psCdCategoriaBem: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_NUPROCESSO_FISICO_APREENSAO,
      [sEsquema, sEsquema, quotedstr(psNuProcesso + '%'),
      FoFuncoesSQL.DateTimeToDate('EB.DTENTRADA'),
      FoFuncoesSQL.DataAtualTruncada, psCdCategoriaBem]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoEdicaoDocSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUPROCESSO_EDICAO_DOC,
      [FoFuncoesSQL.substring('NUPROCESSO', 1, 13), sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerifcarpeticaoDiversaSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_PETICAO_DIVERSA, [sEsquema, sEsquema, sEsquema,
    sEsquema, quotedstr(psNuProcesso + '%')]);
end;

function RetornarProcessoBemSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_PROCESSO_BEM, [sEsquema, sEsquema, quotedstr(psNuProcesso + '%')]);
end;

function RetornarDocEmitidoSql(psCategoria, psModelo, psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNA_DOC_EMITIDO,
      [sEsquema, FoFuncoesSQL.DateTimeToDate('EDOC.DTFINALIZACAO'),
      FoFuncoesSQL.DataAtualTruncada, quotedstr(psCategoria), quotedstr(psModelo),
      sEsquema, quotedstr(psNuProcesso + '%')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerifcarCadastroProcessoProtocoloSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_CADASTRO_PROCESSO_PROTOCOLO, [sEsquema, psNuProcesso, sEsquema]);
end;

function VerifcarAlteracaoDadosPessoaSql(psNmPessoa, psDeOrgaoExp: string): WideString;
var
  FospAplicacao: TspAplicacao;
  sEsquema: string;
begin
  FospAplicacao := TspAplicacao.Create;
  try
    sEsquema := FospAplicacao.spEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_ALTERACAO_DADOS_PESSOA, [sEsquema, psNmPessoa, psDeOrgaoExp]);
    FreeAndNil(FospAplicacao);
  end;
end;

function VerificarDistribuicaoProcessosSql(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_DISTRIBUICAO_PROCESSOS,
      [sEsquema, FoFuncoesSQL.DateTimeToDate('EPM.DTMOVIMENTO'), FoFuncoesSQL.DataAtualTruncada,
      sEsquema, psNuProcesso]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoAlteracaoSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_ALTERACAO, [sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarNomeDocSql(psNuProcesso, psCategoria, psModelo: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_NOME_DOC, [sEsquema, quotedstr(psNuProcesso),
    quotedstr(psCategoria), quotedstr(psModelo)]);
end;

function RetornarProcessoExpedienteFinalSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUPROCESSO_VIRTUAL_EXPEDIENTE_FINAL,
      [sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarProcessoLiberadoAutosSql(psNuProcesso, psCdCategoria, psCdModelo: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_PROCESSO_LIBERADO_AUTOS, [sEsquema, sEsquema,
      Quotedstr(psNuProcesso), FoFuncoesSQL.DateTimeToDate('DTFINALIZACAO'),
      FoFuncoesSQL.DataAtualTruncada, Quotedstr(psCdCategoria), Quotedstr(psCdModelo)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarCorrecaoClasseSql(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNA_CORRECAO_CLASSE, [sEsquema, sEsquema, sEsquema,
      Quotedstr(psNuProcesso + '%'), FoFuncoesSQL.DateTimeToDate('EHC1.DTMUDANCA'),
      FoFuncoesSQL.DataAtualTruncada]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoSimplesSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUPROCESSO_SIMPLES,
      [sEsquema, sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoDocumentoCompartilharSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_DOCUMENTO_COMPARTILHAR,
      [FoFuncoesSQL.substring('PRO.NUPROCESSO', 1, 13), sEsquema, sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarExisteProcessoDistribuicaoSql(psData, psCDForo, psCDTipoCartorio: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_EXISTE_PROCESSO_DISTRIBUICAO,
      [sEsquema, sEsquema, sEsquema, sEsquema, sEsquema, sEsquema, sEsquema,
      FoFuncoesSQL.DtHr(psData), FoFuncoesSQL.DtHr(psData), QuotedStr(psCDForo),
      QuotedStr(psCDTipoCartorio)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarEncaminhamentoSql(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_ENCAMINHAMENTO, [sEsquema, QuotedStr(psNuProcesso + '%'),
      FoFuncoesSQL.DateTimeToDate('DTMOVIMENTO'), FoFuncoesSQL.DataAtualTruncada,
      sEsquema, QuotedStr(psNuProcesso + '%'), FoFuncoesSQL.DateTimeToDate('DTMOVIMENTO'),
      FoFuncoesSQL.DataAtualTruncada]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarDocumentoProcessoSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_EXISTE_DOCUMENTO_PROCESSO, [sEsquema, sEsquema, sEsquema,
    quotedstr(psNuProcesso)]);
end;

function RetornarProcessoDistribuidoSemPendenciaSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_DISTRIBUIDO_SEM_PENDENCIA,
      [FoFuncoesSQL.substring('EP.NUPROCESSO', 1, 13), sEsquema, sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoLocalFisicoSql(psCdForo: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_NUMERO_PROCESSO_LOCAL_FISICO,
      [FoFuncoesSQL.substring('EP.NUPROCESSO', 1, 13), sEsquema, sEsquema,
      sEsquema, psCdForo]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;


function RetornarProcessoVisualizaDocSql: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_VISUALIZA_DOCUMENTO,
      [FoFuncoesSQL.substring('P.NUPROCESSO', 1, 13), sEsquema, sEsquema, sEsquema, sEsquema]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoVirtualizadoSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNAR_PROCESSO_VIRTUALIZADO, [sEsquema, quotedstr(psNuProcesso + '%')]);
end;

function VerificarProcessoDependenteSql(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_PROCESSO_DEPENDENTE, [sEsquema, quotedstr(psNuProcesso + '%')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarPeticaoIntermediariaSql(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_PROCESSO_DEPENDENTE, [sEsquema, quotedstr(psNuProcesso + '%')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarDistribuicaoProcessoSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_DISTRIBUICAO_PROCESSO, [sEsquema, sEsquema,
    sEsquema, quotedstr(psNuProcesso + '%')]);
end;

function VerificarProcessoFisicoSql(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_PROCESSO_FISICO, [sEsquema, sEsquema,
    quotedstr(psNuProcesso + '%')]);
end;

function VerificarProcessoRemetidoSql(psNuLote, psNuProcesso, psTpLocalDestino: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_PROCESSO_REMETIDO, [sEsquema, sEsquema, sEsquema,
    quotedstr(psNuLote), quotedstr(psNuProcesso + '%'), quotedstr(psTpLocalDestino)]);
end;

function VerificarProcessoRecebidoSql(psNuLote, psNuProcesso, psTpLocalDestino: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_PROCESSO_RECEBIDO, [sEsquema, sEsquema, sEsquema,
      FoFuncoesSQL.DateTimeToDate('EC.DTRECEBIMENTO'), FoFuncoesSQL.DataAtualTruncada,
      quotedstr(psNuLote), quotedstr(psNuProcesso + '%'), quotedstr(psTpLocalDestino)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMovimentacaoProcessoSql(psNuProcesso, psCDTipoMVProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_MOVIMENTACAO_PROCESSO, [sEsquema, sEsquema,
      sEsquema, quotedstr(psNuProcesso + '%'), quotedstr(psCDTipoMVProcesso),
      FoFuncoesSQL.DateTimeToDate('EPM.DTMOVIMENTO'), FoFuncoesSQL.DataAtualTruncada]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMandadoEmetidoSql(psCDCategoria, psCDModelo, psNuprocesso,
  psCDAssuntoPrinc: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_MANDADO_EMITIDO, [sEsquema, sEsquema,
    quotedstr(psCDCategoria), quotedstr(psCDModelo), quotedstr(psNuProcesso + '%'),
    quotedstr(psCDAssuntoPrinc)]);
end;

function VerificarMandadoCriadoSql(psCDModelo, psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_MANDADO_CRIADO, [sEsquema, sEsquema,
    quotedstr(psCDModelo), quotedstr(psNuProcesso + '%')]);
end;

function VerificarIntimacaoEmitidaSql(psCDCategoria, psCDModelo, psNuprocesso,
  psCDAssuntoPrinc: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_INTIMACAO_EMITIDA, [sEsquema, sEsquema,
    quotedstr(psCDCategoria), quotedstr(psCDModelo), quotedstr(psNuProcesso + '%'),
    quotedstr(psCDAssuntoPrinc)]);
end;

function VerificarIntimacaoCriadaSql(psCDModelo, psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_INTIMACAO_CRIADA, [sEsquema, sEsquema,
    quotedstr(psCDModelo), quotedstr(psNuProcesso + '%')]);
end;

function RetornaProcessoDemonsDistribSql(pscdForo: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_DEMONS_DISTRIB,
      [FoFuncoesSQL.substring('EPROC.NUPROCESSO', 1, 13), sEsquema, sEsquema,
      sEsquema, pscdForo]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarDataAudienciaSql(psCDVara, psCDSala: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_DATA_AUDIENCIA,
      [FoFuncoesSQL.DateFormatToStr('DTINICIO', 'DD/MM/YYYY') + ' DTAUDIENCIA',
      sEsquema, psCDVara, psCDSala]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMandadoRemetidoCMSql(psNuLote, psCDTipoLocalOrigemSQL,
  psCDTipoLocalDestinoSQL: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_MANDANDO_REMETIDO_CM, [sEsquema, sEsquema,
    sEsquema, sEsquema, sEsquema, quotedstr(psNuLote), quotedstr(psCDTipoLocalOrigemSQL),
    quotedstr(psCDTipoLocalDestinoSQL)]);
end;

function VerificarMandadoDistribuidoAgenteSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_MANDADO_DISTRIBUIDO_AGENTE,
      [sEsquema, sEsquema, sEsquema, sEsquema, quotedstr(psNuProcesso + '%'),
      quotedstr(psCDSituacaoMandadoSQL), quotedstr(psOficialJustica),
      FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'), FoFuncoesSQL.DateTimeToDate('DTOPERACAO'),
      quotedstr(psCDTipoOperacaoSQL), sEsquema]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMandadoAgenteSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_MANDADO_AGENTE, [sEsquema, sEsquema, sEsquema,
      sEsquema, quotedstr(psNuProcesso + '%'), quotedstr(psCDSituacaoMandadoSQL),
      quotedstr(psOficialJustica), FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'),
      FoFuncoesSQL.DateTimeToDate('DTOPERACAO'), quotedstr(psCDTipoOperacaoSQL), sEsquema]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarMandadoDistribuidoCentralSql(psNuprocesso, psCDSituacaoMandadoSQL,
  psOficialJustica, psCDTipoOperacaoSQL: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_MANDADO_DISTRIBUIDO_CENTRAL,
      [sEsquema, sEsquema, sEsquema, sEsquema, quotedstr(psNuProcesso + '%'),
      quotedstr(psCDSituacaoMandadoSQL), quotedstr(psOficialJustica),
      FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'), FoFuncoesSQL.DateTimeToDate('DTOPERACAO'),
      quotedstr(psCDTipoOperacaoSQL), sEsquema]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function VerificarSituacaoMandadoSql(psNuprocesso, psSituacao, psOficialJustica,
  psCDTipoOperacaoSQL2: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_SITUACAO_MANDADO, [sEsquema, sEsquema, sEsquema,
      sEsquema, quotedstr(psNuProcesso + '%'), psSituacao, quotedstr(psOficialJustica),
      FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'), FoFuncoesSQL.DateTimeToDate('DTOPERACAO'),
      quotedstr(psCDTipoOperacaoSQL2), FoFuncoesSQL.DateTimeToDate('EDM.DTUSUINCLUSAO'),
      FoFuncoesSQL.DataAtualTruncada, sEsquema]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

//888888888888888888888888888888888888888888888888888888888888888888

function RetornaPublicaPessoa(psNuProcesso: string): WideString;  //Inserir modeltests
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_PUBLICAPESSOA, [sEsquema, QuotedStr(psNuProcesso),
      FoFuncoesSQL.DateTimeToDate('DTMOVIMENTO'), FoFuncoesSQL.DtHr(DateToStr(now))]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornaVerificaVincrecolMand(psNuProcesso, psNuMandado, psCdCalculoGRJ: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDatas: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDatas := ' and ' + FoFuncoesSQL.DateTimeToDate('DTUSUVINCVALOR') + ' = ' +
      FoFuncoesSQL.DtHr(DateToStr(now));
  finally

    result := Format(SQL_VERIFICA_VINCRECOLMAND, [sEsquema, sEsquema,
      QuotedStr(psNuProcesso), sEsquema, QuotedStr(psNuMandado), psCdCalculoGRJ, sDatas]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornaVerificaCancelamentoProcesso(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_CANCELAMENTO_PROCESSO, [sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornaValidarLocalRemessaPendente(psNuLote: string; psNuForo: string;
  psCdTipoLocalDestino: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VALIDA_LOCAL_REMESSA_PENDENTE, [sEsquema, QuotedStr(psNuLote),
    psNuForo, psCdTipoLocalDestino]);
end;

function RetornaVerificarStatusSigilo(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_STATUS_SIGILO, [sEsquema, sEsquema, sEsquema,
    QuotedStr(psNuProcesso)]);
end;

function RetornaVerificarExistenciaLote(psNuLote: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_EXISTENCIA_LOTE, [sEsquema, QuotedStr(psNuLote)]);
end;

function RetornaDigDocumento(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_DIGDOCUMENTO, [sEsquema, sEsquema, sEsquema,
    QuotedStr(psNuProcesso)]);
end;

function RetornaCdMandado(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_CDMANDADO, [sEsquema, sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornaVerificarDadosMandadoRedistribuido(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_DADOS_MANDADO_REDISTRIBUIDO,
    [sEsquema, sEsquema, sEsquema, sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornaVerificarAgenteMandadoDistribuido(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_AGENTE_MANDADO_DISTRIBUIDO,
    [sEsquema, sEsquema, sEsquema, QuotedStr(psNuProcesso + '%'), sEsquema]);
end;

function RetornaAgenteDocEmitido(pscdDocumento: string; psCdProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_AGENTE_DOC_EMITIDO, [sEsquema, sEsquema,
    QuotedStr(pScdDocumento), QuotedStr(psCdProcesso)]);
end;

function RetornaVerificarTransferenciaMandado(psNuProcesso: string;
  psCdAgente: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_TRANFERENCIA_MANDADO, [sEsquema, sEsquema,
    QuotedStr(psNuProcesso + '%'), psCdAgente]);
end;

function RetornaCdUsuarioAgente(psNomeAgente: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_USUARIO_AGENTE, [sEsquema, quotedstr(psNomeAgente + '%')]);
end;

function RetornarIncluirAgente2(psData: string; psCdForo: string; psCdZona: string;
  psNuVaga: string; psCdAgente: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_INCLUIR_AGENTE_2, [sEsquema, FoFuncoesSQL.DtHr(psData),
      quotedstr(psCdForo), quotedstr(psCdZona), quotedstr(psNuVaga), quotedstr(psCdAgente)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarAfastarAgente2(psData: string; psCdForo: string; psCdZona: string;
  psNuVaga: string; psCdAgente: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_AFASTAR_AGENTE_2, [sEsquema, FoFuncoesSQL.DtHr(psData),
      quotedstr(psCdForo), quotedstr(psCdZona), quotedstr(psNuVaga), quotedstr(psCdAgente)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarIncluirAgente(psData: string; psNuVaga: string; psCdAgente: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_INCLUIR_AGENTE, [sEsquema, FoFuncoesSQL.DtHr(psData),
      quotedstr(psCdAgente), quotedstr(psNuVaga)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarAfastarAgente(psData: string; psNuVaga: string; psCdAgente: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_AFASTAR_AGENTE, [sEsquema, FoFuncoesSQL.DtHr(psData),
      quotedstr(psCdAgente), quotedstr(psNuVaga)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarUltimaMovimentacaoFluxo(psNuMandado: string): WideString;
var
  FospAplicacao: TspAplicacao;
  sEsquema: string;
begin
  FospAplicacao := TspAplicacao.Create;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNA_ULTIMA_MOV_FLUXO, [sEsquema, sEsquema, quotedstr(psNuMandado)]);
    FreeAndNil(FospAplicacao);
  end;
end;

function RetornarSituacaoMandadoAtualizadoNaoDistribuido(psNuMandado: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_SITUACAO_MANDADO_ATUALIZADO_NAO_DIST,
    [sEsquema, quotedstr(psNuMandado)]);
end;

function RetornarSituacaoMandadoAtualizado(psNuMandado: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_SITUACAO_MANDADO_ATUALIZADO, [sEsquema, sEsquema,
    quotedstr(psNuMandado)]);
end;

function RetornarVerificarRecebimentoNumeroLote(psNuLote: string; psCdForo: string;
  psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_RECEBIMENTO_NULOTE, [sEsquema, quotedstr(psNuLote),
    psCdForo, sEsquema, QuotedStr(psNuProcesso + '%')]);
end;


function RetornarVerificarCargaRemetidaLote(psNuLote: string;
  psCdTipoLocalDestino: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_CARGA_REMETIDA_LOTE, [sEsquema, sEsquema,
    quotedstr(psNuLote), psCdTipoLocalDestino]);
end;

function RetornarGRJ(psCdForo: string; psNuGrjEmitida: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_GRJ, [sEsquema, psCdForo, quotedstr(psNuGrjEmitida)]);
end;

function RetornarDistribuicaoMandado(psCdTipoDistMand: string; psCdAgente: string;
  psNuMandado: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_DISTRIBUICAO_MANDADO, [sEsquema, sEsquema,
    psCdTipoDistMand, psCdAgente, QuotedStr(psNuMandado)]);
end;

function RetornarAtualizarDtCumprimentoDtVenctoPrazo(psDataVenctoPrazo: string;
  psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_ALTERA_DTCUMPRIMENTO_DTVENCTOPRAZO,
      [sEsquema, FoFuncoesSQL.DtHr(psDataVenctoPrazo), QuotedStr(psNuProcesso + '%')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarProcessoNovoDesmembrado(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_PROCESSO_NOVO_DESMEMBRADO, [sEsquema, sEsquema,
    sEsquema, sEsquema, sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornarVerificarEmailRecebido(psNmParte: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_EMAIL_RECEBIDO, [sEsquema, QuotedStr(psNmParte)]);
end;

function RetornarVerificarOficioImpresso(psDeOperacao: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_OFICIO_IMPRESSO, [sEsquema, QuotedStr(psDeOperacao + '%')]);
end;

function RetornarVerificarProcessoUnificado(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDados := FoFuncoesSQL.DateTimeToDate('EPA.DTAPENSAMENTO') + ' = ' +
      FoFuncoesSQL.DtHr(DateToStr(now));
  finally
    result := Format(SQL_VERIFICA_PROCESSO_UNIFICADO, [sEsquema, sEsquema, sEsquema,
      sDados, QuotedStr(psNuProcesso + '%')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarTesteConsultaAutos(psNuProcesso: string; psAnotacao: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    //30/11/2015 - Shirleano.Junior - SALT: 186660/23/4
    sDados := FoFuncoesSQL.posicao('UPPER(' + QuotedStr(psAnotacao) + ')',
      'UPPER(EAP.DEANOTACAO)');
  finally
    result := Format(SQL_VERIFICACAO_TESTE_CONSULTA_AUTOS, [sEsquema, sEsquema,
      sEsquema, sEsquema, sDados, sEsquema, sEsquema, sEsquema, sEsquema,
      QuotedStr(psNuProcesso)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarCancelamentoJuntada(psCdProcessoApenso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_CANCELAMENTO_JUNTADA,
    [sEsquema, QuotedStr(psCdProcessoApenso), sEsquema]);
end;

function RetornarPeticaoSalva(psNuProcesso: string; psDeClasse: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_PETICAO_SALVA, [sEsquema, sEsquema, QuotedStr(psNuProcesso + '%'),
    QuotedStr(psDeClasse)]);
end;

function RetornarVerificarCopiaPartes(psNuProcesso: string; psDeClasse: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDados := FoFuncoesSQL.Decode('SUM(PTATIVACONTESTACAO)', ['SUM(PTATIVA)', '1', '0']) +
      ' + ' + FoFuncoesSQL.Decode('SUM(PTPASSIVACONTESTACAO)', ['SUM(PTPASSIVA)', '1', '0']);
  finally
    result := Format(SQL_VERICAR_COPIA_PARTES, [sDados, sEsquema, sEsquema,
      QuotedStr(psNuProcesso + '%'), QuotedStr(psDeClasse), sEsquema, sEsquema,
      QuotedStr(psNuProcesso + '%'), QuotedStr(psDeClasse)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarJuntadaProcessoDependente(psNuProcesso: string;
  psCdTipoMvProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNAR_JUNTADA_PROCESSO_DEPENDENTE,
    [sEsquema, sEsquema, QuotedStr(psNuProcesso + '%'), sEsquema, psCdTipoMvProcesso]);
end;

function RetornarVerificarCertidaoEmitida(psCdSituacao: string; psNuPedido: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDados := FoFuncoesSQL.DateTimeToDate('EPL.DTCERTIDAO') + ' = ' +
      FoFuncoesSQL.DtHr(DateToStr(now));
  finally
    result := Format(SQL_VERIFICAR_CERTIDAO_EMITIDA, [sEsquema, sEsquema, sDados,
      psCdSituacao, psNuPedido]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVaraDoProcesso(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_VARA_PROCESSO, [sEsquema, QuotedStr(psNuProcesso)]);
end;

function RetornarLiberouDocumentoAutos(psCdDocumentoEdt: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_LIBEROU_DOCUMENTO_AUTOS, [sEsquema, sEsquema, QuotedStr(psCdDocumentoEdt)]);
end;

function RetornarNuProcessoCompleto(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_NUPROCESSO_COMPLETO, [sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornarDocumentoEmitdoGGP(psCdDocumento: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_DOC_EMITIDO_GGP, [sEsquema, QuotedStr(psCdDocumento)]);
end;

function RetornarDocumentoEmitdo2(psCdDocumento: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_DOC_EMITIDO_2, [sEsquema, QuotedStr(psCdDocumento)]);
end;

function RetornarVerificarHistoricoParte(psNuProcesso: string; psQtde: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_VERIFICAR_HISTORICO_PARTE, [sEsquema, sEsquema, sEsquema,
      QuotedStr(psNuProcesso + '%')]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, StrToInt(psQtde), '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarParteIndiciado(psNmPessoa: string; psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_PARTE_INDICIADO, [sEsquema, sEsquema, sEsquema,
    QuotedStr(psNmPessoa + '%'), QuotedStr(psNuProcesso + '%')]);
end;

function RetornarVerificarObservacaoDocumento(psCdDocumnento: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_OBSERVACAO_DOCUMENTO, [sEsquema, QuotedStr(psCdDocumnento)]);
end;

function RetornarVerificarObservacaoProcessoFluxoTrabalho(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_OBSERVACAO_PROCESSO_FLUXO_TRABALHO,
    [sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornarVerificarDevolucaoAR(psCdARTJ: string; psCdTipoEstadoAR: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_DEVOLUCAO_AR, [sEsquema, sEsquema, QuotedStr(psCdARTJ),
    psCdTipoEstadoAR]);
end;

function RetornarVerificarARAguardandoJuntada(psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_AR_AGUARDANDO_JUNTADA, [sEsquema, sEsquema,
    QuotedStr(psCdARTJ), psCdTipoEstadoAR]);
end;

function RetornarVerificarARJuntadaProcesso(psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_AR_JUNTADA_PROCESSO, [sEsquema, sEsquema,
    QuotedStr(psCdARTJ), psCdTipoEstadoAR]);
end;

function RetornarPeticaoMarcadaSigiloConsulta(psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNA_PETICAO_MARCADA_SIGILO_CONSULTA,
      [sEsquema, sEsquema, sEsquema, sEsquema, QuotedStr(psNuProcesso + '%'),
      FoFuncoesSQL.DateTimeToDate('EPA.DTAPENSAMENTO'), FoFuncoesSQL.DataAtualTruncada, sEsquema]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;


function RetornarVerificarParcelasMulta(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_PARCELAS_MULTA, [sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornarMovimentacaoCategoria(psCdCategoria: string;
  psCdTipoMvProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_MOVIMENTCAOCATEGORIA,
    [sEsquema, QuotedStr(psCdCategoria), QuotedStr(psCdTipoMvProcesso)]);
end;

function RetornarVerificarNumeroDocumentoAlterado(psCdARTJ: string;
  psCdTipoEstadoAR: string; psNuDocRecebedor: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_NUMERO_DOCUMENTO_ALTERADO, [sEsquema, sEsquema,
    QuotedStr(psCdARTJ), QuotedStr(psCdTipoEstadoAR), QuotedStr(psNuDocRecebedor)]);
end;

function RetornarRecebidoNoCartorio(psNuLote: string; psCdARTJ: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDados := FoFuncoesSQL.DateTimeToDate('EC.DTRECEBIMENTO') + ' = ' +
      FoFuncoesSQL.DtHr(DateToStr(now));
  finally
    result := Format(SQL_RECEBIDO_NO_CARTORIO, [sEsquema, sEsquema, sEsquema, sDados,
      QuotedStr(psNuLote), QuotedStr(psCdARTJ)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarARRemetido(psCdARTJ: string; psCdTipoEstadoAR: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_AR_REMETIDO, [sEsquema, sEsquema, QuotedStr(psCdARTJ),
    QuotedStr(psCdTipoEstadoAR)]);
end;

function RetornarVerificarSituacaoAR(psCdARTJ: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_SITUACAO_AR, [sEsquema, QuotedStr(psCdARTJ)]);
end;

function RetornarAlteraTipoEstadoAR(psCdARTJ: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_ALTERA_TIPO_ESTADO_AR, [sEsquema, QuotedStr(psCdARTJ)]);
end;

function RetornarArquivoMultiMidia(psNuProcesso: string; psNmArqMultiMidia: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_ARQUIVO_MULTIMIDIA, [sEsquema, sEsquema,
    QuotedStr(psNuProcesso), QuotedStr(psNmArqMultiMidia)]);
end;

function RetornarGerarGuiaPostagemAR(psCdForo: string; psCdARTJ: string;
  psCdTipoEstadoAR: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_GERA_GUIA_POSTAGEM_AR, [sEsquema, sEsquema, sEsquema,
    psCdForo, sEsquema, sEsquema, QuotedStr(psCdARTJ), psCdTipoEstadoAR]);
end;

function RetornarARRemetidoNaoRecebido(psNuLote: string; psCdARTJ: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_AR_REMETIDO_NAO_RECEBIDO, [sEsquema, sEsquema, sEsquema,
    QuotedStr(psNuLote), sEsquema, QuotedStr(psCdARTJ)]);
end;

function RetornarCopiaFila(psCdFila: string; psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_COPIA_FILA, [sEsquema, sEsquema, psCdFila, sEsquema,
    QuotedStr(psNuProcesso + '%'), sEsquema, sEsquema]);
end;

function RetornarVerificarAudienciaCancelada(psCdAudiencia: string;
  psCdSituacaoAudi: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_AUDIENCIA_CANCELADA, [sEsquema, psCdAudiencia, psCdSituacaoAudi]);
end;


function RetornarVerificarAlteracaoPautaAudienciaBloco(psCdSala: string;
  psCdVara: string; psCdTipoAudiencia: string; psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDataInicio: string;
  sDataFim: string;
  sHorarioInicio: string;
  sHorarioFim: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDataInicio := FoFuncoesSQL.DateFormatToStr('AUD.DTINICIO', 'DDMMYYYY');
    sDataFim := FoFuncoesSQL.DateFormatToStr('AUD.DTFIM', 'DDMMYYYY');
    sHorarioInicio := FoFuncoesSQL.DateTimeToTime('AUD.DTINICIO');
    sHorarioFim := FoFuncoesSQL.DateTimeToTime('AUD.DTFIM');
  finally
    result := Format(SELECT_VERIFICA_ALTERACAO_PAUTA_AUDIENCIA_BLOCO,
      [sDataInicio, sDataFim, sHorarioInicio, sHorarioFim, sEsquema, sEsquema,
      psCdSala, psCdVara, psCdTipoAudiencia, QuotedStr(psNuProcesso + '%')]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarNuProcessoSemPendencia(pnQtdeLinhas: integer): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_RETORNA_NUPROCESSO_SEM_PENDENCIA, [sEsquema, sEsquema]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, pnQtdeLinhas, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarLocalProcessoFisico(psCdProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_LOCAL_PROCESSO_FISICO, [sEsquema, sEsquema,
    sEsquema, psCdProcesso, sEsquema]);
end;

function RetornarEnderecoCPF(psNuDocumento: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    if spDB.GetTipoBanco = uspDataBase.tbOracle then
      sDados := ' LPAD(PD.NUDOCUMENTO,11,''0'')';
    if spDB.GetTipoBanco = uspDataBase.tbDB2 then
      sDados := ' RIGHT(REPEAT(''0'', 11) || LTRIM(CHAR(PD.NUDOCUMENTO)), 11)';
    sSQL := Format(SQL_RETORNA_ENDERECO_CPF, [sEsquema, sEsquema, sDados,
      QuotedStr(psNuDocumento)]);
  finally
    result := sSQL;
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarProcessoCancelado(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_PROCESSO_CANCELADO, [sEsquema, QuotedStr(psNuProcesso + '%')]);
end;

function RetornarVerificarProcessoRegSentenca(psCdTipoMvProcesso: string;
  psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sDados := FoFuncoesSQL.DateTimeToDate('EPM.DTMOVIMENTO') + ' = ' +
      FoFuncoesSQL.DtHr(DateToStr(now));
    sSQL := Format(SQL_VERFICA_PROCESSO_REG_SENTENCA, [sEsquema, sEsquema, sDados,
      psCdTipoMvProcesso, QuotedStr(psNuProcesso + '%')]);
  finally
    result := sSQL;
    FreeAndNil(FoFuncoesSQL);
  end;
end;


function RetornarProcessoRegistroSentenca(psCdCategoria: string;
  pnQtdeLinhas: integer): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_RETORNA_PROCESSO_REG_SENTENCA,
      [FoFuncoesSQL.substring('P.NUPROCESSO', 1, 13), sEsquema, sEsquema, sEsquema,
      sEsquema, sEsquema, sEsquema, sEsquema, psCdCategoria, sEsquema, sEsquema]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, pnQtdeLinhas, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoConsProcBasica(pnQtdeLinhas: integer): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_RETORNA_PROCESSO_CONSPROCBASICA,
      [FoFuncoesSQL.substring('EP.NUPROCESSO', 1, 13), sEsquema, sEsquema]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, pnQtdeLinhas, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarIncluirUsuarioNet(psCdPessoa: string; psCdUsuarioNet: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_INCLUI_USUARIO_NET, [sEsquema, psCdPessoa, psCdUsuarioNet]);
end;

function RetornarRelCalculoIdade(psCdVara: string; pnQtdeLinhas: integer): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_RETORNA_REL_CALCULO_IDADE,
      [FoFuncoesSQL.substring('EPROC.NUPROCESSO', 1, 13), sEsquema, psCdVara, sEsquema, sEsquema]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, pnQtdeLinhas, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoRelExtrato(pnQtdeLinhas: integer;
  psCdForo, psCDVara, psCdUltimMv: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_RETORNA_PROCESSO_REL_EXTRATO,
      [FoFuncoesSQL.substring('EPROC.NUPROCESSO', 1, 13), sEsquema, sEsquema,
      sEsquema, psCdForo, psCDVara, psCdUltimMv]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, pnQtdeLinhas, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarMandadoDevolvidoCartorio(psNuLote: string;
  psCdTipoLocalOrigem: string; psCdTipoLocalDestino: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_MANDADO_DEVOLVIDO_CARTORIO,
    [sEsquema, sEsquema, sEsquema, sEsquema, sEsquema, QuotedStr(psNuLote),
    QuotedStr(psCdTipoLocalOrigem), QuotedStr(psCdTipoLocalDestino)]);
end;

function RetornarVerificarDevolvicaoMandadoCartorio(psNuLote: string;
  psCdTipoLocalOrigem: string; psCdTipoLocalDestino: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_DEVOLUCAO_MANDADO_CARTORIO,
    [sEsquema, sEsquema, sEsquema, sEsquema, sEsquema, QuotedStr(psNuLote),
    QuotedStr(psCdTipoLocalOrigem), QuotedStr(psCdTipoLocalDestino)]);
end;

function RetornarSenhaGerada(psCdProcesso: string; psNmOutroInteressado: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_SENHA_GERADA, [sEsquema, sEsquema, sEsquema,
    QuotedStr(psCdProcesso), QuotedStr(psNmOutroInteressado)]);
end;


function RetornaVerificacaoSentenca(psTipoMvProcesso: string; psNuProcesso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sDataUltAlteracao: string;
  sDataRegistro: string;
  sDataMovimento: string;
  sSQL: string;
  oData: TDateTime;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  oData := spDB.DataAtual;
  try
    sEsquema := spDB.GetEsquema + '.';
    if spDB.GetTipoBanco = uspDataBase.tbOracle then
    begin
      sDataUltAlteracao := FoFuncoesSQL.DateTimeToDate('EDE.DTULTALTERACAO') + ' = ' +
        FoFuncoesSQL.DtHr(DateToStr(oData)) + ')';
      sDataRegistro := FoFuncoesSQL.DateTimeToDate('ERS.DTREGISTRO') + ' = ' +
        FoFuncoesSQL.DtHr(DateToStr(oData)) + ')';
      sDataMovimento := FoFuncoesSQL.DateTimeToDate('EPA.DTMOVIMENTO') + ' = ' +
        FoFuncoesSQL.DtHr(DateToStr(oData));
    end;


    if spDB.GetTipoBanco = uspDataBase.tbDB2 then
    begin
      sDataUltAlteracao := ' Date(EDE.DTULTALTERACAO) = DATE(CURRENT_DATE))';
      sDataRegistro := ' Date(ERS.DTREGISTRO) = DATE(CURRENT_DATE))';
      sDataMovimento := ' Date(EPA.DTMOVIMENTO) = DATE(CURRENT_DATE)';
    end;
    sSQL := Format(SQL_VERIFICAR_SENTENCA, [sEsquema, sEsquema, sDataUltAlteracao,
      sEsquema, sDataRegistro, psTipoMvProcesso, sDataMovimento, sEsquema,
      QuotedStr(psNuProcesso + '%'), sEsquema, sEsquema]);
  finally
    result := sSQL;
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarSituacaoMandado(psCdSituacaoMandado: string; psNuMandado: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_SITUACAO_MANDADO, [sEsquema, sEsquema,
    psCdSituacaoMandado, QuotedStr(psNuMandado)]);
end;

function RetornarVerificarVinculacaoAgenteVara(psCdForo: string; psCdLocal: string;
  psCdAgente: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICAR_VICULACAO_AGENTE_VARA, [sEsquema, psCdForo,
    psCdLocal, psCdAgente]);
end;

function RetornarVerificarEntranhamento(psCdTipoMvProcesso: string; psData: string;
  psCdProcesso: string; psCdProcessoApenso: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_ENTRANHAMENTO, [sEsquema, sEsquema, sEsquema,
      QuotedStr(psCdTipoMvProcesso), psData, FoFuncoesSQL.DtHr(DateToStr(now)),
      QuotedStr(psCdProcesso), QuotedStr(psCdProcessoApenso)]);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarParteUsuarioNet(psCdUsuarioNet: string; psDados: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
    sSQL := Format(SQL_RETORNA_PARTE_USUARIO_NET, [sEsquema, sEsquema, psCdUsuarioNet, psDados]);
  finally
    result := FoFuncoesSQL.FetchFirst(sSQL, 1, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarMandadoExcepcional(psCdModelo: string; psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_MANDADO_EXCEPCIONAL, [sEsquema, sEsquema,
    QuotedStr(psCdModelo), QuotedStr(psNuProcesso + '%')]);
end;

function RetornarProcessoDocumentoAssinado: WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
  sSQL: string;
  sDados: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    sSQL := Format(SQL_RETORNA_PROCESSO_DOCUMENTO_ASSINADO, [sEsquema, sEsquema, sDados]);
    result := FoFuncoesSQL.FetchFirst(sSQL, 1, '');
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarProcessoRelAnaliticoSql(psCdForo, psCDVara, psCdUltimMv: string): WideString;
var
  FoFuncoesSQL: TspFuncoesSQL;
  sEsquema: string;
begin
  FoFuncoesSQL := TspFuncoesSQL.Create;
  FoFuncoesSQL.spTipoBanco := spDB.GetTipoBanco;
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := FoFuncoesSQL.FetchFirst(Format(SQL_RETORNA_PROCESSO_REL_ANALITICO,
      [FoFuncoesSQL.substring('EPROC.NUPROCESSO', 1, 13), sEsquema, sEsquema,
      sEsquema, psCdForo, psCDVara, psCdUltimMv]), 1);
    FreeAndNil(FoFuncoesSQL);
  end;
end;

function RetornarVerificarARGerada(psCdARTJ: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_AR_GERADA, [sEsquema, QuotedStr(psCdARTJ)]);
end;

function RetronaLotacaoUsuario(psCdAgente: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_RETORNA_LOTACAO_USUARIO, [sEsquema, QuotedStr(psCdAgente)]);
end;

//07/12/2015 - ANTONIO.SOUSA - SALT: 186660/23/1
function RetornarVerficarSituacaoProcesso(psSituacaoProcesso: string;
  psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  sEsquema := spDB.GetEsquema + '.';
  result := Format(SQL_VERIFICA_SITUACAO_PROCESSO, [sEsquema, QuotedStr(psSituacaoProcesso),
    QuotedStr(psNuProcesso)]);
end;

//09/12/2015 - ANTONIO.SOUSA - SALT: 186660/23/1
function RetornarVerficarSigiloProcessoSQL(psNuProcesso: string; psTipoSigilo: string): WideString;
var
  sEsquema: string;
begin
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_TIPO_SIGILO_PROCESSO_DEPENDENTE,
      [sEsquema, sEsquema, QuotedStr(psNuProcesso), QuotedStr(psTipoSigilo)]);
  end;
end;

//29/12/2015 - ANTONIO.SOUSA - SALT: 186660/23/1
function RetornarVerficarProcessoReativadoSQL(psNuProcesso: string): WideString;
var
  sEsquema: string;
begin
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_RETORNA_PROCESSO_REATIVADO, [sEsquema, QuotedStr(psNuProcesso)]);
  end;
end;

//28/01/2016 - ANTONIO.SOUSA - SALT: 186660/23/1
function VerificarJuntadaSql(psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICAR_JUNTADA, [sEsquema, sEsquema, QuotedStr(psNuprocesso)]);
  end;
end;

function VerificarForoProcessoSql(psNuprocesso: string; psCdForo: string): WideString;
var
  sEsquema: string;
begin
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_FORO_DESTINO, [sEsquema, QuotedStr(psNuprocesso), psCdForo]);
  end;
end;

//19/04/2016 - ANTONIO.SOUSA - SALT: 186660/23/1
function VerificarProcessoExcepcionalSql(psNuprocesso: string): WideString;
var
  sEsquema: string;
begin
  try
    sEsquema := spDB.GetEsquema + '.';
  finally
    result := Format(SQL_VERIFICA_PROCESSO_EXCEPCIONAL, [sEsquema, QuotedStr(psNuprocesso + '%')]);
  end;
end;

end.

