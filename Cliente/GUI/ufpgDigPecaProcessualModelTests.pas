unit ufpgDigPecaProcessualModelTests;

interface

uses
  ufpgModelTests, ADODB, FutureWindows;

type
  TffpgDigPecaProcessualModelTests = class(TfpgModelTests)
  private
    FsProcesso: string;
    FsProcessoCopia: string;
    FsNuProcesso: string;
    FsOrigem: string;
    FsTipoDoc: string;
    FsCertificado: string;
    FsDescricaoTipoDoc: string;
    FsTipoDoc2: string;
    FsDescricaoTipoDoc2: string;
    fsTipoMv: string;
    fbAbrirDoMenu: boolean;
    FbRecategorizarPeca: boolean;
    FbTornarDocSigiloso: boolean;
    FbImportarArquivos: boolean;
    FbLiberarNosAutos: boolean;
    FbDigitalizarPecas: boolean;
    FbAlterarTpDoc: boolean;
    FbGrauRecurso: boolean;
  public
    property fpgProcesso: string read FsProcesso write FsProcesso;
    class function ValidarDigDocumento(psNuprocesso: string; var psCdDocumento: string;
      var psTipoDoc: string; var psAssinado: string): boolean;
    class function ValidarMvProcesso(psNuprocesso, psTipoMv: string): boolean;
    class function ValidarDocSigilo(psNuprocesso: string): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgProcessoCopia: string read FsProcessoCopia write FsProcessoCopia;
    property fpgOrigem: string read FsOrigem write FsOrigem;
    property fpgTipoDoc: string read FsTipoDoc write FsTipoDoc;
    property fpgCertificado: string read FsCertificado write FsCertificado;
    property fpgDescricaoTipoDoc: string read FsDescricaoTipoDoc write FsDescricaoTipoDoc;
    property fpgTipoDoc2: string read FsTipoDoc2 write FsTipoDoc2;
    property fpgDescricaoTipoDoc2: string read FsDescricaoTipoDoc2 write FsDescricaoTipoDoc2;
    property fpgTipoMv: string read fsTipoMv write fsTipoMv;
    property fpgAbrirDoMenu: boolean read fbAbrirDoMenu write fbAbrirDoMenu;
    property fpgRecategorizarPeca: boolean read FbRecategorizarPeca write FbRecategorizarPeca;
    property fpgTornarDocSigiloso: boolean read FbTornarDocSigiloso write FbTornarDocSigiloso;
    property fpgLiberarNosAutos: boolean read FbLiberarNosAutos write FbLiberarNosAutos;
    property fpgImportarArquivos: boolean read FbImportarArquivos write FbImportarArquivos;
    property fpgDigitalizarPecas: boolean read FbDigitalizarPecas write FbDigitalizarPecas;
    property fpgAlterarTpDoc: boolean read FbAlterarTpDoc write FbAlterarTpDoc;
    property fpgGrauRecurso: boolean read FbGrauRecurso write FbGrauRecurso;
  end;

implementation

uses
  usegRepositorio, SysUtils, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

// 21/10/2015 leandro.humbert SALT:186660/20/8
class function TffpgDigPecaProcessualModelTests.ValidarDigDocumento(psNuprocesso: string;
  var psCdDocumento: string; var psTipoDoc: string; var psAssinado: string): boolean;
  //var
  //  osegRepositorio: TesegRepositorio;
  //  sSQL: string;
begin
  result := True;
  //  oSegRepositorio := TesegRepositorio.Create(nil);
  //  try
  //    sSQL := RetornaDigDocumento(psNuProcesso);
  //    oSegRepositorio.SQLOpen(sSQL);
  //    result := oSegRepositorio.RecordCount > 0;
  //    psCdDocumento := oSegRepositorio.FieldByName('CDDOCUMENTO').AsString;
  //    psTipoDoc := oSegRepositorio.FieldByName('CDTIPODOCDIGITAL').AsString;
  //    psAssinado := oSegRepositorio.FieldByName('FLASSINADO').AsString;
  //  finally
  //    FreeAndNil(oSegRepositorio);
  //  end;
end;

// 22/10/2015 leandro.humbert SALT:186660/20/8
class function TffpgDigPecaProcessualModelTests.ValidarMvProcesso(psNuprocesso,
  psTipoMv: string): boolean;
  //var
  //  osegRepositorio: TesegRepositorio;
  //  sSQL: string;
begin
  result := True;
  //  oSegRepositorio := TesegRepositorio.Create(nil);
  //  try
  //    //02/12/2015 cesar.almeida SALT:186660/23/2
  //    sSQL := VerificarMovUnitariaSql(psTipoMv, psNuProcesso);
  //    oSegRepositorio.SQLOpen(sSQL);
  //    result := oSegRepositorio.RecordCount > 0;
  //  finally
  //    FreeAndNil(oSegRepositorio);
  //  end;
end;

// 22/10/2015 felipe.s SALT:186660/20/8
class function TffpgDigPecaProcessualModelTests.ValidarDocSigilo(psNuprocesso: string): boolean;
  //var
  //  osegRepositorio: TesegRepositorio;
  //  sSQL: string;
begin
  result := True;
  //  oSegRepositorio := TesegRepositorio.Create(nil);
  //  try
  //    sSQL := RetornaVerificarStatusSigilo(psNuProcesso);
  //    oSegRepositorio.SQLOpen(sSQL);
  //    result := oSegRepositorio.FieldByName('FLSIGILOEXTERNO').AsString = 'S';
  //  finally
  //    FreeAndNil(oSegRepositorio);
  //  end;
end;

end.
  
