unit ufpgConstanteGUISQLTests;

interface

uses
  SysUtils;


const

//jcf:format=off

//Cadastro de Processo
VERIFICAR_PROCESSO_CADASTRADO =
  'SELECT COUNT(1) ACHOU  ' + #13 +
  '  FROM %SEFPGPROCESSO  ' + #13 +
  ' WHERE NUPROCESSO = %S ' + #13 +
  '   AND CDPROCESSO = %S ';

VERIFICAR_PROCESSO_CADASTRADO_SIGILO_ABSOLUTO =
  'SELECT COUNT(1) ACHOU                          ' + #13 +
  '  FROM %SEFPGPROCESSO P                        ' + #13 +
  '      -- %SEFPGUSUPROCSIGILO UP,               ' + #13 +
  ' WHERE P.CDPROCESSO = P.CDPROCESSO             ' + #13 +
  '   AND P.NUPROCESSO = %S                       ' ;
//  '  -- AND UP.CDUSUARIO LIKE %S                    ' ;

//Cadastro de Contato
SQL_RETORNA_CADASTRO_CONTATO =
  'SELECT COUNT(1) TOTAL  ' + #13 +
  '  FROM %SESAJPESSOADOC ' + #13 +
  ' WHERE NUDOCUMENTO = %s' ;

//Redistribui��o entre vaga
SQL_RETORNA_MUDOU_VAGA =
  'SELECT COUNT(1) ACHOU           ' + #13 +
  '  FROM %SEFPGDISTPROCESSO       ' + #13 +
  ' WHERE CDVARAVAGA = %S          ' + #13 +
  '   AND CDVAGA = %S              ' + #13 +
  '   AND CDPROCESSO = %S          ' + #13 +
  '   AND FLULTDISTRIBUICAO = ''S''';

VERIFICAR_ARMAS_BENS_CADASTRADO =
  'SELECT COUNT(1) ENCONTROU               ' + #13 +
  '  FROM %SEFPGBEM EB,                    ' + #13 +
  '       %SEFPGPROCESSO EP                ' + #13 +
  ' WHERE EP.CDPROCESSO = EB.CDPROCESSO    ' + #13 +
  '   AND EB.CDCATEGORIABEM = %S           ' + #13 +
  '   AND EB.DELOCALIZACAO = %S            ' + #13 +
  '   AND EP.NUPROCESSO =  %S              ';

VERIFICAR_OUTROS_NUMEROS_OBSERVACAO_CADASTRADO =
  '  SELECT COUNT(1) ENCONTROU                ' + #13 +
  '    FROM %SEFPGPROCESSO EP,                ' + #13 +
  '         %SEFPGOUTRONUMERO EN              ' + #13 +
  '   WHERE EP.CDPROCESSO = EN.CDPROCESSO     ' + #13 +
  '     AND EN.NUOUTRONUMERO = %S             ' + #13 +
  '     AND EN.DEOUTRONUMERO = %S             ' + #13 +
  '     AND EP.DEOBSERVACAO = %S              ' + #13 +
  '     AND EP.NUPROCESSO = %S                ';

//Redistribui��o entre vara
SQL_RETORNA_MUDOU_VARA =
  'SELECT COUNT(1) ACHOU           ' + #13 +
  '  FROM %SEFPGDISTPROCESSO       ' + #13 +
  ' WHERE CDVARAVAGA <> %S         ' + #13 +
  '   AND CDPROCESSO = %S          ' + #13 +
  '   AND FLULTDISTRIBUICAO = ''S''';

VERIFICAR_OUTRO_ASSUNTO_CADASTRADO =
  ' SELECT COUNT(1) ENCONTROU                      ' + #13 +
  '   FROM %SEFPGPROCESSOASSUNT EA,                ' + #13 +
  '        %SEFPGPROCESSO EP                       ' + #13 +
  '  WHERE EP.CDPROCESSO = EA.CDPROCESSO           ' + #13 +
  '    AND EA.CDASSUNTO = %S                       ' + #13 +
  '    AND EA.FLPRINCIPAL = %S                     ' + #13 +
  '    AND EA.FLETIQUETA = %S                      ' + #13 +
  '    AND EP.NUPROCESSO = %S                      ';

SQL_VERIFICAR_CADASTRO_PAUTA_AUDIENCIA =
  'SELECT COUNT(1) ENCONTROU                 ' + #13 +
  '  FROM %SEGGPAUDIENCIA EA,                ' + #13 +
  '       %SEFPGPROCESSO EP                  ' + #13 +
  ' WHERE EA.CDVARA = %S                     ' + #13 +
  '   AND EA.CDTIPOAUDIENCIA = %S            ' + #13 +
  '   AND EP.NUPROCESSO = %S                 ' + #13 +
  '   AND EA.CDPROCESSO = EP.CDPROCESSO      ';


RETORNA_PROCESSO_RETIFICACAO =
  'SELECT COUNT(1) ENCONTROU          ' + #13 +
  '  FROM %SEFPGPROCESSO              ' + #13 +
  ' WHERE FLPROCVIRTUAL = ''S''       ' + #13 +
  '  AND CDSITUACAOPROCESSO <> ''C''  ' + #13 +
  '  AND NUPROCESSO = %S              ';

SQL_RETORNA_PROCESSO =
  'SELECT P.NUPROCESSO                                     ' + #13 +
  '  FROM %SEFPGPROCESSO P                                 ' + #13 +
  ' where not EXISTS (select 1                             ' + #13 +
  '                     from %SESAJPENDENCIAPRAZO EPR      ' + #13 +
  '                    where EPR.CDPROCESSO = P.CDPROCESSO)' + #13 +
  '   AND FLPROCVIRTUAL = ''S''                            ' + #13 +
  '   %S ''C''                                             ' + #13 +
  '   AND P.DTRECEBIMENTO >= %S                            ';

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

SQL_VERIFICA_ENCAMINHOU_OUTRO_FORO =
  'SELECT COUNT(1) ACHOU            ' + #13 +
  '  FROM %SEFPGPROCESSO            ' + #13 +
  ' WHERE CDPROCESSO = %S           ' + #13 +
  '   AND CDFORODESTINO IS NOT NULL ' + #13 +
  '   AND CDFORODESTINO = %S        ';

