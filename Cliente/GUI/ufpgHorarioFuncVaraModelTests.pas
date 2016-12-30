unit ufpgHorarioFuncVaraModelTests;

interface

uses
  ufpgModelTests, SysUtils, ufpgFuncoesSQLTests, usegRepositorio;

type
  TffpgHorarioFuncVaraModelTests = class(TfpgModelTests)
  private
    FsHoraInicio: string;
    FsHoraFim: string;
    FsCdForo: string;
    FsCdVara: string;
  public
    // 26/10/2016  - Carlos.Gaspar - TASK: 66977
    class function ValidacaoHorarioAtendimento(psCdForo: string; psCdVara: string;
      psNmAlias: string; psHorario: string): boolean;
  published
    property fpgCdForo: string read FsCdForo write FsCdForo;
    property fpgCdVara: string read FsCdVara write FsCdVara;
    property fpgHoraInicio: string read FsHoraInicio write FsHoraInicio;
    property fpgHoraFim: string read FsHoraFim write FsHoraFim;
  end;


implementation

// 26/10/2016  - Carlos.Gaspar - TASK: 66977
class function TffpgHorarioFuncVaraModelTests.ValidacaoHorarioAtendimento(psCdForo: string;
  psCdVara: string; psNmAlias: string; psHorario: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := ValidarHorarioAtendimento(psCdForo, psCdVara, psNmAlias, psHorario);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('QTDE').AsInteger > 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

