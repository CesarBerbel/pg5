unit ufpgConstanteTests;

interface

const

  //TIPO ESTADO AR
  nTPESTAR_AGUARDANDO_REMESSA_EXP = 2;

  //FORMATO CURTO PADRÃO DE DATA
  CS_MASCARA_DATA_CURTA = 'dd/mm/yyyy';
  CS_MASCARA_DATA_SEMBARRA = 'ddmmyyyy';

  //Arquivos Externos
  CS_ARQUIVO_MULTIMIDIA_1 = '28149973_1_v.asf';
  CS_ARQUIVO_MULTIMIDIA_2 = '28149973_2_v.asf';
  CS_PATH = 'C:\';
  CS_NUPROCESSO_PATH = 'nProcesso.txt';
  CS_NUPROTOCOLO_PATH = 'nProtocolo.txt';
  CS_ARQUIVO_PDF = 'ArquivoImportar.pdf';
  CS_SALVAR_ARQUIVO_PDF = 'testeGRJ.pdf';
  CS_NOME_ARQUIVO = 'varExterna.cbl';
  CS_NOME_ARQUIVO_IMPTXT = CS_PATH + 'generica.cbl';

  CS_ARQUIVO_CONFIGURACAO_LOCAL_APP = 'CFGLOCALTESTES.INI';
  CS_CONFIGURACAO = 'CONFIGURACOES';
  CS_PSS5 = 'LOCALPSS5';
  CS_PRO = 'LOCALPRO';

  CS_NUPROCESSOCOMPLETO = 'nuprocessocompleto';
  CS_NUPROCESSO = 'nuprocesso';
  CS_CDPROCESSO = 'cdprocesso';
  CS_NUPROTOCOLO = 'protocolo';
  CS_CDFORO = 'cdforo';
  CS_CDVARA = 'cdvara';

  CS_RESOLUCAO_46 = 'Conforme a Resolução 46';

  //Cadadtro de processo
  CS_AUTOR = 'Autor ';
  CS_REU = 'Reu ';
  CS_VITIMA = 'Vitima ';
  CS_ATIVO = 'A';
  CS_PASSIVO = 'P';
  CS_ADVOGADO = 'R';
  CS_TIPO_VITIMA = 'V';
  CS_FORMATO_DATA = 'dd/mm/yyyy';
  CS_FORMATO_ANO_COMPLETO = 'yyyy';
  CS_COMPETENCIA_CRIMINAL = '119';
  CS_TESTEMUNHA = 'Testemunha ';
  CS_STR_VAZIA = '';
  CS_CPF = 'CPF';
  CN_QTDE_PARTES = 4;


  // MOTIVO APENSAMENTO PROCESSO
  sMOTIVO_APENSAMENTO_PROCESSO = 'Teste Automatizado de Apensamento';
  sMOTIVO_DESAPENSAMENTO_PROCESSO = 'Teste Automatizado de Desapensamento';

  //Peticao Inicial Eletronica
  CS_CAMINHO_PETICAO = 'Peticao PG5\';
  CS_EXTENSAO_PETICAO = '*.txt';
  CS_ARQUIVO_BAT_PETICAO = 'CriarInicial.bat';
  CS_MODO_ABRIR_ARQUIVO = 'open';
  CS_NOME_PROCESSO_PETICAO = 'TfsajGerarPeticoesIniciais';
  CS_QT_PAGINA = 'qtPaginas';
  CS_COM_DILIGENCIA = '1';
  CS_SEM_DILIGENCIA = '2';
  CS_PATH_LOCAL = 'C:\';
  CS_ARQUIVO_BAT_PETICAO_INTERMEDIARIA = 'CriarIntermediaria.bat';

  CS_SELECIONAR = 'S';

  CN_PETICAO_INICIAL = 1;
  CN_PETICAO_INTERMEDIARIA = 2;

  CS_PROCESSO_PENAL_GENERICO = 'ProcessoPenalGenerico';

  CS_CAMINHO_PG5_DEST3 = 'C:\SAJ\CLIENTES\SAJPG5_3\';
  CS_CAMINHO_PG5_MASTER = 'C:\SAJ\CLIENTES\SAJPG5\';
  CS_CAMINHO_PRO = 'C:\SAJ\CLIENTES\SAJPRO\';
  CS_ERRO = 'Erro';

  // 28/03/2016  - Carlos.Gaspar - SALT: 186660/25/1
  //Selecionar o Cliente / Cadastro de Processo
  CS_CLIENTE_PG5_TJMS = 'TJ/MS';
  CS_CLIENTE_PG5_TJSC = 'TJ/SC';

  CS_INDICIADO = 'Indiciado ';
  CS_SENHA = 'agesune1';
  CS_TIPO_DIRECIONAMENTO = 'Sorteio';
  // 28/12/2015 - Felipe.s SALT:186660/23/8
  sREU_PRESO = 'Réu preso';
  CS_PONTO = '.';
  CS_PERCENTUAL = '%';
  CS_CRLF = #13#10;
  //20/04/2016 - Luciano.Fagundes - SALT: 186660/25/5
  CS_PASTA_CPOPG5 = 'cpoPG5\';
  CS_TAG_PROCESSO_APENSO_A = '</a>';

  CS_TAG_PROCESSO_APENSO_TD = '</td>';
  CS_URL_PROCESSO_APENSO = 'LinkProc_';
  CS_LABEL_APENSO_IMAGENS = '<td height="23" background="imagens/processoFundo.gif">';
  CS_LABEL_APENSO = '<td ><span class="label">Apensado ao</span></td>';

implementation

end.

