unit ufpgLiberaProcessoEmGrauDeRecursoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgCadMovimentacaoUnitariaTests,
  ufpgDigPecaProcessualTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgEnvioRecursoEletronicoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Liberar nos autos processo em grau de recurso.';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoPenalSimples'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadMovimentacaoUnitariaTests.Create(
      'TestarCadastrarMovUnitaria', 'TestarCadastrarMovGrauDeRecurso'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEnvioRecursoEletronicoTests.Create(
      'TestarEnvioRecursosEletronicos', 'TestarEnvioRecursosEletronicos'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadMovimentacaoUnitariaTests.Create(
      'TestarVerificarMovUnitaria', 'TestarVisualizarMovGrauDeRecurso'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgDigPecaProcessualTests.Create('TestarImportarArquivo',
      'TestarImportarArquivoGrauRecurso', 1, True));
  end;
end.

