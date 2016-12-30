unit ufpgConversorDataSetJsonTests;

interface

uses
  ufpgConversorDataSetJson, TestFrameWork, uspTestCase, ufpgGeradorDataSetJson,
  DB, DBClient, Classes;

type
  TfpgConversorDataSetJsonTests = class(TspTestCase)
  private
    FofpgConversorDataSetJson: TfpgConversorDataSetJson;
    FcdsDadosParaJSon: TClientDataset;
    procedure ConverterDatasetParaStream(poValorCampo: olevariant; var poStream: TMemoryStream);
    function DefinirDataSetPadrao: TClientDataSet;
    procedure AdicionarRegistroDataSet(const psDescricao, psValor: string;
      psTipoCampo: TFlTipoCampo; pcdsDestino: TClientDataSet);
    procedure AdicionarDataSetComoCampoEmUmaChave(const psDescricao: string;
      pcdsDestino, pcdsValor: TClientDataset);
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRetornarJsonComUmRegistroString;
    procedure TestRetornarJsonComDoisRegistrosString;
    procedure TestRetornarJsonComRegistroData;
    procedure TestRetornarJsonComRegistroDataVazio;
    procedure TestRetornarJsonComRegistroStrEInt;
    procedure TestRetornarJsonDataSetSemCampoTipo;
    procedure TestRetornarJsonDataSetSemCampoValor;
    procedure TestRetornarJsonDataSetSemInfoCampos;
    procedure TestRetornarJsonDataSetSemCampoDescricao;
    procedure TestRetornarJsonOleVariantInvalido;
    procedure TestRetornarJsonVazio;
  end;

implementation

uses
  SysUtils, uspProblemaTecnicoException, usajConstante;

procedure TfpgConversorDataSetJsonTests.TestRetornarJsonComUmRegistroString;
const
  sRETORNO_JSON = '{"status":"testando"}';
begin
  AdicionarRegistroDataSet('status', 'testando', fsString, FcdsDadosParaJSon);
  CheckTrue(FofpgConversorDataSetJson.RetornarJson(FcdsDadosParaJSon.Data) = sRETORNO_JSON,
    'Esperado o json {"status":"testando"}.');
end;

procedure TfpgConversorDataSetJsonTests.TestRetornarJsonComDoisRegistrosString;
const
  sRETORNO_JSON = '{"mensagem":"Teste retorno Json", "conversa":"Json Teste"}';
begin
  AdicionarRegistroDataSet('mensagem', 'Teste retorno Json', fsString, FcdsDadosParaJSon);
  AdicionarRegistroDataSet('conversa', 'Json Teste', fsString, FcdsDadosParaJSon);
  CheckTrue(FofpgConversorDataSetJson.RetornarJson(FcdsDadosParaJSon.Data) = sRETORNO_JSON,
    'Esperado o Json {"mensagem":"Teste retorno Json", "conversa":"Json Teste"}');
end;

procedure TfpgConversorDataSetJsonTests.TestRetornarJsonComRegistroStrEInt;
const
  sRETORNO_JSON = '{"status":0, "mensagem":"Teste retornoJson"}';
begin
  AdicionarRegistroDataSet('status', '0', fsInteger, FcdsDadosParaJSon);
  AdicionarRegistroDataSet('mensagem', 'Teste retornoJson', fsString, FcdsDadosParaJSon);
  CheckTrue(FofpgConversorDataSetJson.RetornarJson(FcdsDadosParaJSon.Data) = sRETORNO_JSON,
    'Esperado o Json {"status":0, "mensagem":"Teste retornoJson"}');
end;

procedure TfpgConversorDataSetJsonTests.TestRetornarJsonComRegistroData;
const
  sJSON = '{"status":-1, "mensagem":"Json teste", "dadosProcesso":{"classe":"criminal"}}';
var
  cdsDadosNivel: TClientDataSet;
begin
  cdsDadosNivel := DefinirDataSetPadrao; //PC_OK
  try
    AdicionarRegistroDataSet('status', '-1', fsInteger, FcdsDadosParaJSon);
    AdicionarRegistroDataSet('mensagem', 'Json teste', fsString, FcdsDadosParaJSon);
    //registo no dataset de segundo nivel
    AdicionarRegistroDataSet('classe', 'criminal', fsString, cdsDadosNivel);
    //Adiciono o dataset ao outro
    AdicionarDataSetComoCampoEmUmaChave('dadosProcesso', FcdsDadosParaJSon, cdsDadosNivel);
    CheckTrue(FofpgConversorDataSetJson.RetornarJson(FcdsDadosParaJSon.Data) = sJSON,
      'Esperado o Json {"status":-1, "mensagem":"Json teste", "dadosProcesso":{"classe":"criminal"}}'
      );
  finally
    FreeAndNil(cdsDadosNivel); //PC_OK
  end;
end;

procedure TfpgConversorDataSetJsonTests.ConverterDatasetParaStream(poValorCampo: olevariant;
  var poStream: TMemoryStream);
