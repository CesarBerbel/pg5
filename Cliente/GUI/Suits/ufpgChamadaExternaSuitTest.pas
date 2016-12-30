unit ufpgChamadaExternaSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, usajConstante;

implementation

initialization
  if ParamStr(1) <> STRING_INDEFINIDO then
  begin
    RegisterTest(STRING_INDEFINIDO, TffpgCadProcessoTests.Create('TestarCadastroProcessoOutroExec',
      'ProcessoPenalGenerico'));
  end;
end.

