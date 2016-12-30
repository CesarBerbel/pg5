unit ufpgConstanteGUITests;

interface

const
  // Formatacao Dta/Hora
  CS_AGORA = 'Agora';
  CS_HOJE = 'Hoje';
  CS_FORMATO_DATA = 'dd/mm/yy';
  CS_FORMATO_HORA = 'hh:mm';

  // Registers
  CS_PROCESSO_PENAL_GENERICO = 'ProcessoPenalGenerico'; //Apagar esse depois

  CS_PROCESSO_PENAL_GENERICO_SORTEIO = 'CadastroProcessoPenalSorteio';
  CS_PROCESSO_PENAL_GENERICO_DIRECIONADA = 'CadastroProcessoPenalDirecionada';
  CS_PROCESSO_PENAL_GENERICO_DEPENDENCIA = 'CadastroProcessoPenalDependencia';
  CS_PROCESSO_CIVIL_GENERICO_SORTEIO = 'CadastroProcessoCivilSorteio';
  CS_PROCESSO_CIVIL_GENERICO_DIRECIONADA = 'CadastroProcessoCivilDirecionada';


  CS_PROCESSO_PENAL_FISICO_GENERICO = 'ProcessoFisicoGenerico';

  // Funcões testes
  CS_PATH = 'C:\';
  CS_ARQUIVO_VAR_EXTERNA = 'd:\varExterna.cbl';
  CS_NOME_ARQUIVO_IMPTXT = CS_PATH + 'generica.cbl';
  CS_MASCARA_DATA_CURTA = 'dd/mm/yyyy';
  CS_ARQUIVO_CONFIGURACAO_LOCAL_APP = 'CFGLOCALTESTES.INI';
  CS_CONFIGURACAO = 'CONFIGURACOES';
  CS_PSS5 = 'LOCALPSS5';
  CS_PRO = 'LOCALPRO';

  // Cadastro Processo
  CS_NUPROCESSO = 'nuprocesso';
  CS_CDPROCESSO = 'cdprocesso';
  CS_NUPROTOCOLO = 'nuprotocolo';
  CS_CDFORO = 'cdforo';
  CS_CDVARA = 'cdvara';
  CS_ABA_DADOS_DELEGACIA = 'DadosDelegacia';
  CS_ABA_DADOS_PRECATORIA = 'DadosPrecatoria';
  CS_NOME_RUA = 'Rua de Testes Automatizados';
  CS_NOME_PARTE = 'nmParte';
  CS_AUTOR = 'Autor';
  CS_REU = 'Reu';
  CS_VITIMA = 'Vitima';
  CS_ATIVO = 'A';
  CS_PASSIVO = 'P';
  CS_ADVOGADO = 'R';
  CS_TIPO_VITIMA = 'V';
  CS_FORMATO_ANO_COMPLETO = 'yyyy';
  CS_COMPETENCIA_CRIMINAL = '119';

  CS_TIPO_DISTRIBUICAO_DIRECIONADA_SC = 'Direcionamento';
  CS_TIPO_DISTRIBUICAO_DIRECIONADA = 'Direcionada';
  CS_TIPO_DISTRIBUICAO_DEPENDENCIA = 'Dependência';
  CS_TIPO_DISTRIBUICAO_LIVRE_SP = 'Livre';
  CS_TIPO_DISTRIBUICAO_SORTEIO_SC = 'Sorteio';

  CN_BEM_ARMA = 1;
  CN_BEM_MUNICAO = 2;
  CN_BEM_VEICULO = 3;
  CN_BEM_IMOVEL = 4;
  CN_BEM_TITULO = 5;
  CN_BEM_OUTROSBENS = 6;
  CS_CLIENTE_PG5_TJMS = 'MS';
  CS_CLIENTE_PG5_TJSC = 'SC';
  CS_CLIENTE_PG5_TJSP = 'SP';
  CS_SIGILO_ABSOLUTO = 'Absoluto';

  // Edição documento
  CS_COM_DILIGENCIA = '1';
  //  CS_SEM_DILIGENCIA = '2';
  CS_ENDERECO_ATENDIDO = '1';
  CS_ENDERECO_NAO_ATENDIDO = '2';
  CN_MANDADO = 1;

  // Remessa
  CS_RESOLUCAO_46 = 'Conforme a Resolução 46';

  // Editor
  CS_AR = 'AR';

  //Fluxo de Mandados
  CS_MASCARA_DATA_SEMBARRA = 'ddmmyyyy';
  CS_SALVAR_ARQUIVO_PDF = 'testeGRJ.pdf';

  STRING_INDEFINIDO = '';

  //Peticao
  CS_CAMINHO_PETICAO = '';
  CS_MODO_ABRIR_ARQUIVO = '';
  CS_EXTENSAO_PETICAO = '';
  CS_NOME_PROCESSO_PETICAO = '';
  CS_ARQUIVO_BAT_PETICAO = '';

  //Consulta de processo
  CS_PASTA_CPOPG5 = 'cpoPG5\';
  CS_CPF = 'CPF';

  //Importar Arquivo
  CS_ARQUIVO_PDF = 'ArquivoImportar.pdf';

  //Build
  CS_NOTURNO = 'NOTURNO';

  CS_CEP_PADRAO_SP = '03033-020';


  // 03/11/2016  - Carlos.Gaspar - TASK: 67184
  CS_CAMINHO_TESTE_ATO_ORDINATORIO =
    'Emitir Ato Ordinatório Pelo Fluxo - Vista a Defensoria-Portal';

implementation

end.

