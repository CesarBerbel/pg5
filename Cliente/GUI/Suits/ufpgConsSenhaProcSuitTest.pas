unit ufpgConsSenhaProcSuitTest;

interface

uses
  TestFramework, ufpgVariaveisTestesGUI, ufpgConsSenhaProcessoTests, ufpgCadProcessoTests,
  ufpgConstanteGUITests, ufpgGerenciadorArquivoTests, ufpgVisualizaFluxoTrabalhoTests,
  ufpgEdicaoDocumentoTests, ufpgEditorTests, ufpgCadMovimentacaoUnitariaTests;

implementation

const
  CS_CAMINHO_TESTE = 'Gerar senha da parte do processo ';
  CS_CAMINHO_TESTE2 = 'Gerar senha Processo com check vertical';


initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarGerarSenhaProcesso'));
    RegisterTest(CS_CAMINHO_TESTE, TffpgConsSenhaProcessoTests.Create(
      'TestarGeracaoDeSenhaProcessoOutros_1_4_21', 'TestarGeracaoDeSenhaProcessoOutros_1_4_21',
      1, True));

    //04/11/2016 - Shirleano.Junior - Task: 67187
    RegisterTest(CS_CAMINHO_TESTE + ' Verificando parametro 41024',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'TestarComportamentoParametro41024'));

    RegisterTest(CS_CAMINHO_TESTE + ' Verificando parametro 41024',
      TffpgConsSenhaProcessoTests.Create('TestarGeracaoDeSenhaProcessoOutros_1_4_21',
      'TestarComportamentoParametro41024'));

    RegisterTest(CS_CAMINHO_TESTE + ' Verificando parametro 41024',
      TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarComportamentoParametro41024'));

    RegisterTest(CS_CAMINHO_TESTE + ' Verificando parametro 41024',
      TffpgEditorTests.Create('TestarEditor', 'TestarComportamentoParametro41024'));

    RegisterTest(CS_CAMINHO_TESTE + ' Verificando parametro 41024',
      TffpgGerenciadorArquivoTests.Create('TestarGerenciadorArquivos',
      'TestarComportamentoParametro41024', 1, True));
    //--

    //****************** Gerar senha Processo com check vertical ******************
    RegisterTest(CS_CAMINHO_TESTE2, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarGerarSenhaProcesso'));
    RegisterTest(CS_CAMINHO_TESTE2, TffpgConsSenhaProcessoTests.Create(
      'TestarGeracaoDeSenhaProcessoOutros_1_4_21', 'TestarGerarSenhaProcesso'));
    RegisterTest(CS_CAMINHO_TESTE2, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarGerarSenhaProcesso'));
    RegisterTest(CS_CAMINHO_TESTE2, TffpgEditorTests.Create('TestarEditor',
      'TestarGerarSenhaProcesso', 1, True));

  end;

end.

