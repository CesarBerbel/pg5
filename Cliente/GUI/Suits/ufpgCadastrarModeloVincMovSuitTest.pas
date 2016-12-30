unit ufpgCadastrarModeloVincMovSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadModeloTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastrar um modelo vinculando movimentação';

initialization
  if gsCliente = 'erro' then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadModeloTests.Create('TestarCadastrarModelo',
      'TestarCadastrarModeloVincMov_1_12_1', 1, True));
  end;
end.

