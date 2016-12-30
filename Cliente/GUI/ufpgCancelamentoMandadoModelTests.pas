unit ufpgCancelamentoMandadoModelTests;

interface

uses
  ufpgDataModelTests;

type
  TffpgCancelamentoMandadoModelTests = class(TfpgDataModelTests)
  private
    FsNuProcesso: string;
    FsJustificativa: string;
    FsCertificado: string;
    FsCDSituacao: string;
  public
    class function VerificarCancelamentoMandado(psCDMandado, psCDSituacao: string): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgJustificativa: string read FsJustificativa write FsJustificativa;
    property fpgCertificado: string read FsCertificado write FsCertificado;
    property fpgCDSituacao: string read FsCDSituacao write FsCDSituacao;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, SysUtils;

class function TffpgCancelamentoMandadoModelTests.VerificarCancelamentoMandado(
  psCDMandado, psCDSituacao: string): boolean;
var
  osegRepositorio: TesegRepositorio;                   
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerficarCancelamentoMandado(psCDMandado, psCDSituacao);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