SQL_VERIFICA_CANCELOU_ENCAMINHA_OUTRO_FORO =
  'SELECT COUNT(1) ACHOU            ' + #13 +
  '  FROM %SEFPGPROCESSO            ' + #13 +
  ' WHERE CDPROCESSO = %S           ' + #13 +
  '   AND CDFORODESTINO IS NULL     ';

SQL_VERIFICA_CADASTRO_BEM =
  'SELECT COUNT(1) TOTAL                                               ' + #13 +
  '  FROM %SEFPGBEM BEM                                                ' + #13 +
  '  LEFT JOIN %SEFPGITEMBEM ITEM ON (BEM.CDPROCESSO = ITEM.CDPROCESSO)' + #13 +
  ' WHERE EXISTS (SELECT 1                                             ' + #13 +
  '                 FROM %SEFPGPROCESSO                                ' + #13 +
  '                WHERE NUPROCESSO = %S                               ' + #13 +
  '                  AND CDPROCESSO = BEM.CDPROCESSO)                  ';

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


//LUCIANO.FAGUNDES - 27/10/2016
SQL_VERIFICAR_SITUACAO_PROCESSO =
  'SELECT CDSITUACAOPROCESSO       ' + #13 +
  '  FROM %SEFPGPROCESSO           ' + #13 +
  ' WHERE NUPROCESSO LIKE %S       ';

VERIFICAR_DESVINCULAR_DOCUMENTO =
'SELECT CDIMAGEM                                 ' + #13 +
'  FROM %SEEDTDOCEMITIDO                               ' + #13 +
' WHERE CDPROCESSO = (SELECT CDPROCESSO                ' + #13 +
'                       FROM EFPGPROCESSO              ' + #13 +
'                      WHERE NUPROCESSO LIKE %S)       ' ;

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

SQL_VERIFICAR_APENSAMENTO =
  'SELECT COUNT(1) TOTAL                             ' + #13  +
  '  FROM %SEFPGPROCESSOAPENSO EPA                   ' + #13  +
  ' WHERE EPA.CDPROCESSO = %S                        ' + #13  +
  '   AND EXISTS (SELECT 1                           ' + #13  +
  '                 FROM %SEFPGPROCESSO              ' + #13  +
  '                WHERE CDPROCESSO = EPA.CDPROCESSO ' + #13  +
  '                  AND CDSITUACAOPROCESSO <> ''C'')' ;
SQL_CHECAR_MOVIMENTACOES_LANCADAS_EM_LOTE =
  'SELECT COUNT(DISTINCT CDPROCESSO) AS CDPROCESSO ' + #13 +
  '  FROM %SEFPGPROCESSOMV EPM                     ' + #13 +
  ' WHERE EXISTS (SELECT 1                         ' + #13 +
  '                FROM %SEFPGPROCESSO             ' + #13 +
  '               WHERE CDPROCESSO = EPM.CDPROCESSO' + #13 +
  '                 AND CDSITUACAOPROCESSO <> ''C''' + #13 +
  '                 AND NUPROCESSO IN (%S))        ';

SQL_VERIFICA_RECADO_INSERIDO =
  'SELECT COUNT(1) TOTAL       ' + #13 +
  '  FROM %SESAJRECADO         ' + #13 +
  ' WHERE CDUSUARIODESTINO = %S' + #13 +
  '   AND FLEXCLUIDO = ''N''   ' + #13 +
  '   AND DERECADO = %S        ';

////23/06/2015 - ANTONIO.SOUSA - SALT: 186660/6/7
SQL_VERIFICA_AUTOTEXTO =
  'SELECT COUNT(1) TOTAL                          ' + #13 +
  '  FROM %SEEDTAUTOTEXTOGRUPO EATG,              ' + #13 +
  '       %SEEDTAUTOTEXTO EAT                     ' + #13 +
  ' WHERE EATG.NUSEQAUTOTEXTO = EAT.NUSEQAUTOTEXTO' + #13 +
  '   AND EATG.CDUSUARIO = EAT.CDUSUARIO          ' + #13 +
  '   AND EATG.CDUSUARIO = %S                     ' + #13 +
  '   AND EAT.NMABREVAUTOTEXTO = %S               ' + #13 +
  '   AND EATG.CDGRUPO = %S                       ';

SQL_VERIFICA_EXCLUSAO_MOVIMENTACAO =
  ' SELECT COUNT(1) TOTAL         ' + #13 +
  '   FROM EFPGPROCESSOMV EPM     ' + #13 +
  '  WHERE EPM.CDPROCESSO = %S    ' + #13 +
  '    AND DTEXCLUSAO like %S     ';

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
  '                  AND NUPROCESSO = %S)          ';

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

////LUCIANO.FAGUNDES  - 07/07/2015 - SALT: 186660/8/8
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

SQL_RETORNAR_PROCESSO_VIRTUALIZADO =
  'SELECT COUNT(1) TOTAL             ' + #13 +
  '  FROM %SEFPGPROCESSO             ' + #13 +
  ' WHERE CDSITUACAOPROCESSO <> ''C''' + #13 +
  '   AND FLPROCVIRTUAL = ''S''      ' + #13 +
  '   AND CDPROCESSO = %S            ';

SQL_RETORNAR_PROCESSO_MATERIALIZADO =
  'SELECT COUNT(1) TOTAL             ' + #13 +
  '  FROM %SEFPGPROCESSO             ' + #13 +
  ' WHERE CDSITUACAOPROCESSO <> ''C''' + #13 +
  '   AND FLPROCVIRTUAL = ''N''      ' + #13 +
  '   AND CDPROCESSO = %S            ';

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

SQL_VERIFICAR_MANDADO_DEVOLVIDO_CARTORIO =         
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

SQL_RETORNA_PROCESSO_CONSPROCBASICA =             
  'SELECT %S NUPROCESSO                    ' + #13 +
  '  FROM %SESMDMANDADO EM,                ' + #13 +
  '       %SEFPGPROCESSO EP                ' + #13 +
  ' WHERE EM.CDPROCESSO = EP.CDPROCESSO    ';

SQL_RETORNA_PROCESSO_REG_SENTENCA =                                           
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

SQL_VERFICA_PROCESSO_REG_SENTENCA =         
  'SELECT COUNT(1) VERIFICA              ' + #13 +
  '  FROM %SEFPGPROCESSOMV EPM,          ' + #13 +
  '       %SEFPGPROCESSO EP              ' + #13 +
  ' WHERE EPM.CDPROCESSO = EP.CDPROCESSO ' + #13 +
  '   AND %S                             ' + #13 +
  '   AND EPM.CDTIPOMVPROCESSO = %S      ' + #13 +
  '   AND EP.NUPROCESSO LIKE %S          ' ;

