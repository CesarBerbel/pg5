unit ufpgRegistroArquivoImportacaoEmpresaConveniadaTests;

interface

uses
  ufpgRegistroArquivoImportacaoEmpresaConveniada, TestFrameWork, Windows, Forms,
  FutureWindows, SysUtils, uspConjuntoDados, DBClient, DB, usajConstante, Classes,
  ufpgParametrosArquivoImportacao, ufpgRegistroArquivoImportacaoEmpresaConveniadaTipo00;

type
  TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Fake = class(
    TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00)
  protected
    procedure TestarMunicipioValido; override;
  end;

type
  TfpgRegistroArquivoImportacaoEmpresaConveniadaFake = class(
    TfpgRegistroArquivoImportacaoEmpresaConveniada)
  protected
    function CriarRegistroTipo00: TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00; override;
  end;

type
  TfpgRegistroArquivoImportacaoEmpresaConveniadaTests = class(TTestCase)
  private
    FoRegistroArquivoImportacaoEmpresaConveniada: TfpgRegistroArquivoImportacaoEmpresaConveniadaFake;
    FslRegistro: TStringList;
    //    function PegarRegistro(psCAMPO_TIPO_REGISTRO, psCAMPO_EMPRESA, psCAMPO_CNPJ,
    //      psCAMPO_LOGRADOURO, psCAMPO_NUMERO, psCAMPO_COMPLEMENTO, psCAMPO_BAIRRO,
    //      psCAMPO_CEP, psCAMPO_CIDADE, psCAMPO_UF: string): string;
    procedure TestDecodificarRegistroTipoIncorretoException;
    function TestarDecodificarRegistroValido: boolean;
    function ValidarRegistro00: boolean;
    function ValidarRegistro01: boolean;
    function ValidarRegistro02: boolean;
    procedure ValidarRegistro01Exception;
    procedure ValidarRegistro02Exception;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestDecodificarRegistro;
    procedure TestDecodificarRegistroTipoIncorreto;
    procedure TestValidarRegistro00;
    procedure TestValidarRegistro01SemRegistro00;
    procedure TestValidarRegistro01ComRegistro00;
    procedure TestValidarRegistro01ComOutroRegistro00;
    procedure TestValidarRegistro02Com01;
    procedure TestValidarRegistro02Sem01;
  end;

implementation

uses
  uspExcecao, ufpgMensagem3;

const
  sLINHA_VALIDA = '00|SABESP|01463762000197|Avenida das Empresas|100||Centro|88015260|São Paulo|SP';
  sCAMPO_TIPO_REGISTRO_INVALIDO = '05';

  sCAMPO_TIPO_REGISTRO_00_VALIDO = '00';
  sCAMPO_EMPRESA_VALIDO = 'SABESP';
  sCAMPO_CNPJ_VALIDO = '01463762000197';
  sCAMPO_LOGRADOURO_VALIDO = 'Avenida_das_Empresas';
  sCAMPO_NUMERO_VALIDO = '100';
  sCAMPO_COMPLEMENTO_VALIDO = '';
  sCAMPO_BAIRRO_VALIDO = 'Centro';
  sCAMPO_CEP_VALIDO = '88015260';
  sCAMPO_CIDADE_VALIDO = 'São Paulo';
  sCAMPO_UF_VALIDO = 'SP';

  sCAMPO_TIPO_REGISTRO_01_VALIDO = '01';
  sCAMPO_VALOR_ACAO = '50000';

  sCAMPO_TIPO_REGISTRO_02_VALIDO = '02';
  sCAMPO_PARTE_PASSIVA = 'João_da_Silva';
  sCAMPO_TIPO_DOCUMENTO = '1';
  sCAMPO_NUMERO_DOCUMENTO = '11111111111';
  sCAMPO_TIPO_ENDERECO = '1';
  sCAMPO_LOGRADOURO = 'Avenida_das_Partes';
  sCAMPO_NUMERO = '555';
  sCAMPO_COMPLEMENTO = 'Bloco_A_Apto.604';
  sCAMPO_BAIRRO = 'Centro';
  sCAMPO_CEP = '88015201';
  sCAMPO_CIDADE = 'São_Paulo';
  sCAMPO_UF = 'SP';
  sCAMPO_SEXO = 'M';

  nPOSICAO_TIPO_REGISTRO = 0;
  nPOSICAO_EMPRESA = 1;
  nPOSICAO_CNPJ = 2;
  nPOSICAO_LOGRADOURO = 3;
  nPOSICAO_NUMERO = 4;
  nPOSICAO_COMPLEMENTO = 5;
  nPOSICAO_BAIRRO = 6;
  nPOSICAO_CEP = 7;
  nPOSICAO_CIDADE = 8;
  nPOSICAO_UF = 9;
  nQTDE_VALORES_REGISTRO = 11;

{TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Fake}

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Fake.TestarMunicipioValido;
begin
  if (FaEstruturaRegistro[nPOSICAO_UF].sValorCampo = 'SP') and
    (FaEstruturaRegistro[nPOSICAO_CIDADE].sValorCampo = 'São Paulo') then
    Exit;
  TspExcecao.EmitirExcecaoRegraNegocio(n_avFPGImportacaoArquivoMunicipioParteAtivaNaoCadastrado,
    s_avFPGImportacaoArquivoMunicipioParteAtivaNaoCadastrado);
end;

{TfpgRegistroArquivoImportacaoEmpresaConveniadaFake}

function TfpgRegistroArquivoImportacaoEmpresaConveniadaFake.CriarRegistroTipo00: TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00;
begin
  result := TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Fake.Create(null); //PC_OK
end;

{TfpgRegistroArquivoImportacaoEmpresaConveniadaTests}

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.SetUp;
begin
  FoRegistroArquivoImportacaoEmpresaConveniada := TfpgRegistroArquivoImportacaoEmpresaConveniadaFake.Create(null); //PC_OK
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.TearDown;
begin
  FreeAndNil(FoRegistroArquivoImportacaoEmpresaConveniada); //PC_OK
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.TestDecodificarRegistro;
var
  slRegistro: TStringList;
begin
  slRegistro := TStringList.Create();
  try
    //    slRegistro.CommaText := PegarRegistro(sCAMPO_TIPO_REGISTRO_00_VALIDO,
    //      sCAMPO_EMPRESA_VALIDO, sCAMPO_CNPJ_VALIDO, sCAMPO_LOGRADOURO_VALIDO,
    //      sCAMPO_NUMERO_VALIDO, sCAMPO_COMPLEMENTO_VALIDO, sCAMPO_BAIRRO_VALIDO,
    //      sCAMPO_CEP_VALIDO, sCAMPO_CIDADE_VALIDO, sCAMPO_UF_VALIDO);
    FslRegistro := slRegistro;
    CheckTrue(TestarDecodificarRegistroValido);
  finally
    FreeAndNil(slRegistro);
  end;
end;

function TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.TestarDecodificarRegistroValido: boolean;
begin
  result := True;
  try
    FoRegistroArquivoImportacaoEmpresaConveniada.DecodificarRegistro(FslRegistro.CommaText);
  except
    result := False;
  end;
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.TestDecodificarRegistroTipoIncorreto;
var
  slRegistro: TStringList;
begin
  slRegistro := TStringList.Create();
  try
    //    slRegistro.CommaText := PegarRegistro(sCAMPO_TIPO_REGISTRO_INVALIDO,
    //      sCAMPO_EMPRESA_VALIDO, sCAMPO_CNPJ_VALIDO, sCAMPO_LOGRADOURO_VALIDO,
    //      sCAMPO_NUMERO_VALIDO, sCAMPO_COMPLEMENTO_VALIDO, sCAMPO_BAIRRO_VALIDO,
    //      sCAMPO_CEP_VALIDO, sCAMPO_CIDADE_VALIDO, sCAMPO_UF_VALIDO);
    FslRegistro := slRegistro;
    CheckException(TestDecodificarRegistroTipoIncorretoException, EspRegraNegocio);
  finally
    FreeAndNil(slRegistro);
  end;
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.
TestDecodificarRegistroTipoIncorretoException;
begin
  FoRegistroArquivoImportacaoEmpresaConveniada.DecodificarRegistro(FslRegistro.Text);
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.TestValidarRegistro00;
var
  slRegistro: TStringList;
begin
  slRegistro := TStringList.Create();
  try
    //    slRegistro.CommaText := PegarRegistro(sCAMPO_TIPO_REGISTRO_00_VALIDO,
    //      sCAMPO_EMPRESA_VALIDO, sCAMPO_CNPJ_VALIDO, sCAMPO_LOGRADOURO_VALIDO,
    //      sCAMPO_NUMERO_VALIDO, sCAMPO_COMPLEMENTO_VALIDO, sCAMPO_BAIRRO_VALIDO,
    //      sCAMPO_CEP_VALIDO, sCAMPO_CIDADE_VALIDO, sCAMPO_UF_VALIDO);
    FoRegistroArquivoImportacaoEmpresaConveniada.DecodificarRegistro(slRegistro.CommaText);
    CheckTrue(ValidarRegistro00);
  finally
    FreeAndNil(slRegistro);
  end;
end;

function TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.ValidarRegistro00: boolean;
begin
  result := True;
  try
    FoRegistroArquivoImportacaoEmpresaConveniada.ValidarRegistro;
  except
    result := False;
  end;
end;

