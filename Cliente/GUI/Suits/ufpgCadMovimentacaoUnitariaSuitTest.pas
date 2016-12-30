unit ufpgCadMovimentacaoUnitariaSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgCadMovimentacaoUnitariaTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastro de Movimentação Unitária';

initialization

  if gsCliente <> CS_CLIENTE_PG5_TJMS then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'ProcessoPenalGenerico'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadMovimentacaoUnitariaTests.Create(
      'TestarCadastrarMovUnitaria', ''));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadMovimentacaoUnitariaTests.Create(
      'TestarExcluirMovUnitaria', '', 1, True));
  end;

end.