SQL_VERIFICAR_LOCAL_PROCESSO_FISICO =                                    
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

SQL_RETORNA_COPIA_FILA =                                
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

SQL_GERA_GUIA_POSTAGEM_AR =                                            
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

SQL_VERIFICA_AR_GERADA =
  'SELECT COUNT(1) TOTAL ' + #13 +
  '  FROM %SESARAR       ' + #13 +
  ' WHERE CDARTJ = %S    ';

SQL_VERIFICA_AR_REMETIDO =                              
  'SELECT COUNT(1) TOTAL                         ' + #13 +
  '  FROM %SESARAR EA,                           ' + #13 +
  '       %SESARTIPOESTADOAR EATE                ' + #13 +
  ' WHERE EA.CDARTJ = %S                         ' + #13 +
  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR' + #13 +
  '   AND EATE.CDTIPOESTADOAR = %S               ' ;

SQL_RECEBIDO_NO_CARTORIO =                                       
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

SQL_VERIFICAR_NUMERO_DOCUMENTO_ALTERADO =            
  'SELECT COUNT(1) TOTAL                         ' + #13 +
  '  FROM %SESARAR EA,                           ' + #13 +
  '       %SESARTIPOESTADOAR EATE                ' + #13 +
  ' WHERE EA.CDARTJ = %S                         ' + #13 +
  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR' + #13 +
  '   AND EATE.CDTIPOESTADOAR = %S               ' + #13 +
  '   AND EA.NUDOCRECEBEDOR = %S                 ' ;

SQL_VERIFICAR_AR_JUNTADA_PROCESSO =                   
  'SELECT COUNT(1) TOTAL                         ' + #13 +
  '  FROM %SESARAR EA,                           ' + #13 +
  '       %SESARTIPOESTADOAR EATE                ' + #13 +
  ' WHERE EA.CDARTJ = %S                         ' + #13 +
  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR' + #13 +
  '   AND EATE.CDTIPOESTADOAR = %S               ' ;

SQL_VERIFICA_AR_AGUARDANDO_JUNTADA =                       
  'SELECT COUNT(1) AGUARDANDO                    ' + #13 +
  '  FROM %SESARAR EA,                           ' + #13 +
  '       %SESARTIPOESTADOAR EATE                ' + #13 +
  ' WHERE EA.CDARTJ = %S                         ' + #13 +
  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR' + #13 +
  '   AND EATE.CDTIPOESTADOAR = %S               ' ;

SQL_VERIFICA_DEVOLUCAO_AR =                                   
  'SELECT COUNT(1) TOTAL                          ' + #13 +
  '  FROM %SESARAR EA,                            ' + #13 +
  '       %SESARTIPOESTADOAR EATE                 ' + #13 +
  ' WHERE EA.CDARTJ = %S                          ' + #13 +
  '   AND EATE.CDTIPOESTADOAR = EA.CDTIPOESTADOAR ' + #13 +
  '   AND EATE.CDTIPOESTADOAR = %S                ';

SQL_VERIFICA_OBSERVACAO_PROCESSO_FLUXO_TRABALHO =                               
  'SELECT PRO.DEOBSERVACAO OBSERVACAO, HIS.DEOBSERVACAO OBSERVACAO1   ' + #13 +
  '  FROM %SEFPGPROCESSO PRO, EWFLHISTOBJETO HIS                      ' + #13 +
  ' WHERE NUPROCESSO LIKE %S                                          ' + #13 +
  '   AND PRO.CDOBJETO = HIS.CDOBJETO                                 ' + #13 +
  '   AND HIS.NUSEQHIST = (SELECT MAX(NUSEQHIST)                      ' + #13 +
  '                          FROM EWFLHISTOBJETO                      ' + #13 +
  '                         WHERE CDOBJETO = HIS.CDOBJETO)            ' ;

SQL_VERIFICAR_PARTE_INDICIADO =                     
  'SELECT COUNT(1) PESSOACADASTRADA       ' + #13 +
  '  FROM %SESAJNOME EN,                  ' + #13 +
  '       %SEFPGPROCESSO EP,              ' + #13 +
  '       %SEFPGPARTE EPT                 ' + #13 +
  ' WHERE EPT.CDPROCESSO = EP.CDPROCESSO  ' + #13 +
  '   AND EN.CDPESSOA = EPT.CDPESSOA      ' + #13 +
  '   AND EN.NMPESSOA LIKE %S             ' + #13 +
  '   AND EP.NUPROCESSO LIKE %S           ' ;

//30/08/16 - CESAR.ALMEIDA
SQL_VERIFICAR_HISTORICO_PARTE =                   //OK
  ' SELECT MAX(NUSEQHISTPARTE) TOTAL    ' + #13 +
  '  FROM %SEAIPHISTORICOPARTE ET,      ' + #13 +
  '       %SEFPGPARTE EP,               ' + #13 +
  '       %SEFPGPROCESSO EPR            ' + #13 +
  ' WHERE ET.CDPROCESSO = EP.CDPROCESSO ' + #13 +
  '   AND ET.CDPROCESSO = EPR.CDPROCESSO' + #13 +
  '   AND EPR.NUPROCESSO = %S           ';

  SQL_VERIFICAR_PARCELAS_MULTA =                                  
  'SElECT COUNT(1) TOTAL                             ' + #13 +
  '  FROM %SEAIPHISTMULTA EM                         ' + #13 +
  ' WHERE EM.CDPROCESSO = (SELECT CDPROCESSO         ' + #13 +
  '                          FROM EFPGPROCESSO       ' + #13 +
  '                         WHERE NUPROCESSO like %S)' ;

SQL_RETORNA_SITUACAO_MANDADO =                              
  'SELECT COUNT(1) TOTAL                         ' + #13 +
  '  FROM %SesmdMandado MD,                      ' + #13 +
  '       %SesmdSituacaoMand SM                  ' + #13 +
  ' WHERE MD.cdSituacaoMand =  SM.cdSituacaoMand ' + #13 +
  '   and MD.cdSituacaoMand =  %s                ' + #13 +
  '   and MD.NUMANDADO = %s                      ';

