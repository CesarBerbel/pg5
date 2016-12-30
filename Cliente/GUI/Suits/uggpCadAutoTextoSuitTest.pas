unit uggpCadAutoTextoSuitTest;

interface

uses
  TestFramework, uggpCadAutoTextoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI;

const
  CS_CAMINHO_TESTE = 'Cadastrar e excluir Auto Texto';

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TfggpCadAutoTextoTests.Create('TestarCadAutoTexto',
      STRING_INDEFINIDO, 1, True));
  end;
end.

