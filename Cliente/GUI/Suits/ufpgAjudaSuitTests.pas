// 09/11/2016  - Carlos.Gaspar - TASK: 67185
// 09/11/2016  - Yuri.Fernandes - TASK: 67185
unit ufpgAjudaSuitTests;

interface

uses
  TestFramework, ufpgAjudaTests, ufpgVariaveisTestesGUI, ufpgConstanteGUITests;

const
  CS_CAMINHO_TESTE = 'Testar ajuda ao usuário PG5';

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgAjudaTests.Create('CopiarPastaParaTeste'));
    RegisterTest(CS_CAMINHO_TESTE, TffpgAjudaTests.Create('VerificarHelpPG5', '', 1, True));
  end;
end.