SQL_RETORNA_GRJ =                          
 'SELECT COUNT(1) TOTAL      ' + #13 +
 '  FROM %SECCPGRJEMITIDA    ' + #13 +
 ' where cdForo = %s         ' + #13 +
 '   and nuGrjEmitida = %s   ';

SQL_VERIFICA_RECEBIMENTO_NULOTE =                             
  'SELECT COUNT(1) TOTAL                        ' + #13 +
  '  FROM %SECGOCARGA                           ' + #13 +
  ' WHERE NULOTE = %S                           ' + #13 +
  '   AND CDFORO = %S                           ' + #13 +
  '   AND TRUNC(DTRECEBIMENTO) = TRUNC(SYSDATE) ' + #13 +
  '   AND DTRECEBIMENTO IS NOT NULL             ';

SQL_RETORNA_SITUACAO_MANDADO_ATUALIZADO =                         
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

SQL_RETORNA_SITUACAO_MANDADO_ATUALIZADO_NAO_DIST =  
  'SELECT M.CDMANDADO,       ' + #13 +
  '       M.CDFORO,          ' + #13 +
  '       M.CDSITUACAOMAND,  ' + #13 +
  '       M.NUMANDADO,       ' + #13 +
  '       M.CDCENTRAL,       ' + #13 +
  '       M.CDZONA,          ' + #13 +
  '       M.DTCADASTRO       ' + #13 +
  '  FROM %SESMDMANDADO M    ' + #13 +
  ' WHERE M.NUMANDADO = %S   ';

SQL_RETORNA_ULTIMA_MOV_FLUXO =
  'SELECT HIST.nuSeqHist,                          ' + #13 +
  '       FILA.cdFila,                             ' + #13 +
  '       FILA.deFila                              ' + #13 +
  '  FROM %SEWFLHISTOBJETO HIST,                   ' + #13 +
  '       %SEWFLFILATRABALHO FILA                  ' + #13 +
  ' WHERE HIST.cdFila = FILA.cdFila                ' + #13 +
  '   AND HIST.CDOBJETO IN (select CDOBJETO        ' + #13 +
  '                           from ESMDMANDADO     ' + #13 +
  '                          where NUMANDADO = %s) ' + #13 +
  'order by HIST.nuSeqHist desc                    ';

SQL_RETORNA_USUARIO_AGENTE =
  'SELECT CDUSUARIO        ' + #13 +
  '  FROM %SESEGUSUARIO    ' + #13 +
  ' WHERE NMUSUARIO like %S' ;

SQL_VALIDA_LOCAL_REMESSA_PENDENTE =
  'SELECT COUNT(1) TOTAL            ' + #13 +
  '  FROM %SECGOCARGA EC            ' + #13 +
  ' WHERE EC.DTRECEBIMENTO IS NULL  ' + #13 +
  '   AND EC.NULOTE = %S            ' + #13 +
  '   AND EC.CDFORO = %S            ' + #13 +
  '   AND EC.CDTIPOLOCALDESTINO = %S' + #13 +
  '   and EC.CDLOCALDESTINO = %S    ';

SQL_VERIFICA_CANCELAMENTO_PROCESSO =
  'SELECT COUNT(1) TOTAL             ' + #13 +
  '  FROM %SEFPGPROCESSO             ' + #13 +
  ' WHERE CDPROCESSO = %S            ' + #13 +
  '   AND CDSITUACAOPROCESSO =  ''C''';

SQL_RETORNA_PROCESSO_REATIVADO =
  'SELECT COUNT(1) TOTAL             ' + #13 +
  '  FROM %SEFPGPROCESSO             ' + #13 +
  ' WHERE CDSITUACAOPROCESSO <> ''C''' + #13 +
  '   AND CDPROCESSO = %S            ' ;

SQL_VERIFICA_FORO_DESTINO =
  'SELECT COUNT(1) ACHOU            ' + #13 +
  '  FROM %SEFPGPROCESSO EP         ' + #13 +
  ' WHERE CDPROCESSO = %S           ' + #13 +
  '   AND CDFORODESTINO IS NOT NULL ' + #13 +
  '   AND CDFORODESTINO = %S        ' ;

SQL_RETORNA_DESCRICAO_FLUXO =
  ' SELECT DEGRUPOFLUXOTRAB              ' + #13 +
  '    FROM %SEWFLGRUPOFLUXOTRAB         ' + #13 +
  '    WHERE CDGRUPOFLUXOTRAB = %S       ';

SQL_VERIFICA_ALTERACAO_DADOS_PESSOA =
  'SELECT COUNT(1) TOTAL                 ' + #13 +
  '  FROM %SESAJNOME NM, ESAJPESSOADOC PC' + #13 +
  ' WHERE NM.CDPESSOA = PC.CDPESSOA      ' + #13 +
  '   AND NM.NMPESSOA = %S               ' + #13 +
  '   AND PC.DEORGAOEXPEDIDOR = %S       ' ;

SQL_VERIFICA_CADASTRO_PESSOA =
  'SELECT COUNT(1) TOTAL                 ' + #13 +
  '  FROM %SESAJNOME NM, ESAJPESSOADOC PC' + #13 +
  ' WHERE NM.CDPESSOA = PC.CDPESSOA      ' + #13 +
  '   AND NM.NMPESSOA = %S               ' + #13 +
  '   AND PC.NUDOCFORMATADO = %S         ' ;  

SQL_VERIFICA_PENDENCIA =
  ' SELECT COUNT(1) AS ACHOU       ' + #13 +
  '   FROM %SESAJPENDENCIAPRAZO    ' + #13 +
  '  WHERE CDPROCESSO = %S         ' + #13 +
  '    AND CDUSUARIOCADASTRO = %S  ' + #13 +
  '    AND DEPENDENCIA = %S        ';


SQL_VERIFICAR_DISTRIBUICAO_PROCESSOS =
  'SELECT COUNT(1) TOTAL                            ' + #13 +
  '  FROM %SEFPGPROCESSOMV EPM                      ' + #13 +
  ' WHERE %S = %S                                   ' + #13 +
  '   AND EPM.CDSITUACAOPROCESSO <> ''C''           ' + #13 +
  '   AND EXISTS (SELECT 1                          ' + #13 +
  '                 FROM %SEFPGPROCESSO             ' + #13 +
  '                WHERE EPM.CDPROCESSO = CDPROCESSO' + #13 +
  '                  AND NUPROCESSO IN (%S))        ';

