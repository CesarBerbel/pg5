unit ufpgCadMovimentacaoUnitariaGUIModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgCadMovimentacaoUnitariaGUIModelTests = class(TfpgModelTests)
  private
    FbAbrirDoMenu: boolean;
    FsNuProcesso: string;
    FsCdTipoMvProcesso: string;
    FbVerificarPendencia: boolean;
    fbVerificarMovimentacao: boolean;
    FbGrauRecurso: boolean;
    FsVerificarBaixaProcesso: boolean;
    FsRegistraMensagemBaixa: boolean;
    FbVerificarMotivo: boolean;
    FbPublicarMov: boolean;
    FsComplemento: string;


  public
    class function VerficarMovUnitaria(psTpMovimentacao: string; psNuProcesso: string;
      psCondicao: string = ''): boolean;
    class function VerificarSituacaoBaixadaPrincipal(psNuProcesso: string): boolean;
    class function VerificarSituacaoBaixadaDependente(psNuProcesso: string): boolean;
    class function VerificarDesvincularDocumento(psNuProcesso: string): boolean;

  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgCdTipoMvProcesso: string read FsCdTipoMvProcesso write FsCdTipoMvProcesso;
    property fpgVerificarPendencia: boolean read FbVerificarPendencia write FbVerificarPendencia;
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgVerificarMovimentacao: boolean read FbVerificarMovimentacao   
      write FbVerificarMovimentacao;
    property fpgGrauRecurso: boolean read FbGrauRecurso write FbGrauRecurso;
    property fpgVerificarBaixaProcesso: boolean read FsVerificarBaixaProcesso   
      write FsVerificarBaixaProcesso;
    property fpgRegistraMensagemBaixa: boolean read FsRegistraMensagemBaixa   
      write FsRegistraMensagemBaixa;
    property fpgVerificarMotivo: boolean read FbVerificarMotivo write FbVerificarMotivo;
    property fpgPublicarMov: boolean read FbPublicarMov write FbPublicarMov;
    property fpgComplemento: string read FsComplemento write FsComplemento;


  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, SysUtils;

{ TffpgConsProcBasicaModelTests }

class function TffpgCadMovimentacaoUnitariaGUIModelTests.VerficarMovUnitaria(
  psTpMovimentacao: string; psNuProcesso: string; psCondicao: string = ''): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarMovUnitariaSql(psTpMovimentacao, psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadMovimentacaoUnitariaGUIModelTests.VerificarSituacaoBaixadaDependente(
  psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarSituacaoProcesso(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('CDSITUACAOPROCESSO').AsString <> 'B';
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadMovimentacaoUnitariaGUIModelTests.VerificarSituacaoBaixadaPrincipal(
  psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarSituacaoProcesso(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('CDSITUACAOPROCESSO').AsString = 'B';
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadMovimentacaoUnitariaGUIModelTests.VerificarDesvincularDocumento(
  psNuProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarDesvincularDocumentoDoc(psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('CDIMAGEM').AsString = '11';
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

