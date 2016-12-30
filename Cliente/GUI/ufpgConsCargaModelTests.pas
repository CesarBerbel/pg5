unit ufpgConsCargaModelTests;

interface

uses
  ufpgConsCarga, ufpgModelTests, SysUtils, usajConstante;

type
  TffpgConsCargaModelTests = class(TfpgModelTests)
  private
    FsDataRecebimento: string;
    FsLocalDestino: string;
    FsNuProcesso: string;
    FsLocalOrigem: string;
    FsDataFim: string;
    FsDataRemessa: string;
    FsLote: string;
    FsDataInicio: string;
    FsLotacao: string;
    FbProcExterno: boolean;
    FsUsuario: string;
    FsForoDestino: string;
    FsUsuarioJuiz: string;
    FsLotacaoJuiz: string;

  public
    class function VerificarARRemetidoNaoRecebido(psAr, psLote: string): boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgDataInicio: string read FsDataInicio write FsDataInicio;
    property fpgDataFim: string read FsDataFim write FsDataFim;
    property fpgLote: string read FsLote write FsLote;
    property fpgLocalOrigem: string read FsLocalOrigem write FsLocalOrigem;
    property fpgDataRemessa: string read FsDataRemessa write FsDataRemessa;
    property fpgLocalDestino: string read FsLocalDestino write FsLocalDestino;
    property fpgDataRecebimento: string read FsDataRecebimento write FsDataRecebimento;
    property fpgLotacao: string read FsLotacao write FsLotacao;
    property fpgProcExterno: boolean read FbProcExterno write FbProcExterno;
    property fpgUsuario: string read FsUsuario write FsUsuario;
    property fpgForoDestino: string read FsForoDestino write FsForoDestino;
    property fpgUsuarioJuiz: string read FsUsuarioJuiz write FsUsuarioJuiz;
    property fpgLotacaoJuiz: string read FsLotacaoJuiz write FsLotacaoJuiz;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

{ TffpgConsCargaModelTests }

class function TffpgConsCargaModelTests.VerificarARRemetidoNaoRecebido(psAr,
  psLote: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarARRemetidoNaoRecebido(psLote, psAr);
    //sSQL := Format(SQL_AR_REMETIDO_NAO_RECEBIDO, [quotedstr(psAr), quotedstr(psLote)]);
    //Não foi revisado, parametros de entrada invertidos, teste quebrado
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('EXISTE').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

