unit ufpgLancarMovimentacaoLoteSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgCadMovimentacaoLoteTests;

implementation

const
  CS_CAMINHO_TESTE = 'Lançar Movimentação em lote';

initialization

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
    'ProcessoPenalGenerico', 2));


  RegisterTest(CS_CAMINHO_TESTE, TffpgCadMovimentacaoLoteTests.Create(
    'TestarLancarMovimentacaoLote', '', 1, True));

end.

