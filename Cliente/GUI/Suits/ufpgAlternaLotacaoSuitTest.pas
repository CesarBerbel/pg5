unit ufpgAlternaLotacaoSuitTest;

interface

uses
  TestFramework, usajConstante, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgAlternaLotacaoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Alternar Lota��o do Usu�rio';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgAlternaLotacaoTests.Create('TestarAlternarLotacao',
      'AlterarLotacaoUsuario', 1, True));
  end;

end.

