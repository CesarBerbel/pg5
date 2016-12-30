unit ufpgDocumentoPG5Tests;

interface

uses
  TestFramework, Classes, uspCLientDataset, ufpgDocumentoPG5;

type
  TDocumentoPG5Fake = class(TDocumentoPG5)
  private
    class procedure CriarDatasetDadosValidadeMandado(pocdsDados: TspClientDataSet);
  public
    class function ConsultarDadosDoDocumentoMandado(const pncdDocumento: double;
      pvspDB: variant): olevariant; override;
  end;

  TDocumentoPG5Tests = class(TTestCase)
  private
    //FDocumentoPG5: TDocumentoPG5Fake;
    class procedure AppendStringList(poDataset: TspClientDataset; const psValores: string);
  published
    procedure TestarValidarDataDeValidadeDoMandadoParaFinalizacaoMandadoComDataValida;
    procedure TestarValidarDataDeValidadeDoMandadoParaFinalizacaoMandadoComDataInvalida;
    procedure TestarValidarDataDeValidadeDoMandadoParaFinalizacaoMandadoNaoEhMandadodePrisao;
    procedure TestarValidarDataDeValidadeDoMandadoParaFinalizacaoMandadoSemData;
    procedure TestarPodeFinalizarMandadoComValidadeComDataValida;
    procedure TestarPodeFinalizarMandadoComValidadeComDataInvalida;
  end;

implementation

uses
  SysUtils, DB, usajConstante, ufpgMensagem2;

const
  sDATAFINALIZACAO = '27/04/2013';

{ TDocumentoPG5Tests }

class procedure TDocumentoPG5Tests.AppendStringList(poDataset: TspClientDataset;
  const psValores: string);
var
  i: integer;
  oListAdd: TStringList;
begin
  oListAdd := TStringList.Create;
  try
    oListAdd.CommaText := psValores;
    poDataset.Append;
    for i := 0 to oListAdd.Count - 1 do
    begin
      poDataset.Fields[i].AsString := oListAdd[i];
    end;
    poDataset.Post;
  finally
    oListAdd.Free;
  end;
end;

procedure TDocumentoPG5Tests.TestarPodeFinalizarMandadoComValidadeComDataInvalida;
begin
  checkFalse(TDocumentoPG5Fake.TestarPodeFinalizarMandadoComValidade(
    StrToDate(sDATAFINALIZACAO), StrToDate('27/01/2013')));
end;

procedure TDocumentoPG5Tests.TestarPodeFinalizarMandadoComValidadeComDataValida;
begin
  checktrue(TDocumentoPG5Fake.TestarPodeFinalizarMandadoComValidade(StrToDate(sDATAFINALIZACAO),
    StrToDate('27/10/2013')));
end;

procedure TDocumentoPG5Tests.TestarValidarDataDeValidadeDoMandadoParaFinalizacaoMandadoComDataInvalida;
var
  sMsgErro: WideString;
  nCdErro: double;
begin
  sMSGERRO := STRING_INDEFINIDO;
  nCdErro := NUMERO_INDEFINIDO;
  checkFalse(TDocumentoPG5Fake.ValidarDataDeValidadeDoMandadoParaFinalizacao(1300, 6,
    StrToDate(sDATAFINALIZACAO), 3, nCdErro, sMSGERRO, null));
  checktrue(nCdErro = n_avFPGNaoFinalizaMandadoPrisaoDataDeValidadeMenorDataDeFinalizacao);
end;

procedure TDocumentoPG5Tests.TestarValidarDataDeValidadeDoMandadoParaFinalizacaoMandadoComDataValida;
var
  sMsgErro: WideString;
  nCdErro: double;
begin
  sMSGERRO := STRING_INDEFINIDO;
  nCdErro := NUMERO_INDEFINIDO;
  checktrue(TDocumentoPG5Fake.ValidarDataDeValidadeDoMandadoParaFinalizacao(1100, 6,
    StrToDate(sDATAFINALIZACAO), 3, nCdErro, sMSGERRO, null));
end;

procedure TDocumentoPG5Tests.
TestarValidarDataDeValidadeDoMandadoParaFinalizacaoMandadoNaoEhMandadodePrisao;
var
  sMsgErro: WideString;
  nCdErro: double;
begin
  sMSGERRO := STRING_INDEFINIDO;
  nCdErro := NUMERO_INDEFINIDO;
  checktrue(TDocumentoPG5Fake.ValidarDataDeValidadeDoMandadoParaFinalizacao(1200, 1,
    StrToDate(sDATAFINALIZACAO), 3, nCdErro, sMSGERRO, null));
end;

procedure TDocumentoPG5Tests.TestarValidarDataDeValidadeDoMandadoParaFinalizacaoMandadoSemData;
var
  sMsgErro: WideString;
  nCdErro: double;
begin
  sMSGERRO := STRING_INDEFINIDO;
  nCdErro := NUMERO_INDEFINIDO;
  checkFalse(TDocumentoPG5Fake.ValidarDataDeValidadeDoMandadoParaFinalizacao(1400, 6,
    StrToDate(sDATAFINALIZACAO), 3, nCdErro, sMSGERRO, null));
  checktrue(nCdErro = n_avFPGNaoFinalizaMandadoPrisaoDataDeValidadeMenorDataDeFinalizacao);
end;

{ TDocumentoPG5Fake }

class function TDocumentoPG5Fake.ConsultarDadosDoDocumentoMandado(const pncdDocumento: double;
  pvspDB: variant): olevariant;
var
  ocdsDados: TspClientDataSet;
begin
  ocdsDados := TspClientDataSet.Create(nil);
  try
    CriarDatasetDadosValidadeMandado(ocdsDados);
    ocdsDados.Active := True;

    TDocumentoPG5Tests.AppendStringList(ocdsDados, '1101,1100,S,27/10/2013');
    TDocumentoPG5Tests.AppendStringList(ocdsDados, '1102,1200,N,');
    TDocumentoPG5Tests.AppendStringList(ocdsDados, '1103,1300,S,27/01/2013');
    TDocumentoPG5Tests.AppendStringList(ocdsDados, '1103,1400,S,');

    ocdsDados.filter := 'cdDocumento = ' + FloatToStr(pncdDocumento);
    ocdsDados.filtered := True;

    result := ocdsDados.spDadosFiltrados;
  finally
    ocdsDados.Free;
  end;
end;

class procedure TDocumentoPG5Fake.CriarDatasetDadosValidadeMandado(pocdsDados: TspClientDataSet);
begin
  pocdsDados.FieldDefs.Add('CDMANDADO', ftString, 7);
  pocdsDados.FieldDefs.Add('CDDOCUMENTO', ftFloat);
  pocdsDados.FieldDefs.Add('CC_FLMANDADOPRISAO', ftString, 1);
  pocdsDados.FieldDefs.Add('CC_DTVALIDADEMAND', ftDate);
  pocdsDados.CreateDataSet;
end;

initialization

  TestFramework.RegisterTest('Unitário\PG5\Componentes\ufpgDocumentoPG5Tests',
    TDocumentoPG5Tests.Suite);

end.

