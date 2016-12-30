unit ufpgVirtualizarProcessoModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgVirtualizarProcessoModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
  public
    class function VerificarProcesso(psCDProcesso: string): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  end;

implementation

uses
  usegRepositorio, SysUtils, ufpgFuncoesGUISQLTests;

{ TffpgVirtualizarProcessoModelTests }

class function TffpgVirtualizarProcessoModelTests.VerificarProcesso(psCDProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarProcessoVirtualizadoSql(psCDProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

