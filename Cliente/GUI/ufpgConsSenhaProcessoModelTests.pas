unit ufpgConsSenhaProcessoModelTests;

interface

uses
  ufpgModelTests, ADODB, SysUtils, FutureWindows, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

type
  TffpgConsSenhaProcessoModelTests = class(TfpgModelTests)

  private
    FbImpressaoOficio: boolean;
    FbGerarSenha: boolean;
    FsNuProcesso: string;
    FsEnviarEmail: boolean;
    FsEmail: string;
    FsOutroNumero: string;
    FsTipoParte: string;
    FsNmParte: string;
    FsImprimirOficioParaTodos: boolean;
    FsEnviarEmaiParaTodos: boolean;
    FsPreencherOutroNumero: boolean;
    FbSelecionarPessoa: boolean;
    FbVerificarHistorico: boolean;
  public
    class function VerificarSenhaGerada(psCdProcesso: string; psNomeParte: string): boolean;
    class function VerificarOficioImpresso(psOperacao: string): boolean;
    class function VerificarEmailEnviado(psNmParte: string): boolean;
    //20/10/2016 - Shirleano.Junior - Task: 669730
    class function RetornarSenhaProcesso(psCdProcesso, psNuSeqSenha: string): string;
  published
    property fpgImpressaoOficio: boolean read FbImpressaoOficio write FbImpressaoOficio;
    property fpgGerarSenha: boolean read FbGerarSenha write FbGerarSenha;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgNuProcessoApensar: string read FsNuProcesso write FsNuProcesso;
    property fpgEnviarEmail: boolean read FsEnviarEmail write FsEnviarEmail;
    property fpgEmail: string read FsEmail write FsEmail;
    property fpgOutroNumero: string read FsOutroNumero write FsOutroNumero;
    property fpgTipoParte: string read FsTipoParte write FsTipoParte;
    property fpgNmParte: string read FsNmParte write FsNmParte;
    property fpgImprimirOficioParaTodos: boolean 
      read FsImprimirOficioParaTodos   write FsImprimirOficioParaTodos;
    property fpgEnviarEmaiParaTodos: boolean read FsEnviarEmaiParaTodos 
      write FsEnviarEmaiParaTodos;
    property fpgPreencherOutroNumero: boolean read FsPreencherOutroNumero 
      write FsPreencherOutroNumero;
    property fpgSelecionarPessoa: boolean read FbSelecionarPessoa write FbSelecionarPessoa;
    property fpgVerificarHistorico: boolean read FbVerificarHistorico write FbVerificarHistorico;

  end;

implementation

uses
  usegRepositorio;

{ TffpgConsSenhaProcessoModelTests }

//25/09/2015 - ANTONIO.SOUSA - SALT: 186660/19/3
class function TffpgConsSenhaProcessoModelTests.VerificarSenhaGerada(psCdProcesso: string;
  psNomeParte: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarSenhaGerada(psCdProcesso, psNomeParte);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

//25/09/2015 - ANTONIO.SOUSA - SALT: 186660/19/3
class function TffpgConsSenhaProcessoModelTests.VerificarOficioImpresso(
  psOperacao: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarOficioImpresso(psOperacao);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

//25/09/2015 - ANTONIO.SOUSA - SALT: 186660/19/3
class function TffpgConsSenhaProcessoModelTests.VerificarEmailEnviado(psNmParte: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarEmailRecebido(psNmParte);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('TOTAL').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

//20/10/2016 - Shirleano.Junior - Task: 66973
class function TffpgConsSenhaProcessoModelTests.RetornarSenhaProcesso(
  psCdProcesso, psNuSeqSenha: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarSenhaGeradaSQL(psCdProcesso, psNuSeqSenha);
    osegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('nmSenha').AsString;
  finally
    FreeAndNil(osegRepositorio);
  end;
end;

end.

