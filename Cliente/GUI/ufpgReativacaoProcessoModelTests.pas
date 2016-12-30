unit ufpgReativacaoProcessoModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgReativacaoProcessoModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FsMotivoReativacao: string;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgMotivoReativacao: string read FsMotivoReativacao write FsMotivoReativacao;
    class function RetornarProcessoReativado(psNuProcesso: string): boolean;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, SysUtils;

{ TffpgReativacaoProcessoModelTests }

class function TffpgReativacaoProcessoModelTests.RetornarProcessoReativado(
  psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerficarProcessoReativadoSQL(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

