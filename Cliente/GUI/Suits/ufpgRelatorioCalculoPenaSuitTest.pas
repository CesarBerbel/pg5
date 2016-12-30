unit ufpgRelatorioCalculoPenaSuitTest;

interface

uses
  TestFramework, uaipRelCalculoPenaTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgCadProcessoTests, usajConstante, ufpgCadHistoricoParteTests;

implementation

const
  CS_CAMINHO_TESTE = 'Relatório de Cálculo de Pena';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJMS then
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA))
  else
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoSimples'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadHistoricoParteTests.Create('TestarHistoricoPartes',
    'TestarHistoricoPartesReuPreso'));

  RegisterTest(CS_CAMINHO_TESTE, TfaipRelCalculoPenaTests.Create('TestarRelatorioCalculoPena',
    STRING_INDEFINIDO, 1, True));

end.

