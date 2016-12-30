unit ufpgCadRegSentencaModelTests;

interface

uses
  ufpgModelTests, SysUtils, usajConstante, uspFuncoesDate;

type
  TffpgCadRegSentencaModelTests = class(TfpgModelTests)
  private
    FsProcesso: string;
    FsTipoMovimento: string;
    FsCDCategoria: string;
    FsNuProcesso: string;

  public
    class function RetornaProcessoRegSentenca(psCDCategoria: string): string;
    class function VerificaProcessoRegSentenca(psCDTipoMovimento, psNuprocesso: string): boolean;
    class function VerificaRegistroSentenca(psNuprocesso: string): boolean;

  published
    property fpgProcesso: string read FsProcesso write FsProcesso;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgTipoMovimento: string read FsTipoMovimento write FsTipoMovimento;
    property fpgCDCategoria: string read FsCDCategoria write FsCDCategoria;
  end;

implementation

uses
  ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, usegRepositorio;

{ TffpgCadRegSentencaModelTests }

class function TffpgCadRegSentencaModelTests.RetornaProcessoRegSentenca(
  psCDCategoria: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarProcessoRegistroSentenca(psCdCategoria, 1);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('NUPROCESSO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadRegSentencaModelTests.VerificaProcessoRegSentenca(
  psCDTipoMovimento, psNuprocesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarProcessoRegSentenca(psCDTipoMovimento, psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('VERIFICA').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadRegSentencaModelTests.VerificaRegistroSentenca(
  psNuprocesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificaRegistroSentencaSQL(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