// ====== SQL Variav�is Externas ======
SQL_INSERIR_DADOS_SQLITE =
  'INSERT INTO ESAJCAMPOVALOR (SEQUENCIA, CAMPO, VALOR) ' + #13 +
  'VALUES (%S, %S, %S) ';

SQL_RETORNA_DADOS_TESTE =
  'SELECT VALOR          ' + #13 +
  '  FROM ESAJCAMPOVALOR ' + #13 +
  ' WHERE CAMPO = %S     ' + #13 +
  '   AND SEQUENCIA = %S ';

SQL_DELETAR_DADOS_TESTE =
  'DELETE FROM ESAJCAMPOVALOR  ' + #13 +
  ' WHERE SEQUENCIA = %S       ' + #13 +
  '   AND CAMPO = %S           ';

SQL_VERIFICAR_FERIADO =
  'SELECT COUNT(1) TOTAL' + #13 +
  '  FROM %SESAJFERIADO ' + #13 +
  ' WHERE CDFORO = %S   ' + #13 +
  '   AND DTFERIADO = %S' ;

SQL_RETORNAR_FORO =
  'SELECT CDFORO         ' + #13 +
  '  FROM %SEFPGPROCESSO ' + #13 +
  ' WHERE NUPROCESSO = %S';
// ====================================

//20/10/2016 - Shirleano.Junior - Task: 66973
SQL_RETORNAR_SENHA_GERADA=
  ' SELECT nmSenha              ' +#13+
  '   FROM %SefpgSenhaProcesso  ' +#13+
  '  WHERE cdProcesso = %S      ' +#13+
  '    AND nuSeqSenha = %S      ';

//20/10/2016 - LUCIANO.FAGUNDES - SALT: 218598
SQL_VERIFICAR_ADVOGADO_UNIFICADO =
  'SELECT D.FLUNIFICADO                        ' + #13 +
  '  FROM %SESAJPESSOA P, %SESAJPESSOADOC D    ' + #13 +
  ' WHERE P.CDPESSOA = %S                      ' + #13 +
  '   AND D.NUDOCFORMATADO LIKE %S             ' + #13 +
  '   AND D.SGTIPODOCUMENTO = ''OAB''          ' + #13 +
  '   AND P.FLUNIFICADO = ''S''                ' ;

//25/10/2016 - Shirleano.Junior - Task: 66984
SQL_VERIFICA_PEC_CRIADO =
  ' SELECT DEOCORRENCIA                    ' + #13 +
  '   FROM %SEAIPGUIAEXECHIST              ' + #13 +
  '  WHERE CDPROCESSO = %S                 ';

// 26/10/2016  - Carlos.Gaspar - TASK: 66977

SQL_VALIDAR_HORARIO_ATENCIMENTO =
  'SELECT SUM(QTDE) AS QTDE                  ' + #13 +
  '  FROM (SELECT COUNT(1) AS QTDE           ' + #13 +
  '          FROM PG5TINT.SAJ.ESAJFORO EF,   ' + #13 +
  '               PG5TINT.SAJ.ESAJVARA EV    ' + #13 +
  '         WHERE EF.CDFORO = %S             ' + #13 +
  '           AND EF.CDFORO = EV.CDFORO      ' + #13 +
  '           AND EV.CDVARA = %S             ' + #13 +
  '           AND EF.NMALIAS = %S            ' + #13 +
  '           AND HRINICIOFUNCVARA = %S      ' + #13 +
  '        UNION ALL                         ' + #13 +
  '        SELECT COUNT(1) AS QTDE           ' + #13 +
  '          FROM PG5TINT2.SAJ.ESAJFORO EF,  ' + #13 +
  '               PG5TINT2.SAJ.ESAJVARA EV   ' + #13 +
  '         WHERE EF.CDFORO = %S             ' + #13 +
  '           AND EF.CDFORO = EV.CDFORO      ' + #13 +
  '           AND EV.CDVARA = %S             ' + #13 +
  '           AND EF.NMALIAS = %S            ' + #13 +
  '           AND HRINICIOFUNCVARA = %S      ' + #13 +
  '        UNION ALL                         ' + #13 +
  '        SELECT COUNT(1) AS QTDE           ' + #13 +
  '          FROM PG5TINT3.SAJ.ESAJFORO EF,  ' + #13 +
  '               PG5TINT3.SAJ.ESAJVARA EV   ' + #13 +
  '         WHERE EF.CDFORO = %S             ' + #13 +
  '           AND EF.CDFORO = EV.CDFORO      ' + #13 +
  '           AND EV.CDVARA = %S             ' + #13 +
  '           AND EF.NMALIAS = %S            ' + #13 +
  '           AND HRINICIOFUNCVARA = %S) QTDE';
                                             
SQL_VERIFICA_JUIZ_VAGA =
  'SELECT count(1) ACHOU          ' + #13 +
  '  FROM %SEFPGHISTVAGA HV       ' + #13 +
  '  JOIN %SESAJAGENTE AG         ' + #13 +
  '    ON AG.CDAGENTE = HV.CDJUIZ ' + #13 +
  '  JOIN %SEFPGDISTPROCESSO DP   ' + #13 +
  '    ON DP.CDVAGA = HV.CDVAGA   ' + #13 +
  ' WHERE DP.CDPROCESSO = %S      ' + #13 +
  '   AND AG.CDUSUARIO = %S       ' + #13 +
  '   AND HV.CDVAGA = %S          ' + #13 +
  '   AND HV.CDVARA = %S          ' + #13 +
  '   AND HV.CDFORO = %S          ' ;

SQL_VERIFICA_DADOS_DIST_PROCESSO =
  'SELECT  CDFORO,             ' + #13 +
  '        CDVARA,             ' + #13 +
  '        CDVAGA              ' + #13 +
  '  FROM  %SEFPGDISTPROCESSO  ' + #13 +
  ' WHERE  CDPROCESSO = %S     ' ;

//01/11/2016 - Shirleano.Junior - Task: 67016
RETORNAR_FILA_OBJETO =
  ' SELECT FT.DEFILA                     ' + #13 +
  '   FROM %SEWFLFILATRABALHO            ' + #13 +
  '        FT, %SEWFLOBJETOFILA FO       ' + #13 +
  '  WHERE FT.CDFILA = FO.CDFILA         ' + #13 +
  '    AND FO.CDOBJETO = %S              ';
