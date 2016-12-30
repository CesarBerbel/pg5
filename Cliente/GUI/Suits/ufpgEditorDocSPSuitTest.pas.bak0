unit ufpgEditorDocSPSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgEditorTests;

implementation

const
  CS_CAMINHO_TESTE = 'Testar Editor\';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
    RegisterTest(CS_CAMINHO_TESTE + ' copiar e colar texto',
      TffpgEditorTests.Create('TestarEditor', 'TestarCorrigirTextoSP', 1, True));
end.

