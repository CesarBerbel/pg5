unit ufpgVisualizaProcessoSuitTests;

interface

uses
  TestFramework, ufpgVisualizaProcessoTests, ufpgDigPecaProcessualTests,
  ufpgCadProcessoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI;

implementation

const
  CS_CAMINHO_TESTE = 'Tornar documento sem efeito';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

    RegisterTest(CS_CAMINHO_TESTE, TffpgDigPecaProcessualTests.Create(
      'TestarImportarArquivo', ''));

    RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaProcessoTests.Create(
      'TestarVisualizacaoAutos', '', 1, True));
  end;

end.