VERIFICAR_FUNCAO_SEGURANCA =
  ' SELECT                                                      ' + #13 +
  '    isnull (AU.cdSistema, AG.cdSistema) as AUTORIZADO        ' + #13 +
  ' FROM                                                        ' + #13 +
  '   SAJ.ESEGTELA T                                            ' + #13 +
  '    JOIN SAJ.ESEGFUNCAOTELA FT ON                            ' + #13 +
  '       FT.cdSistema = T.cdSistema and                        ' + #13 +
  '      FT.cdTela = T.cdTela                                   ' + #13 +
  '    LEFT OUTER JOIN (SELECT D.cdSistema,                     ' + #13 +
  '          D.cdTela,                                          ' + #13 +
  '         D.cdFuncao                                          ' + #13 +
  '       FROM                                                  ' + #13 +
  '         saj.esegFuncSegDesab D                              ' + #13 +
  '       WHERE                                                 ' + #13 +
  '         D.cdUsuario = %S ) tAuth2                           ' + #13 +
  ' ON                                                          ' + #13 +
  '    FT.cdSistema = tAuth2.cdSistema and                      ' + #13 +
  '    FT.cdTela = tAuth2.cdTela and                            ' + #13 +
  '   FT.cdFuncao = tAuth2.cdFuncao                             ' + #13 +
  ' LEFT OUTER JOIN   (SELECT AG.cdSistema,                     ' + #13 +
  '       AG.cdTela,                                            ' + #13 +
  '      AG.cdFuncao                                            ' + #13 +
  '    FROM                                                     ' + #13 +
  '       saj.esegusuFuncao F,                                  ' + #13 +
  '       saj.esegusufuncperfil UG,                             ' + #13 +
  '      saj.esegAutorizGrupo AG                                ' + #13 +
  '    WHERE                                                    ' + #13 +
  '       F.cdUsuario = %S and                                  ' + #13 +
  '       UG.cdUsuario = F.cdUsuario and                        ' + #13 +
  '      AG.cdGrupo = UG.cdGrupo                                ' + #13 +
  '    UNION                                                    ' + #13 +
  '       SELECT                                                ' + #13 +
  '          AU.cdSistema,                                      ' + #13 +
  '          AU.cdTela,                                         ' + #13 +
  '         AU.cdFuncao                                         ' + #13 +
  '       FROM                                                  ' + #13 +
  '         saj.esegAutUsuario AU                               ' + #13 +
  '       WHERE                                                 ' + #13 +
  '         AU.cdUsuario = %S ) AG                              ' + #13 +
  ' ON                                                          ' + #13 +
  '    FT.cdSistema = AG.cdSistema and                          ' + #13 +
  '    FT.cdTela = AG.cdTela and                                ' + #13 +
  '   FT.cdFuncao = AG.cdFuncao                                 ' + #13 +
  ' LEFT OUTER JOIN   SAJ.ESEGAUTUSUARIO AU ON                  ' + #13 +
  '    FT.cdSistema = AU.cdSistema and                          ' + #13 +
  '    FT.cdTela = AU.cdTela and                                ' + #13 +
  '    FT.cdFuncao = AU.cdFuncao and                            ' + #13 +
  '   AU.cdUsuario= %S                                          ' + #13 +
  ' JOIN   SAJ.ESEGSISTEMA S ON                                 ' + #13 +
  '   T.cdSistema=S.cdSistema                                   ' + #13 +
  ' WHERE                                                       ' + #13 +
  '    ( cast ( %S as character ( 15 ) ) = %S )                 ' + #13 +
  ' and ft.cdSistema = 40 and ft.cdtela = 1 and ft.cdfuncao = 3 ' ;


SQL_DELETAR_VARIAVEIS_EXTERNAS_TESTE =
  'DELETE FROM ESAJCAMPOVALOR  ';

VERIFICAR_QTDE_FOROS_USUARIO =
  ' SELECT COUNT(*) AS QTDE                ' + #13 +
  ' FROM %SESAJUSUARIOLOTACAO UL           ' + #13 +
  ' JOIN %SESAJTIPOLOCAL TL                ' + #13 +
  '   ON TL.CDTIPOLOCAL = UL.CDTIPOLOCAL   ' + #13 +
  ' JOIN %SESAJFORO FO                     ' + #13 +
  '   ON FO.CDFORO = UL.CDFORO             ' + #13 +
  ' WHERE UL.CDUSUARIO = %S                ' + #13 +
  '   AND TL.CDCARACTERISTICA = 1          ' + #13 +
  '   AND UPPER(FO.NMALIAS) = %S           ' ;


VERIFICAR_QTDE_PROCESSOS_FILA_USUARIO =
  ' SELECT COUNT(*) AS QTDE                        ' + #13 +
  '   FROM EWFLOBJETOFILA A                        ' + #13 +
  '   JOIN REPL.EWFLFILATRABALHO B                 ' + #13 +
  '     ON A.CDFILA = B.CDFILA                     ' + #13 +
  '   JOIN REPL.EWFLFLUXOTRABALHO C                ' + #13 +
  '     ON A.CDFLUXOTRABALHO = C.CDFLUXOTRABALHO   ' + #13 +
  '  WHERE CDFORO IN (%S)                          ' + #13 +
  '    AND A.CDFLUXOTRABALHO = %S                  ' + #13 +
  '    AND A.CDFILA = %S                           ' + #13 +
  ' GROUP BY A.CDFLUXOTRABALHO,                    ' + #13 +
  '       C.NMFLUXOTRABALHO,                       ' + #13 +
  '       A.CDFILA,                                ' + #13 +
  '       B.DEFILA,                                ' + #13 +
  '       CDTIPOOBJETO                             ' ;

VERIFICAR_CLASSE_COMPETENCIA_EVOLUCAO =
  ' SELECT (1) ACHOU                        ' + #13 +
  '   FROM SAJ.EFPGPROCESSO P               ' + #13 +
  '   JOIN SAJ.EFPGDISTPROCESSO D           ' + #13 +
  '     ON P.CDPROCESSO = D.CDPROCESSO      ' + #13 +
  '   JOIN REPL.ESAJCLASSE C                ' + #13 +
  '     ON C.CDCLASSE = P.CDCLASSEPROCESSO  ' + #13 +
  '  WHERE P.CDPROCESSO = %S                ' + #13 +
  '    AND C.CDCLASSEEXT = %S               ' + #13 +
  '    AND P.CDTIPOCARTORIO = %S            ' + #13 +
  '    AND D.FLULTDISTRIBUICAO = %S         ' ;

