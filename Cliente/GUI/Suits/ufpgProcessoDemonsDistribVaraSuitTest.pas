unit ufpgProcessoDemonsDistribVaraSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgRelDemoDistribTests, usajConstante;

implementation

const
  CS_CAMINHO_TESTE = 'Relatório Demonstrativo da Distribuição para Vara';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoSimples'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRelDemoDistribTests.Create(
      'TestarProcessoDemonsDistribVara', STRING_INDEFINIDO, 1, True));
  end;
end.
