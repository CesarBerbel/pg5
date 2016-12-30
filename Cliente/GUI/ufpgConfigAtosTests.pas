unit ufpgConfigAtosTests;

interface

uses
  Windows, ADODB, Forms, Classes, SysUtils, TestFramework, FutureWindows,
  uspDUnitDAO, uspForm, uspInterface, ufpgGUITestCase, uspGerenciadorRepositorio,
  ufpgProcessoRepositorio, ufpgConfigAtos, ufpgConfigAtosModelTests;

type
  TfpgConfigAtosTests = class(TfpgGUITestCase)
  public
    procedure TestarConfiguracaoAtos;
  published

  end;

implementation

procedure TfpgConfigAtosTests.TestarConfiguracaoAtos;
begin
  Check(True, 'Falhou Teste');
end;

//initialization
//  RegisterTest//('Interface\Configuração de Atos', TfpgConfigAtosTests.Suite);


end.