VERIFICAR_SIGILO_EXTERNO_MANDADO =
  ' SELECT (1) ACHOU            ' + #13 +
  '   FROM %SESMDMANDADO        ' + #13 +
  '  WHERE FLSIGILOEXTERNO = %S ' + #13 +
  '    AND NUMANDADO = %S       ' ;
  
VERIFICAR_PUBLICA_INTIMACAO =
	' SELECT (1) ACHOU                           ' + #13 +
	'   FROM %SEFPGPUBINTIMACAO PI               ' + #13 +
	'   JOIN %SEFPGPUBLICADIARIO PD              ' + #13 +
	'     ON PD.CDVARA = PI.CDVARA               ' + #13 +
	'    AND PD.CDFORO = PI.CDFORO               ' + #13 +
	'    AND PD.NURELACAO = PI.NURELACAO         ' + #13 +
	'   JOIN %SEFPGPROCESSOMV PM                 ' + #13 +
	'     ON PM.CDPROCESSO = PI.CDPROCESSO       ' + #13 +
	'  WHERE PI.CDFORO = %S                      ' + #13 +
	'    AND PI.CDVARA = %S                      ' + #13 +
	'    AND PI.CDPROCESSO = %S                  ' + #13 +
	'    AND PI.NURELACAO = %S                   ' + #13 +
	'    AND PM.CDTIPOMVPROCESSO = %S            ';

VERIFICAR_GERA_PUBLICACAO =
	'  SELECT (1) ACHOU                           ' + #13 +
	'   FROM %SEFPGPUBLICAPESSOA PP               ' + #13 +
	'   JOIN %SEFPGPUBINTIMACAO PI                ' + #13 +
	'     ON PP.CDFORO = PI.CDFORO                ' + #13 +
	'    AND PP.CDPROCESSO = PI.CDPROCESSO        ' + #13 +
	'    AND PP.CDVARA = PI.CDVARA                ' + #13 +
	'   JOIN %SEFPGPUBLICADIARIO PD               ' + #13 +
	'     ON PD.CDFORO = PI.CDFORO                ' + #13 +
	'    AND PD.CDVARA = PI.CDVARA                ' + #13 +
	'    AND PD.NURELACAO = PI.NURELACAO          ' + #13 +
  '   JOIN SAJ.ESAJNOME NM                      ' + #13 +
  '     ON NM.CDPESSOA = PP.CDPESSOA            ' + #13 +
	'  WHERE PP.CDFORO = %S                       ' + #13 +
	'    AND PP.CDPROCESSO = %S                   ' + #13 +
	'    AND PP.CDVARA = %S                       ' + #13 +
	'    AND NM.NMPESSOA = %S                     ' + #13 +
	'    AND PP.FLPUBLICADA = ''S''               ' + #13 +
	'    AND PD.NURELACAO = %S                    ';

VERIFICA_SQL_REGISTRO_SENTENCA =
  'SELECT COUNT(1) ACHOU                                    ' + #13 +
  '  FROM SAJ.EFPGREGSENTENCA                               ' + #13 +
  ' WHERE CDPROCESSO = (SELECT CDPROCESSO                   ' + #13 +
  '                       FROM SAJ.EFPGPROCESSO             ' + #13 +
  '                      WHERE NUPROCESSO LIKE %S)          ' ;
VERFICAR_ALTERACAO_FORMA_PGTO =
  'SELECT COUNT(1) ACHOU' + #13 +
  '  FROM %SESMDMANDADO ' + #13 +
  ' WHERE CDOBJETO=%S   ' + #13 +
  '   AND CDFORMAPGTO=%S';

VERIFICAR_LISTA_CERTIDOES_UNICA =
  ' SELECT COUNT(P.CDPEDIDO) as QTDE     ' + #13 +
  '   FROM INDTINT.%SESGCPEDIDO P        ' + #13 +
  '   JOIN INDTINT.%SESGCENTREGA E       ' + #13 +
  '     ON P.CDENTREGA = E.CDENTREGA     ' + #13 +
  '   JOIN INDTINT.%SESGCMODELO M        ' + #13 +
  '     ON M.CDMODELO = P.CDMODELO       ' + #13 +
  '   JOIN INDTINT.%SESGCSITUACAOPED S   ' + #13 +
  '     ON P.CDSITUACAO = S.CDSITUACAO   ' + #13 +
  '   JOIN INDTINT.%SESAJFORO F          ' + #13 +
  '     ON F.CDCOMARCA = P.CDCOMARCA     ' + #13 +
  '  WHERE F.CDFORO = %S                 ' + #13 +
  '    AND P.CDSITUACAO in ( 1 , 2 , 3 , 4 , 5 , 6 , 7 , 11 , 12 , 13 , 14 , 15 , 16 , 17 )' ;

VERFICAR_ALTERACAO_PRAZO =
  'SELECT COUNT(1) ACHOU  ' + #13 +
  '  FROM %SESMDMANDADO   ' + #13 +
  ' WHERE CDOBJETO=%S     ' + #13 +
  '   AND CDCLASSIFMAND=%S';

VERFICAR_CANCELAMENTO_MANDADO =
  'SELECT COUNT(1) ACHOU   ' + #13 +
  '  FROM %SESMDMANDADO    ' + #13 +
  ' WHERE CDOBJETO=%S      ' + #13 +
  '   AND CDSITUACAOMAND=%S';


VALIDA_PRIORIZA_PROCES_SQL =
  ' SELECT (1) ACHOU               ' + #13 +
  '   FROM INDTINT.%SESGCPEDIDO P  ' + #13 +
  '  WHERE P.NUPEDIDO = %S         ' + #13 +
  '    AND P.NUPRIORIDADE = 4      ' ;

PEGA_SEQUENCIAL_PEDIDO =
  ' SELECT COUNT(NUPEDIDO)+1 AS SEQUENCIAL ' + #13 +
  '   FROM INDTINT.%SESGCPEDIDO            ' ;

