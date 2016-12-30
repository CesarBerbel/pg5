unit ufpgCopiaProcessosParaOutraFilaSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgVisualizaFluxoTrabalhoTests, uwflEncaminhaProcessoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Copiar processo para outra fila';

initialization

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    'CadastroProcessoSimples'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
    'TestarFluxoTrabalho', 'TestarCopiaProcessosParaOutraFila_1_4_5_1'));

  RegisterTest(CS_CAMINHO_TESTE, TfwflEncaminhaProcessoTests.Create(
    'TestarEncaminharProcesso', 'TestarCopiaProcessosParaOutraFila_1_4_5_1', 1, True));

end.

