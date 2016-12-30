unit ufpgCadMandadoExcepcionalModelTests;

interface

uses
  ufpgCadMandadoExcepcional, ufpgModelTests, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, SysUtils;

type
  TffpgCadMandadoExcepcionalModelTests = class(TfpgModelTests)
  private
    FsCdModelo: string;
    FsNuProcesso: string;
    FsTipoParte: string;
    FsClassificacao: string;
    FsEscrivao: string;
  published
    class function VerificarMandadoCriado(psNuModelo, psNuprocesso: string): string;
    property fpgCdModelo: string read FsCdModelo write FsCdModelo;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgTipoParte: string read FsTipoParte write FsTipoParte;
    property fpgClassificacao: string read FsClassificacao write FsClassificacao;
    property fpgEscrivao: string read FsEscrivao write FsEscrivao;
  end;

implementation

uses
  usegRepositorio;

{ TffpgCadMandadoExcepcionalModelTests }

class function TffpgCadMandadoExcepcionalModelTests.VerificarMandadoCriado(psNuModelo: string;
  psNuprocesso: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarMandadoExcepcional(psNuModelo, psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('NUMANDADO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