// 28/04/2015 - nathan.db1 - SALT: 163320/4 - Retirado método PegarRegistro

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.TestValidarRegistro01SemRegistro00;
begin
  CheckException(ValidarRegistro01Exception, EspRegraNegocio);
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.
TestValidarRegistro01ComOutroRegistro00;
begin
  FoRegistroArquivoImportacaoEmpresaConveniada.FenRegistroEmAnalise := trRegistro01;
  FoRegistroArquivoImportacaoEmpresaConveniada.FenUltimoRegistroAnalisado := trRegistro01;
  CheckException(ValidarRegistro01Exception, EspRegraNegocio);
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.TestValidarRegistro01ComRegistro00;
begin
  FoRegistroArquivoImportacaoEmpresaConveniada.FenRegistroEmAnalise := trRegistro01;
  FoRegistroArquivoImportacaoEmpresaConveniada.FenUltimoRegistroAnalisado := trRegistro00;
  CheckTrue(ValidarRegistro01);
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.ValidarRegistro01Exception;
var
  slRegistro: TStringList;
begin

  slRegistro := TStringList.Create();
  try
    slRegistro.CommaText := sCAMPO_TIPO_REGISTRO_01_VALIDO + ',' + sCAMPO_VALOR_ACAO;
    FoRegistroArquivoImportacaoEmpresaConveniada.DecodificarRegistro(slRegistro.CommaText);
    FoRegistroArquivoImportacaoEmpresaConveniada.ValidarRegistro;
  finally
    FreeAndNil(slRegistro);
  end;
end;

function TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.ValidarRegistro01: boolean;
var
  slRegistro: TStringList;
begin
  result := True;
  try
    slRegistro := TStringList.Create();
    try
      slRegistro.CommaText := sCAMPO_TIPO_REGISTRO_01_VALIDO + ',' + sCAMPO_VALOR_ACAO;
      FoRegistroArquivoImportacaoEmpresaConveniada.DecodificarRegistro(slRegistro.CommaText);
      FoRegistroArquivoImportacaoEmpresaConveniada.ValidarRegistro;
    finally
      FreeAndNil(slRegistro);
    end;
  except
    result := False;
  end;
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.TestValidarRegistro02Sem01;
begin
  FoRegistroArquivoImportacaoEmpresaConveniada.FenRegistroEmAnalise := trRegistro02;
  FoRegistroArquivoImportacaoEmpresaConveniada.FenUltimoRegistroAnalisado := trRegistro00;
  CheckException(ValidarRegistro02Exception, EspRegraNegocio);
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.TestValidarRegistro02Com01;
begin
  FoRegistroArquivoImportacaoEmpresaConveniada.FenRegistroEmAnalise := trRegistro02;
  FoRegistroArquivoImportacaoEmpresaConveniada.FenUltimoRegistroAnalisado := trRegistro01;
  CheckTrue(ValidarRegistro02);
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.ValidarRegistro02Exception;
var
  slRegistro: TStringList;
begin
  slRegistro := TStringList.Create();
  try
    slRegistro.CommaText := sCAMPO_TIPO_REGISTRO_02_VALIDO + ',' + sCAMPO_PARTE_PASSIVA +
      ',' + sCAMPO_TIPO_DOCUMENTO + ',' + sCAMPO_NUMERO_DOCUMENTO + ',' +
      sCAMPO_TIPO_ENDERECO + ',' + sCAMPO_LOGRADOURO + ',' + sCAMPO_NUMERO + ',' +
      sCAMPO_COMPLEMENTO + ',' + sCAMPO_BAIRRO + ',' + sCAMPO_CEP + ',' + sCAMPO_CIDADE +
      ',' + sCAMPO_UF + ',' + sCAMPO_SEXO;
    FoRegistroArquivoImportacaoEmpresaConveniada.DecodificarRegistro(slRegistro.CommaText);
    FoRegistroArquivoImportacaoEmpresaConveniada.ValidarRegistro;
  finally
    FreeAndNil(slRegistro);
  end;
end;

function TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.ValidarRegistro02: boolean;
var
  slRegistro: TStringList;
begin
  result := True;
  try
    slRegistro := TStringList.Create();
    try
      slRegistro.CommaText := sCAMPO_TIPO_REGISTRO_02_VALIDO + ',' + sCAMPO_PARTE_PASSIVA +
        ',' + sCAMPO_TIPO_DOCUMENTO + ',' + sCAMPO_NUMERO_DOCUMENTO + ',' +
        sCAMPO_TIPO_ENDERECO + ',' + sCAMPO_LOGRADOURO + ',' + sCAMPO_NUMERO + ',' +
        sCAMPO_COMPLEMENTO + ',' + sCAMPO_BAIRRO + ',' + sCAMPO_CEP + ',' + sCAMPO_CIDADE +
        ',' + sCAMPO_UF + ',' + sCAMPO_SEXO;
      FoRegistroArquivoImportacaoEmpresaConveniada.DecodificarRegistro(slRegistro.CommaText);
      FoRegistroArquivoImportacaoEmpresaConveniada.ValidarRegistro;
    finally
      FreeAndNil(slRegistro);
    end;
  except
    result := False;
  end;
end;

initialization

  TestFrameWork.RegisterTest('Unitário\PG5\Componentes\RegistroArquivoImportacaoEmpresaConveniada',
    TfpgRegistroArquivoImportacaoEmpresaConveniadaTests.Suite);

end.

