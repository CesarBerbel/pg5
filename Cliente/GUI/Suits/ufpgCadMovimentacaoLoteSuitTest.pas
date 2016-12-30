unit ufpgCadMovimentacaoLoteSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgCadMovimentacaoLoteTests,
  ufpgConstanteGUITests, ufpgVariaveisTestesGUI;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastro de movimentação em lote';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoClasse9279', 5));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadMovimentacaoLoteTests.Create(
      'TestarLancarMovimentacaoLote', 'TestarLancarMovimentacaoLote', 1, True));
  end;
end.

