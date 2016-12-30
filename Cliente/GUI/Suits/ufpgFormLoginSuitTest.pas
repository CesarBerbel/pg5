unit ufpgFormLoginSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgFormLoginTests;

const
  CS_CAMINHO_TESTE = 'Testar logar com usuário e com senha errados';

implementation

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgFormLoginTests.Create('TestarFormLogin',
      'TestarLogarUsuarioErrado', 1, True));
  end;

end.

