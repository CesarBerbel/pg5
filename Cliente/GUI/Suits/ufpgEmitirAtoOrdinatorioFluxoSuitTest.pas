unit ufpgEmitirAtoOrdinatorioFluxoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgEdicaoDocumentoTests, ufpgEditorTests,
  ufpgVisualizaFluxoTrabalhoTests, ufpgFuncoesGUITestes, ufpgConstanteGUITests,
  ufpgVariaveisTestesGUI;

implementation

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    // 03/11/2016  - Carlos.Gaspar - TASK: 67184
    RegisterTest(CS_CAMINHO_TESTE_ATO_ORDINATORIO, TffpgCadProcessoTests.Create(
      'TestarCadastroProcesso', 'CadastroProcessoCivilDirecionadaTarjaAtosOrdinatorios'));

    RegisterTest(CS_CAMINHO_TESTE_ATO_ORDINATORIO,
      TffpgVisualizaFluxoTrabalhoTests.Create('TestarFluxoTrabalho',
      'TestarEmitirAtoOrdinatorioPeloFluxoVistaDefensoria'));

    RegisterTest(CS_CAMINHO_TESTE_ATO_ORDINATORIO,
      TffpgVisualizaFluxoTrabalhoTests.Create('TestarFluxoTrabalho',
      'TestarEmitirAtoOrdinatorioPeloFluxoVistaDefensoria1'));

    RegisterTest(CS_CAMINHO_TESTE_ATO_ORDINATORIO,
      TffpgVisualizaFluxoTrabalhoTests.Create('TestarFluxoTrabalho',
      'TestarEmitirAtoOrdinatorioPeloFluxoVistaDefensoria2', 1, True));
  end;
end.

