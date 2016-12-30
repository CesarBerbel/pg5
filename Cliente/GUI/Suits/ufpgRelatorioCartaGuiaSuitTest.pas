unit ufpgRelatorioCartaGuiaSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgCadHistoricoParteTests, uaipRelCartaGuiaTests, usajConstante;

implementation

const
  CS_CAMINHO_TESTE = 'Relatório Carta de Guia';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJMS then
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA))
  else
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoSimples'));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadHistoricoParteTests.Create('TestarHistoricoPartes',
    'TestarHistoricoPartesReuPreso'));

  RegisterTest(CS_CAMINHO_TESTE, TfaipRelCartaGuiaTests.Create('TestarRelatorioCartaGuia',
    STRING_INDEFINIDO, 1, True));
end.

