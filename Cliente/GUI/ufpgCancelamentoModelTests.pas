unit ufpgCancelamentoModelTests;

interface

uses
  ufpgCancelamento, ufpgModelTests, SysUtils, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

type
  TffpgCancelamentoModelTests = class(TfpgModelTests)
  private
    FsLotacao: string;
    FsNuProcesso: string;
    FsTipoCarga: string;
    FsNulote: string;
    FsPreencherNuProcesso: boolean;
    FsPreencherNuLote: boolean;
    FsSenhaConfirmacao: string;
    FsTpLocalDestino: string;
  public
    class function VerificarProcessoRecebido(psNuLote: string; psNuprocesso: string;
      psTpLocalDestino: string): boolean;
    class function VerificarProcessoRemetido(psNuLote: string; psNuprocesso: string;
      psTpLocalDestino: string): boolean;
    class function VerificarProcessoCancelamento(psNuLote, psNuprocesso,
      psTpLocalDestino: string): boolean;
  published
    property fpgLotacao: string read FsLotacao write FsLotacao;
    property fpgNulote: string read FsNulote write FsNulote;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgTipoCarga: string read FsTipoCarga write FsTipoCarga;
    property fpgPreencherNuProcesso: boolean read FsPreencherNuProcesso 
      write FsPreencherNuProcesso;
    property fpgPreencherNuLote: boolean read FsPreencherNuLote write FsPreencherNuLote;
    property fpgSenhaConfirmacao: string read FsSenhaConfirmacao write FsSenhaConfirmacao;
    property fpgTpLocalDestino: string read FsTpLocalDestino write FsTpLocalDestino;
  end;

implementation

uses
  usegRepositorio;

{ TffpgCancelamentoModelTests }

//05/10/2015 - ANTONIO.SOUSA - SALT: 186660/20/2
class function TffpgCancelamentoModelTests.VerificarProcessoRemetido(psNuLote: string;
  psNuprocesso: string; psTpLocalDestino: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarProcessoRemetidoSql(psNuLote, psNuProcesso, psTpLocalDestino);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('REMETIDO').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

//05/10/2015 - ANTONIO.SOUSA - SALT: 186660/20/2
class function TffpgCancelamentoModelTests.VerificarProcessoRecebido(psNuLote: string;
  psNuprocesso: string; psTpLocalDestino: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarProcessoRecebidoSql(psNuLote, psNuProcesso, psTpLocalDestino);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('RECEBIDO').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

//05/10/2015 - ANTONIO.SOUSA - SALT: 186660/20/2
class function TffpgCancelamentoModelTests.VerificarProcessoCancelamento(psNuLote: string;
  psNuprocesso: string; psTpLocalDestino: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarProcessoRecebidoSql(psNuLote, psNuProcesso, psTpLocalDestino);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('RECEBIDO').AsInteger = 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.
 
