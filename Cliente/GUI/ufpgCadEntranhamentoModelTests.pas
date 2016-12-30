// 21/12/2015 - cesar.almeida - SALT: 186660/23/2
// Refatoração da classe
unit ufpgCadEntranhamentoModelTests;

interface

uses
  ufpgModelTests, SysUtils, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

type
  TffpgCadEntranhamentoModelTests = class(TfpgModelTests)
  private
    FsNuProcessoApensar: string;
    FsNuProcesso: string;
    FsCDTipoMVProcesso: string;
  published
    class function Verificar(psCDTipoMVProcesso, psTipoMovimento, psProcessoPrincipal,
      psProcessoEntranhar: string): boolean;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgNuProcessoApensar: string read FsNuProcessoApensar write FsNuProcessoApensar;
    property fpgCDTipoMVProcesso: string read FsCDTipoMVProcesso write FsCDTipoMVProcesso;
  end;

implementation

uses
  usegRepositorio;

class function TffpgCadEntranhamentoModelTests.Verificar(psCDTipoMVProcesso,
  psTipoMovimento, psProcessoPrincipal, psProcessoEntranhar: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarEntranhamento(psCDTipoMVProcesso, psTipoMovimento,
      psProcessoPrincipal, psProcessoEntranhar);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('VERIFICOU').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

