unit ufpgVisualizarDocumentoSuitTest;

interface

uses
  TestFramework, ufpgVariaveisTestesGUI, ufpgConstanteGUITests, ufpgCadProcessoTests,
  ufpgCadMovimentacaoUnitariaTests;


implementation

const
  CS_CAMINHO_TESTE = 'Visualizar Documento ou Modelo';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoSimples'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_SORTEIO));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadMovimentacaoUnitariaTests.Create(
      'TestarVisualizarDocumento', STRING_INDEFINIDO, 1, True));
  end;
end.

