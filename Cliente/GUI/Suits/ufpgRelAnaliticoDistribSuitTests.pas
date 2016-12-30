unit ufpgRelAnaliticoDistribSuitTests;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgRelAnaliticoDistribTests;

const
  CS_CAMINHO_TESTE = 'Relatório Analitico Distribuição';

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'ProcessoPenalGenerico'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRelAnaliticoDistribTests.Create(
      'TestarRelAnaliticoDistrib', ''));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRelAnaliticoDistribTests.Create(
      'TestarRelAnaliticoDistrib', 'TestarRelAnaliticoDistribPeriodo', 1, True));
  end;
end.

