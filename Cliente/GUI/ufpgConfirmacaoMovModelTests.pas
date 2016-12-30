unit ufpgConfirmacaoMovModelTests;

interface

uses
  ufpgModelTests, SysUtils, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

type
  TffpgConfirmacaoMovModelTests = class(TfpgModelTests)
  private
    FbVerificarDadosMov: boolean;
    FsNuProcesso: string;
    FsMovimentacao: string;
  public
    class function ChecarMovimentacao(psProcesso: string): boolean;
  published
    property fpgVerificarDadosMov: boolean read FbVerificarDadosMov write FbVerificarDadosMov;
    property fpgMovimentacao: string read FsMovimentacao write FsMovimentacao;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  end;

implementation

uses
  usegRepositorio;

{ TffpgConfirmacaoMovModelTests }

class function TffpgConfirmacaoMovModelTests.ChecarMovimentacao(psProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerifcarMovimetacoesLoteSql(psProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('CDPROCESSO').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

