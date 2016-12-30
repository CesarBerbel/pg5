unit ufpgEnvioRecursoEletronicoModelTests;

interface

uses
  ufpgModelTests, ADODB, FutureWindows, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests,
  SysUtils, usegRepositorio;

type
  TffpgEnvioRecursoEletronicoModelTests = class(TfpgModelTests)
  private
    FsTipoDoc: string;
    FsCertificado: string;
    FsSelecionarParte: string;
    FsCdJuiz: string;
    FsCdClasse: string;
    FsCdAssuntoSG: string;
    FsTipoParticipacaoAutor: string;
    FsTipoParticipacaoReu: string;
    FsQtdReus: string;
    FsNuProcesso: string;
  public
    class function ValidarDigDocumento(psNuprocesso: string;
      var psCdDocumento, psTipoDoc, psAssinado: string): boolean;
    class function VerificarSitProcesso(psSitProcesso: string; psNuprocesso: string): boolean;
  published
    property fpgTipoDoc: string read FsTipoDoc write FsTipoDoc;
    property fpgCertificado: string read FsCertificado write FsCertificado;
    property fpgCdClasse: string read FsCdClasse write FsCdClasse;
    property fpgCdAssuntoSG: string read FsCdAssuntoSG write FsCdAssuntoSG;
    property fpgCdJuiz: string read FsCdJuiz write FsCdJuiz;
    property fpgSelecionarParte: string read FsSelecionarParte write FsSelecionarParte;
    property fpgTipoParticipacaoAutor: string read FsTipoParticipacaoAutor write FsTipoParticipacaoAutor;
    property fpgTipoParticipacaoReu: string read FsTipoParticipacaoReu write FsTipoParticipacaoReu;
    property fpgQtdReus: string read FsQtdReus write FsQtdReus;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
  end;

implementation

class function TffpgEnvioRecursoEletronicoModelTests.ValidarDigDocumento(psNuprocesso: string;
  var psCdDocumento: string; var psTipoDoc: string; var psAssinado: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornaDigDocumento(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.RecordCount > 0;
    psCdDocumento := oSegRepositorio.FieldByName('CDDOCUMENTO').AsString;
    psTipoDoc := oSegRepositorio.FieldByName('CDTIPODOCDIGITAL').AsString;
    psAssinado := oSegRepositorio.FieldByName('FLASSINADO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgEnvioRecursoEletronicoModelTests.VerificarSitProcesso(psSitProcesso: string;
  psNuprocesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerficarSituacaoProcesso(psSitProcesso, psNuprocesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.RecordCount > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

