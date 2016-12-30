unit ufpgRelExtratoProcModelTests;

interface

uses
  ufpgRelExtratoProc, ufpgModelTests, SysUtils, usajConstante;

type
  TffpgRelExtratoProcModelTests = class(TfpgModelTests)
  private
    FscdForo: string;
    FsCdUltimMv: string;
    FscdVara: string;
    FsNuProcesso: string;
  public
    class function RetornaProcessoRelExtratoProc(psCdForo, psCDVara, psCdUltimMv: string): string;
  published
    property fpgcdVara: string read FscdVara write FscdVara;
    property fpgcdForo: string read FscdForo write FscdForo;
    property fpgCdUltimMv: string read FsCdUltimMv write FsCdUltimMv;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgRelExtratoProcModelTests }

class function TffpgRelExtratoProcModelTests.RetornaProcessoRelExtratoProc(
  psCdForo, psCDVara, psCdUltimMv: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarProcessoRelExtrato(1, psCdForo, psCDVara, psCdUltimMv);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('NUPROCESSO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

