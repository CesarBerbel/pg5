unit ufpgLogFluxoModelTests;

interface

uses
  ufpgLogFluxo, ufpgModelTests, SysUtils, usajConstante;

type
  TffpgLogFluxoModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  public
    //    class function RetornaProcessoRelExtratoProc: string;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgLogFluxoModelTests }

//06/08/2015 - LUCIANO.FAGUNDES - SALT: 186660/11/3
//class function TffpgLogFluxoModelTests.RetornaProcessoRelExtratoProc: string;
//var
//  osegRepositorio: TesegRepositorio;
//  sSQL: string;
//begin
//  oSegRepositorio := TesegRepositorio.Create(nil);
//  try
//    // 01/04/2016  - Carlos.Gaspar - SALT: 186660/25/1 - Comentado
//    //sSQL := RetornarProcessoRelExtrato(1);
//    //    sSQL := Format(SQL_RETORNA_PROCESSO_REL_EXTRATO, []); Não precisa do Format se não tem parâmetros
//    oSegRepositorio.SQLOpen(sSQL);
//    result := oSegRepositorio.FieldByName('NUPROCESSO').AsString;
//  finally
//    FreeAndNil(oSegRepositorio);
//  end;
//end;

end.

