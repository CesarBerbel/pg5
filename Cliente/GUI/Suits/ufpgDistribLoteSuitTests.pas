unit ufpgDistribLoteSuitTests;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgDistribLoteTests, ufpgConstanteGUITests,
  ufpgVariaveisTestesGUI, usajConstante;

implementation

const
  CS_CAMINHO_TESTE = 'Redistribuição em lote';

initialization
  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    'CadastroProcessoPenalSemDistribuicao', 3));

  RegisterTest(CS_CAMINHO_TESTE, TffpgDistribLoteTests.Create('TestarDistribuicao',
    STRING_INDEFINIDO, 1, True));
end.

