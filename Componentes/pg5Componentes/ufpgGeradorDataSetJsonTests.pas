unit ufpgGeradorDataSetJsonTests;

interface

uses
  ufpgConversorDataSetJson, TestFrameWork, uspTestCase, ufpgGeradorDataSetJson,
  DB, DBClient, Classes;

type
  TfpgGeradorDataSetJsonTests = class(TspTestCase)
  private
    FoGeradorDataSetJson: TfpgGeradorDataSetJson;
    FoConversorDataSetJson: TfpgConversorDataSetJson;
    function DefinirDataSetPadrao: TClientDataSet;
    procedure AdicionarRegistroDataSet(const psDescricao, psValor: string;
      psTipoCampo: TFlTipoCampo; pcdsDestino: TClientDataSet);
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarGeradorRegistroBasico;
    procedure TestarGeradorRegistroComMultiplosValores;
    procedure TestarGeradorRegistroComMultiplosValoresEChaveVazia;
  end;

implementation

uses
  SysUtils;

procedure TfpgGeradorDataSetJsonTests.SetUp;
begin
  FoGeradorDataSetJson := TfpgGeradorDataSetJson.Create; //PC_OK
  FoConversorDataSetJson := TfpgConversorDataSetJson.Create; //PC_OK
end;

procedure TfpgGeradorDataSetJsonTests.TearDown;
begin
  FreeAndNil(FoGeradorDataSetJson); //PC_OK
  FreeAndNil(FoConversorDataSetJson); //PC_OK
end;

procedure TfpgGeradorDataSetJsonTests.TestarGeradorRegistroBasico;
const
  sRET_JSON = '{"Nome":"João"}';
var
  sRetorno: string;
begin
  FoGeradorDataSetJson.AdicionarRegistro('Nome', fsString, 'João');
  sRetorno := FoConversorDataSetJson.RetornarJson(FoGeradorDataSetJson.fpgDados);
  checktrue(sRetorno = sRET_JSON, 'O teste esperava o retorno ' + sRET_JSON +
    ', e foi retornado: ' + sRetorno);
end;

procedure TfpgGeradorDataSetJsonTests.TestarGeradorRegistroComMultiplosValores;
const
  sRET_JSON = '{"Tipo":"Carro", "Dados":{"Nome":"Vectra", "Ano":1987}}';
var
  cdsDados: TClientDataSet;
  sRetorno: string;
begin
  cdsDados := DefinirDataSetPadrao;  //PC_OK
  try
    AdicionarRegistroDataSet('Nome', 'Vectra', fsString, cdsDados);
    AdicionarRegistroDataSet('Ano', '1987', fsDouble, cdsDados);
    FoGeradorDataSetJson.AdicionarRegistro('Tipo', fsString, 'Carro');
    FoGeradorDataSetJson.AdicionarRegistro('Dados', fsDataset, cdsDados.Data);

    sRetorno := FoConversorDataSetJson.RetornarJson(FoGeradorDataSetJson.fpgDados);
    checktrue(sRetorno = sRET_JSON, 'O teste esperava o retorno ' + sRET_JSON +
      ' e o retorno foi:' + sRetorno);
  finally
    FreeAndNil(cdsDados); //PC_OK
  end;
end;

procedure TfpgGeradorDataSetJsonTests.TestarGeradorRegistroComMultiplosValoresEChaveVazia;
const
  sRET_JSON = '{"Tipo":"Carro", "Dados":{}}';
var
  sRetorno: string;
begin
  FoGeradorDataSetJson.AdicionarRegistro('Tipo', fsString, 'Carro');
  FoGeradorDataSetJson.AdicionarRegistro('Dados', fsDataset, null);

  sRetorno := FoConversorDataSetJson.RetornarJson(FoGeradorDataSetJson.fpgDados);
  checktrue(sRetorno = sRET_JSON, 'O teste esperava o retorno ' + sRET_JSON +
    ' e o retorno foi:' + sRetorno);
end;

function TfpgGeradorDataSetJsonTests.DefinirDataSetPadrao: TClientDataSet;
begin
  result := TClientDataSet.Create(nil); //PC_OK
  result.FieldDefs.Add(sCAMPO_DESCRICAO, ftString, 50);
  result.FieldDefs.Add(sCAMPO_TIPO, ftString, 1);
  result.FieldDefs.Add(sCAMPO_VALOR, ftBlob);
  result.CreateDataSet;
  result.Open;
end;

procedure TfpgGeradorDataSetJsonTests.AdicionarRegistroDataSet(const psDescricao, psValor: string;
  psTipoCampo: TFlTipoCampo; pcdsDestino: TClientDataSet);
begin
  pcdsDestino.Append;
  pcdsDestino.FieldByName(sCAMPO_DESCRICAO).AsString := psDescricao;
  pcdsDestino.FieldByName(sCAMPO_TIPO).AsString := aTFlTipoCampo[psTipoCampo];
  TBlobField(pcdsDestino.FieldByName(sCAMPO_VALOR)).Value := psValor;
  pcdsDestino.Post;
end;

initialization
  TestFrameWork.RegisterTest('Unitário\PG5\Servidor\ufpgGeradorDataSetJsonTests',
    TfpgGeradorDataSetJsonTests.Suite);

end.