var
  cdsData: TClientDataset;
begin
  cdsData := TClientDataset.Create(nil);
  try
    cdsData.Data := poValorCampo;
    poStream.Clear;
    poStream.Seek(0, soFromBeginning);
    poStream.Position := 0;
    cdsData.SaveToStream(poStream);
  finally
    FreeAndNil(cdsData);
  end;
end;

procedure TfpgConversorDataSetJsonTests.SetUp;
begin
  inherited;
  FofpgConversorDataSetJson := TfpgConversorDataSetJson.Create; //PC_OK
  FcdsDadosParaJSon := DefinirDataSetPadrao; //PC_OK
end;

procedure TfpgConversorDataSetJsonTests.TearDown;
begin
  FreeAndNil(FofpgConversorDataSetJson); //PC_OK
  FreeAndNil(FcdsDadosParaJSon); //PC_OK
end;

function TfpgConversorDataSetJsonTests.DefinirDataSetPadrao: TClientDataSet;
begin
  result := TClientDataSet.Create(nil); //PC_OK
  result.FieldDefs.Add(sCAMPO_DESCRICAO, ftString, 50);
  result.FieldDefs.Add(sCAMPO_TIPO, ftString, 1);
  result.FieldDefs.Add(sCAMPO_VALOR, ftBlob);
  result.CreateDataSet;
  result.Open;
end;

procedure TfpgConversorDataSetJsonTests.AdicionarRegistroDataSet(
  const psDescricao, psValor: string; psTipoCampo: TFlTipoCampo; pcdsDestino: TClientDataSet);
begin
  pcdsDestino.Append;
  pcdsDestino.FieldByName(sCAMPO_DESCRICAO).AsString := psDescricao;
  pcdsDestino.FieldByName(sCAMPO_TIPO).AsString := aTFlTipoCampo[psTipoCampo];
  TBlobField(pcdsDestino.FieldByName(sCAMPO_VALOR)).Value := psValor;
  pcdsDestino.Post;
end;

procedure TfpgConversorDataSetJsonTests.AdicionarDataSetComoCampoEmUmaChave(
  const psDescricao: string; pcdsDestino, pcdsValor: TClientDataset);
var
  oStrData: TMemoryStream;
  vDados: olevariant;
begin
  pcdsDestino.Append;
  pcdsDestino.FieldByName(sCAMPO_DESCRICAO).AsString := psDescricao;
  pcdsDestino.FieldByName(sCAMPO_TIPO).AsString := aTFlTipoCampo[fsDataSet];

  if (pcdsValor = nil) then
  begin
    pcdsDestino.FieldByName(sCAMPO_VALOR).Value := null;
    pcdsDestino.post;
    exit;
  end;

  ostrData := TMemoryStream.Create;
  try
    vDados := pcdsValor.Data;
    ConverterDatasetParaStream(vDados, oStrData);

    TBlobField(pcdsDestino.FieldByName(sCAMPO_VALOR)).LoadFromStream(oStrData);
    pcdsDestino.post;
  finally
    FreeAndNil(oStrData);
  end;
end;

procedure TfpgConversorDataSetJsonTests.TestRetornarJsonComRegistroDataVazio;
const
  sJSON = '{"status":-1, "mensagem":"lorem ipsum léro lérô", "dadosProcesso":{}}';
var
  cdsDadosNivel: TClientDataSet;
begin
  cdsDadosNivel := DefinirDataSetPadrao; //PC_OK
  try
    AdicionarRegistroDataSet('status', '-1', fsInteger, FcdsDadosParaJSon);
    AdicionarRegistroDataSet('mensagem', 'lorem ipsum léro lérô', fsString, FcdsDadosParaJSon);
    //registo no dataset de segundo nivel
    AdicionarRegistroDataSet('classe', 'criminal', fsString, cdsDadosNivel);
    //Adiciono o dataset ao outro
    AdicionarDataSetComoCampoEmUmaChave('dadosProcesso', FcdsDadosParaJSon, nil);
    CheckTrue(FofpgConversorDataSetJson.RetornarJson(FcdsDadosParaJSon.Data) = sJSON,
      'Esperado o Json {"status":-1, "mensagem":"lorem ipsum léro lérô", "dadosProcesso":{}}');
  finally
    FreeAndNil(cdsDadosNivel); //PC_OK
  end;
end;

procedure TfpgConversorDataSetJsonTests.TestRetornarJsonVazio;
const
  sJSON = '{}';
begin
  CheckTrue(FofpgConversorDataSetJson.RetornarJson(FcdsDadosParaJSon.Data) = sJSON,
    'Esperado o Json {}');
end;

procedure TfpgConversorDataSetJsonTests.TestRetornarJsonOleVariantInvalido;
const
  sMSG_EXCECAO = 'Não foi passado um OleVariant válido.';
var
  sRetExcecao: string;
