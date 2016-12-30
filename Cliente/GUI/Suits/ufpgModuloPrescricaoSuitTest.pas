unit ufpgModuloPrescricaoSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgCadHistoricoParteTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastrar Módulo de prescrição';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarModuloPrescricao_1_10_2_1_1'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadHistoricoParteTests.Create(
      'TestarHistoricoPartes', 'TestarModuloPrescricao_1_10_2_1', 1, True));
  end;

end.