VALIDAR_INSERCAO_PEDIDO_COMPLETO =
  ' SELECT (1) ACHOU                            ' + #13 +
  '   FROM INDTINT.%SESGCPEDIDO PED             ' + #13 +
  '   JOIN INDTINT.%SESGCNOMEPED NPED           ' + #13 +
  '     ON NPED.CDPEDIDO = PED.CDPEDIDO         ' + #13 +
  '   JOIN INDTINT.%SESGCNOMEPED NPEDVARIA      ' + #13 +
  '     ON NPEDVARIA.CDPEDIDO = PED.CDPEDIDO    ' + #13 +
  '   JOIN INDTINT.%SESGCNOMEPED NPEDPAI        ' + #13 +
  '     ON NPEDPAI.CDPEDIDO = PED.CDPEDIDO      ' + #13 +
  '   JOIN INDTINT.%SESGCNOMEPED NPEDMAE        ' + #13 +
  '     ON NPEDMAE.CDPEDIDO = PED.CDPEDIDO      ' + #13 +
  '   JOIN INDTINT.%SESGCSOLICITANTE SOL        ' + #13 +
  '     ON SOL.CDPEDIDO = PED.CDPEDIDO          ' + #13 +
  '   JOIN INDTINT.%SESGCENDNOMEPESQ ENP        ' + #13 +
  '     ON ENP.CDPEDIDO = PED.CDPEDIDO          ' + #13 +
  '  WHERE PED.NUPEDIDO = %S                    ' + #13 +
  '    AND PED.CDMODELO = %S                    ' + #13 +
  '    AND PED.TPPESSOA = %S                    ' + #13 +
  '    AND PED.FLGENERO = %S                    ' + #13 +
  '    AND PED.CDNACIONALIDADE = %S             ' + #13 +
  '    AND PED.CDESTADOCIVIL = %S               ' + #13 +
  '    AND PED.CDNATURALIDADE = %S              ' + #13 +
  '    AND PED.DTNASCIMENTO = %S                ' + #13 +
  '    AND PED.NURGFORMATADO = %S               ' + #13 +
  '    AND PED.DEPROFISSAO = %S                 ' + #13 +
  '    AND NPED.NMPESSOA = %S                   ' + #13 +
  '    AND NPED.TPNOME = ''N''                  ' + #13 +
  '    AND NPEDVARIA.NMPESSOA = %S              ' + #13 +
  '    AND NPEDVARIA.TPNOME = ''O''             ' + #13 +
  '    AND NPEDPAI.NMPESSOA = %S                ' + #13 +
  '    AND NPEDPAI.TPNOME = ''P''               ' + #13 +
  '    AND NPEDMAE.NMPESSOA = %S                ' + #13 +
  '    AND NPEDMAE.TPNOME = ''M''               ' + #13 +
  '    AND SOL.NMSOLICITANTE = %S               ' + #13 +
  '    AND SOL.NURG = %S                        ' + #13 +
  '    AND SOL.NUCPF = %S                       ' + #13 +
  '    AND SOL.DEENDERECO = %S                  ' + #13 +
  '    AND SOL.DECOMPLEMENTO = %S               ' + #13 +
  '    AND SOL.DEBAIRRO = %S                    ' + #13 +
  '    AND SOL.NUCEP = %S                       ' + #13 +
  '    AND SOL.CDMUNICIPIO = %S                 ' + #13 +
  '    AND SOL.NUTELEFONE = %S                  ' + #13 +
  '    AND SOL.DEEMAIL = %S                     ' + #13 +
  '    AND ENP.DEENDERECO = %S                  ' + #13 +
  '    AND ENP.DECOMPLEMENTO = %S               ' + #13 +
  '    AND ENP.DEBAIRRO = %S                    ' + #13 +
  '    AND ENP.NUCEP = %S                       ' + #13 +
  '    AND ENP.CDMUNICIPIO = %S                 ' ;

VERIFICAR_CONSULTA_PEDIDOS =
  'SELECT count(1) as ACHOU                 ' + #13 +
  '  FROM  INDTINT.%SESGCPEDIDO P           ' + #13 +
  '  JOIN  INDTINT.%SESGCNOMEPED N ON       ' + #13 +
  '     	P.CDPEDIDO = N.CDPEDIDO AND       ' + #13 +
  '     	N.TPNOME = ''N''                  ' + #13 +
  '  JOIN  INDTINT.%SESGCENTREGA E ON       ' + #13 +
  '    	P.CDENTREGA = E.CDENTREGA           ' + #13 +
  '  JOIN  INDTINT.%SESGCMODELO M ON        ' + #13 +
  '     	M.CDMODELO = P.CDMODELO           ' + #13 +
  '  JOIN  INDTINT.%SESGCSITUACAOPED S ON   ' + #13 +
  '     	P.CDSITUACAO = S.CDSITUACAO       ' + #13 +
  ' WHERE N.NMPESSOA = %S                   ' + #13 +
  ' AND   P.DTPEDIDO = %S                   ';

VALIDAR_ALTERACAO_PEDIDO =
  ' SELECT (1) ACHOU                            ' + #13 +
  '   FROM INDTINT.%SESGCPEDIDO PED             ' + #13 +
  '   JOIN INDTINT.%SESGCSITUACAOPED SIT        ' + #13 +
  '     ON SIT.CDSITUACAO = PED.CDSITUACAO      ' + #13 +
  '   JOIN INDTINT.%SESGCHISTORICOPED HIS       ' + #13 +
  '     ON HIS.CDPEDIDO = PED.CDPEDIDO          ' + #13 +
  '    AND HIS.CDSITUACAO = SIT.CDSITUACAO      ' + #13 +
  '  WHERE PED.CDUSUARIO = %S                   ' + #13 +
  '    AND PED.NUPEDIDO = %S                    ' + #13 +
  '    AND SIT.DESITUACAO = %S                  ' ;

VERIFICAR_SITUACAO_PEDIDO =
  'SELECT COUNT(1) ACHOU                 ' + #13 +
  '  FROM INDTINT.%SESGCPEDIDO           ' + #13 +
  ' WHERE NUPEDIDO = %S                  ' + #13 +
  '   AND CDSITUACAO = %S                ' ;

VERIFICAR_EXCLUSAO_PEDIDO =
  'SELECT COUNT(1) ACHOU                 ' + #13 +
  '  FROM INDTINT.%SESGCPEDIDO           ' + #13 +
  ' WHERE NUPEDIDO = %S                  ' ;



implementation

//jcf:format=on

end.

