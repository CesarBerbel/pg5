unit ufpgRelDemoDistribModelTests;

interface

uses
  ufpgRelDemoDistrib, ufpgModelTests, SysUtils, usajConstante;

type
  TffpgRelDemoDistribModelTests = class(TfpgModelTests)
  private
    FscdForo: string;
    FsNuProcesso: string;
  public
    class function RetornaProcessoDemonsDistribVara(pscdForo: string): string;
  published
    property fpgcdForo: string read FscdForo write FscdForo;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgRelDemoDistribModelTests }

//28/07/2015 - LUCIANO.FAGUNDES - SALT: 186660/9/2
class function TffpgRelDemoDistribModelTests.RetornaProcessoDemonsDistribVara(
  pscdForo: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornaProcessoDemonsDistribSql(pscdForo);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('NUPROCESSO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

