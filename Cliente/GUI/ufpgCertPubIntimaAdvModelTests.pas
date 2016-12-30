unit ufpgCertPubIntimaAdvModelTests;

interface

uses
  ufpgModelTests, ADODB;

type
  TffpgCertPubIntimaAdvModelTests = class(TfpgModelTests)
  private
    FbAbrirDoMenu: boolean;
    FsNuProcesso: string;
    FsNuRelacao: string;
    FsDtDisponibilizacao: string;
    FsNuFolhas: string;
    FsCdVara: string;
    FsCertificado: string;
    FsCdForo: string;
    FsTpMvProcesso: string;
    FsCdProcesso: string;
  public
    class function VerificarPublicacaoIntimacao(psCdForo, psCdVara, psCdProcesso,
      psNuRelacao, psTpMvProcesso: string): boolean;

  published
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgNuRelacao: string read FsNuRelacao write FsNuRelacao;
    property fpgDtDisponibilizacao: string read FsDtDisponibilizacao write FsDtDisponibilizacao;
    property fpgNuFolhas: string read FsNuFolhas write FsNuFolhas;
    property fpgCdVara: string read FsCdVara write FsCdVara;
    property fpgCertificado: string read FsCertificado write FsCertificado;
    property fpgCdForo: string read FsCdForo write FsCdForo;
    property fpgTpMvProcesso: string read FsTpMvProcesso write FsTpMvProcesso;
    property fpgCdProcesso: string read FsCdProcesso write FsCdProcesso;
  end;

implementation

{ TffpgCertPubIntimaAdvModelTests }

uses
  usegrepositorio, ufpgFuncoesGUISQLTests, SysUtils;

class function TffpgCertPubIntimaAdvModelTests.VerificarPublicacaoIntimacao(
  psCdForo, psCdVara, psCdProcesso, psNuRelacao, psTpMvProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarPublicacaoIntimacaoSQL(psCdForo, psCdVara, psCdProcesso,
      psNuRelacao, psTpMvProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

