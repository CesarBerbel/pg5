unit ufpgRelAnaliticoDistribModelTests;

interface

uses
  ufpgRelAnaliticoDistrib, ufpgModelTests, SysUtils, usajConstante;

type
  TffpgRelAnaliticoDistribModelTests = class(TfpgModelTests)
  private
    FsDataInicio: string;
    FsDataFim: string;
    FsCompetencia: string;
    FsClasse: string;
    FsHoraFim: string;
    FscdForo: string;
    FsCdUltimMv: string;
    FscdVara: string;
    FbRelClasseCompleta: boolean;
    FbRelPeriodo: boolean;
    FsNuProcesso: string;
  public
    class function RetornaProcessoRelAnalitico(psCdForo, psCDVara, psCdUltimMv: string): string;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgDataInicio: string read FsDataInicio write FsDataInicio;
    property fpgDataFim: string read FsDataFim write FsDataFim;
    property fpgClasse: string read FsClasse write FsClasse;
    property fpgCompetencia: string read FsCompetencia write Fscompetencia;
    // 13/01/2016 - Felipe.s SALT:186660/23/8
    property fpgHoraFim: string read FsHoraFim write FsHoraFim;
    property fpgcdVara: string read FscdVara write FscdVara;
    property fpgcdForo: string read FscdForo write FscdForo;
    property fpgCdUltimMv: string read FsCdUltimMv write FsCdUltimMv;
    property fpgRelPeriodo: boolean read FbRelPeriodo write FbRelPeriodo;
    property fpgRelClasseCompleta: boolean read FbRelClasseCompleta write FbRelClasseCompleta;

  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgRelAnaliticoDistribModelTests }
                                                                                        
//28/07/2015 - LUCIANO.FAGUNDES - SALT: 186660/9/2
class function TffpgRelAnaliticoDistribModelTests.RetornaProcessoRelAnalitico(
  psCdForo, psCDVara, psCdUltimMv: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarProcessoRelAnaliticoSql(psCdForo, psCDVara, psCdUltimMv);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('NUPROCESSO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

