unit ufpgRelCalculoIdadeSuitTests;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgRelCalculoIdadeTests,
  ufpgCadProcessoTests, usajConstante;

implementation

const
  CS_CAMINHO_TESTE = 'Relatório Calculo Idade';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'ProcessoPenalGenerico'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRelCalculoIdadeTests.Create('TestarRelCalculoIdade',
      STRING_INDEFINIDO, 1, True));
  end;

end.

