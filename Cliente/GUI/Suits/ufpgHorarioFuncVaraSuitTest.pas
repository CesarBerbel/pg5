unit ufpgHorarioFuncVaraSuitTest;

interface

uses
  TestFramework, ufpgVariaveisTestesGUI, ufpgHorarioFuncVaraTests, ufpgConstanteGUITests;


implementation

const
  CS_CAMINHO_TESTE = 'Horário Funcionamento ao Público';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgHorarioFuncVaraTests.Create('TestarHorarioFuncionamento',
      '', 1, True));
  end;

end.

