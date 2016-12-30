unit ufpgRelArrecadacaoSuitTest;

interface

uses
  TestFrameWork, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, usgcRelArrecadacaoTests;

const
  CS_CAMINHO_TESTE = 'Certidão \ Relatório de Arrecadacão';

implementation

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TfsgcRelArrecadacaoTests.Create('TestarRelArrecadacao',
      'TestarRelArrecadacao', 1, True));
  end;

end.

