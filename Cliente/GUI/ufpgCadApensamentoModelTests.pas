unit ufpgCadApensamentoModelTests;

interface

uses
  ufpgModelTests, usajConstante, SysUtils, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

type
  TffpgCadApensamentoModelTests = class(TfpgModelTests)
  private
    FsMotivo: string;
    FsNuProcessoApenso: string;
    FsNuProcesso: string;
    FsCdSituacaoProcesso: string;
    FbDesapensar: boolean;
    FbAbrirDoMenu: boolean;
    FbFecharTela: boolean;
    FbApensar: boolean;
  public
    class function VerificaApensamento(psCdProcesso, psCdSituacaoProcesso: string): boolean;
    class function RetornacdProcesso(psNuProcesso: string): string;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgNuProcessoApenso: string read FsNuProcessoApenso write FsNuProcessoApenso;
    property fpgMotivo: string read FsMotivo write FsMotivo;
    property fpgCdSituacaoProcesso: string read FsCdSituacaoProcesso write FsCdSituacaoProcesso;
    property fpgDesapensar: boolean read FbDesapensar write FbDesapensar;
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgFecharTela: boolean read FbFecharTela write FbFecharTela;
    property fpgApensar: boolean read FbApensar write FbApensar;
  end;

implementation

uses
  usegRepositorio;

class function TffpgCadApensamentoModelTests.VerificaApensamento(psCdProcesso,
  psCdSituacaoProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarApensamentoSql(psCdProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger >= 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadApensamentoModelTests.RetornacdProcesso(psNuProcesso: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarCdProcessoSql(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('CDPROCESSO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

//class function TffpgCadApensamentoModelTests.RetornarProcesso: string;
//var
//  osegRepositorio: TesegRepositorio;
//  sSQL: string;
//begin
//  oSegRepositorio := TesegRepositorio.Create(nil);
//  try
//    sSQL := SQL_RETORNA_PROCESSO_FISICO;
//    oSegRepositorio.SQLOpen(sSQL);
//    result := oSegRepositorio.FieldByName('NUPROCESSO').AsString;
//  finally
//    FreeAndNil(oSegRepositorio);
//  end;
//end;

//class function TffpgCadApensamentoModelTests.RetornarProcessoApenso: string;
//var
//  osegRepositorio: TesegRepositorio;
//  sSQL: string;
//begin
//  oSegRepositorio := TesegRepositorio.Create(nil);
//  try
//    sSQL := SQL_RETORNA_PROCESSO_APENSO;
//    oSegRepositorio.SQLOpen(sSQL);
//    result := oSegRepositorio.FieldByName('NUPROCESSO').AsString;
//  finally
//    FreeAndNil(oSegRepositorio);
//  end;
//end;


end.

