unit ufpgDesmembraProcModelTests;

interface

uses
  ufpgModelTests, SysUtils, uspClientDataSet;

type
  TffpgDesmembraProcModelTests = class(TfpgModelTests)
  private
    FsNuProcessoPrinc: string;
    FsNuProcessoDes: string;
    FsCertificado: string;

  public
    class function VerificaProcessoDesmembrado(psNuProcesso, psNome, psSituacao: string): boolean;
  published
    property fpgNuProcessoPrinc: string read FsNuProcessoPrinc write FsNuProcessoPrinc;
    property fpgNuProcessoDes: string read FsNuProcessoDes write FsNuProcessoDes;
    property fpgCertificado: string read FsCertificado write FsCertificado;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgRelDemoDistribModelTests }

//25/10/2016 - Raphael.Whitlock - Task: 67003
class function TffpgDesmembraProcModelTests.VerificaProcessoDesmembrado(
  psNuProcesso, psNome, psSituacao: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarProcessoNovoDesmembrado(psNuProcesso, psNome, psSituacao);
    oSegRepositorio.SQLOpen(sSQL);
    result := (oSegRepositorio.FieldByName('ACHOU').AsInteger = 1);
  finally
    FreeAndNil(oSegRepositorio);
  end;

end;

end.

