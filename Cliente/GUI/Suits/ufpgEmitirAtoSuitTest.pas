unit ufpgEmitirAtoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgEdicaoDocumentoTests, ufpgEditorTests,
  ufpgVisualizaFluxoTrabalhoTests, ufpgFuncoesGUITestes, ufpgConstanteGUITests,
  ufpgVariaveisTestesGUI;

implementation

const
  CS_CAMINHO_TESTE = 'Emitir Ato Ordinatório ';
  CS_CAMINHO_TESTE2 = 'Emitir Ato Ordinatório com Vista ao MP';


initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin

    RegisterTest(CS_CAMINHO_TESTE + ' Pelo Fluxo', TffpgCadProcessoTests.Create(
      'TestarCadastroProcesso', 'CadastroProcessoEmitirAtoOrdinatorio'));

    RegisterTest(CS_CAMINHO_TESTE + ' Pelo Fluxo',
      TffpgVisualizaFluxoTrabalhoTests.Create('TestarFluxoTrabalho',
      'TestarEmitirAtoOrdinatorioPeloFluxo'));

    RegisterTest(CS_CAMINHO_TESTE + ' Pelo Fluxo',
      TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarEmitirAtoOrdinatorioPeloFluxo'));

    RegisterTest(CS_CAMINHO_TESTE + ' Pelo Fluxo', TffpgEditorTests.Create(
      'TestarEditor', 'TestarEmitirAtoOrdinatorioPeloFluxo'));

    RegisterTest(CS_CAMINHO_TESTE + ' Pelo Fluxo',
      TffpgVisualizaFluxoTrabalhoTests.Create('TestarFluxoTrabalho',
      'TestarEmitirAtoOrdinatorio', 1, True));

    //******************** Emitir Ato Ordinatório com Vista ao MP ********************
    RegisterTest(CS_CAMINHO_TESTE2, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoEmitirAtoOrdinatorio'));
    RegisterTest(CS_CAMINHO_TESTE2, TffpgVisualizaFluxoTrabalhoTests.Create(
      'TestarFluxoTrabalho', 'TestarEmitirAtoOrdinatorioVistaMP', 1, True));

  end;
end.

