unit ufpgFluxoMandadosModelTests;

interface

uses
  SysUtils, ufpgDataModelTests, ADODB, FutureWindows, uspQuery, uspDUnitDAO, ufpgFuncoesSQLTests;

type
  TffpgFluxoMandadosModelTests = class(TfpgDataModelTests)
  private
    FsTipoEndereco: string;
  public
    class function VerificarVincRecColMand(psNuProcesso, psNuMandado, psCdGuia: string): boolean;
    class function VerificarPublicaPessoa(psNuProcesso: string): boolean;
  published
    property fpgTipoEndereco: string read FsTipoEndereco write FsTipoEndereco;
  end;

implementation

uses
  usegRepositorio;


{ TffpgFluxoMandadosModelTests }

class function TffpgFluxoMandadosModelTests.VerificarVincRecColMand(
  psNuProcesso, psNuMandado, psCdGuia: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornaVerificaVincrecolMand(psNuProcesso, psNuMandado, psCdGuia);
    oSegRepositorio.SQLOpen(sSQL);
    result := (oSegRepositorio.FieldByName('EXISTE').AsInteger > 0);
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgFluxoMandadosModelTests.VerificarPublicaPessoa(psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    // 20/11/2015  - Carlos.Gaspar - SALT: 186660/22/6
    // Alteração do SQL para todas as bases de dados
    sSQL := RetornaPublicaPessoa(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := (oSegRepositorio.FieldByName('EXISTE').AsInteger > 0);
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

