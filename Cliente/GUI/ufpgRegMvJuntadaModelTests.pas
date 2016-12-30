unit ufpgRegMvJuntadaModelTests;

interface

uses
  ufpgModelTests, usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, SysUtils;

type
  TffpgRegMvJuntadaModelTests = class(TfpgModelTests)
  private
    FsNuAr: string;
    FsCdEstadoAR: string;
    FbImprimir: boolean;
  public
    class function VerificarJuntadaAR(psNuAr, psEstadaAR: string): boolean;
  published
    property fpgNuAr: string read FsNuAr write FsNuAr;
    property fpgCdEstadoAR: string read FsCdEstadoAR write FsCdEstadoAR;
    property fpgImprimir: boolean read FbImprimir write FbImprimir;
  end;

implementation

class function TffpgRegMvJuntadaModelTests.VerificarJuntadaAR(psNuAr: string;
  psEstadaAR: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarARJuntadaProcesso(psNuAr, psEstadaAR);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

