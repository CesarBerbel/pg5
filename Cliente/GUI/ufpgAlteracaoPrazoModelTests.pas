unit ufpgAlteracaoPrazoModelTests;

interface

uses
  ufpgDataModelTests;

type
  TffpgAlteracaoPrazoModelTests = class(TfpgDataModelTests)
  private
    FsNuProcesso: string;
    FsCdClassificacao: string;
    FsJustificativa: string;
  public
    class function VerficarAlteracaoPrazo(psCDMandado, psCdClassificacao: string): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgCdClassificacao: string read FsCdClassificacao write FsCdClassificacao;
    property fpgJustificativa: string read FsJustificativa write FsJustificativa;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, SysUtils;

class function TffpgAlteracaoPrazoModelTests.VerficarAlteracaoPrazo(
  psCDMandado, psCdClassificacao: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerficarAlteracaoPrazo(psCDMandado, psCdClassificacao);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

