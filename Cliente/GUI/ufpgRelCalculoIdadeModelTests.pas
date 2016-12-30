unit ufpgRelCalculoIdadeModelTests;

interface

uses
  ufpgRelCalculoIdade, ufpgModelTests, SysUtils, usajConstante;

type
  TffpgRelCalculoIdadeModelTests = class(TfpgModelTests)
  private
    FsVara: string;
    fsNuProcesso: string;
  public
    class function RetornaProcessoRelExtratoProc(psVara: string): string;
  published
    property fpgVara: string read FsVara write FsVara;
    property fpgNuProcesso: string read fsNuProcesso write fsNuProcesso;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgRelCalculoIdadeModelTests }

//06/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/11/3
class function TffpgRelCalculoIdadeModelTests.RetornaProcessoRelExtratoProc(
  psVara: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarRelCalculoIdade(psVara, 1);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('NUPROCESSO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