begin
  try
    FofpgConversorDataSetJson.RetornarJson(null);
  except
    on e: EspProblemaTecnicoException do
      sRetExcecao := e.Message;
  end;

  CheckTrue(sMSG_EXCECAO = sRetExcecao,
    'O teste espera que ocorra um exceção do tipo EspProblemaTecnicoException, com a mensagem ' +
    sMSG_EXCECAO);
end;

procedure TfpgConversorDataSetJsonTests.TestRetornarJsonDataSetSemCampoDescricao;
const
  sMSG_EXCECAO = 'O dataset não contem o campo DENOMECAMPO.';
var
  cdsFake: TClientDataSet;
  sRetExcecao: string;
begin
  cdsFake := TCLientDataset.Create(nil);
  try
    cdsFake.FieldDefs.Add(sCAMPO_TIPO, ftString, 50);
    cdsFake.FieldDefs.Add(sCAMPO_VALOR, ftBlob);
    cdsFake.CreateDataSet;
    cdsFake.Open;

    try
      FofpgConversorDataSetJson.RetornarJson(cdsFake.Data);
    except
      on e: EspProblemaTecnicoException do
        sRetExcecao := e.Message;
    end;

    CheckTrue(sMSG_EXCECAO = sRetExcecao,
      'O teste espera que ocorra um exceção do tipo EspProblemaTecnicoException, com a mensagem ' +
      sMSG_EXCECAO);
  finally
    FreeAndNil(cdsFake);
  end;
end;

procedure TfpgConversorDataSetJsonTests.TestRetornarJsonDataSetSemCampoTipo;
const
  sMSG_EXCECAO = 'O dataset não contem o campo FLTIPOCAMPO.';
var
  cdsFake: TClientDataSet;
  sRetExcecao: string;
begin
  cdsFake := TCLientDataset.Create(nil);
  sRetExcecao := STRING_INDEFINIDO;
  try
    cdsFake.FieldDefs.Add(sCAMPO_DESCRICAO, ftString, 50);
    cdsFake.FieldDefs.Add(sCAMPO_VALOR, ftBlob);
    cdsFake.CreateDataSet;
    cdsFake.Open;

    try
      FofpgConversorDataSetJson.RetornarJson(cdsFake.Data);
    except
      on e: EspProblemaTecnicoException do
        sRetExcecao := e.Message;
    end;

    CheckTrue(sMSG_EXCECAO = sRetExcecao,
      'O teste espera que ocorra um exceção do tipo EspProblemaTecnicoException, com a mensagem ' +
      sMSG_EXCECAO);
  finally
    FreeAndNil(cdsFake);
  end;
end;

procedure TfpgConversorDataSetJsonTests.TestRetornarJsonDataSetSemCampoValor;
const
  sMSG_EXCECAO = 'O dataset não contem o campo BLVALORCAMPO.';
var
  cdsFake: TClientDataSet;
  sRetExcecao: string;
begin
  sRetExcecao := STRING_INDEFINIDO;
  cdsFake := TCLientDataset.Create(nil);
  try
    cdsFake.FieldDefs.Add(sCAMPO_DESCRICAO, ftString, 50);
    cdsFake.FieldDefs.Add(sCAMPO_TIPO, ftString, 1);
    cdsFake.CreateDataSet;
    cdsFake.Open;

    try
      FofpgConversorDataSetJson.RetornarJson(cdsFake.Data);
    except
      on e: EspProblemaTecnicoException do
        sRetExcecao := e.Message;
    end;
    CheckTrue(sMSG_EXCECAO = sRetExcecao,
      'O teste espera que ocorra um exceção do tipo EspProblemaTecnicoException, com a mensagem ' +
      sMSG_EXCECAO);
  finally
    FreeAndNil(cdsFake);
  end;
end;

procedure TfpgConversorDataSetJsonTests.TestRetornarJsonDataSetSemInfoCampos;
const
  sMSG_EXCECAO = 'Problema ao resolver tipo do campo.';
var
  sRetExcecao: string;
begin
  FcdsDadosParaJSon.append;
  FcdsDadosParaJSon.FieldByName(sCAMPO_DESCRICAO).AsString := 'nome';
  FcdsDadosParaJSon.FieldByName(sCAMPO_TIPO).AsString := 'Z';
  FcdsDadosParaJSon.FieldByName(sCAMPO_VALOR).AsString := 'josé';
  FcdsDadosParaJSon.post;

  try
    FofpgConversorDataSetJson.RetornarJson(FcdsDadosParaJSon.Data);
  except
    on e: EspProblemaTecnicoException do
      sRetExcecao := e.Message;
  end;
  CheckTrue(sMSG_EXCECAO = sRetExcecao, 'O teste espera que ocorra um exceção do tipo ' +
    sMSG_EXCECAO);
end;

initialization
  TestFrameWork.RegisterTest('Unitário\PG5\Componentes\ufpgConversorDataSetJsonTests',
    TfpgConversorDataSetJsonTests.Suite);

end.
