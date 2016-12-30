unit ufpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests;

interface

uses
  ufpgRegistroArquivoImportacaoEmpresaConveniadaTipo00, TestFrameWork, Windows,
  Forms, FutureWindows, SysUtils, uspConjuntoDados, DBClient, DB, uspExcecao,
  usajConstante, Classes, ufpgParametrosArquivoImportacao;

type
  TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Fake = class(
    TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00)
  protected
    procedure TestarMunicipioValido; override;
  end;

type
  TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests = class(TTestCase)
  private
    FnqtCamposObrigatorios: integer;
    FoRegistroArquivoImportacaoEmpresaConveniadaTipo00: TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Fake;
    function PegarRegistro(psCAMPO_TIPO_REGISTRO, psCAMPO_EMPRESA, psCAMPO_CNPJ,
      psCAMPO_LOGRADOURO, psCAMPO_NUMERO, psCAMPO_COMPLEMENTO, psCAMPO_BAIRRO,
      psCAMPO_CEP, psCAMPO_CIDADE, psCAMPO_UF: string): string;
    function TestarArquivoPreenchido(pslRegistro: TStringList): boolean;
    function TestDecodificarRegistroCamposPreenchidosCorretamenteValidacao: boolean;
    procedure TestValidarRegistroCamposObrigatoriosNaoPreenchidoException;
    procedure TestDecodificarRegistroCNPJIncorretoException;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestDecodificarRegistroCamposPreenchidos;
    procedure TestDecodificarRegistroCamposPreenchidosCorretamente;
    procedure TestDecodificarRegistroCNPJIncorreto;
    procedure TestValidarRegistroCamposObrigatoriosNaoPreenchido;
  end;

implementation

uses
  ufpgMensagem3;

const
  sLINHA_VALIDA = '00|SABESP|01463762000197|Avenida das Empresas|100||Centro|88015260|São Paulo|SP';
  sCAMPO_TIPO_REGISTRO_VALIDO = '00';
  sCAMPO_EMPRESA_VALIDO = 'SABESP';
  sCAMPO_CNPJ_VALIDO = '01463762000197';
  sCAMPO_LOGRADOURO_VALIDO = 'Avenida das Empresas';
  sCAMPO_NUMERO_VALIDO = '100';
  sCAMPO_COMPLEMENTO_VALIDO = '';
  sCAMPO_BAIRRO_VALIDO = 'Centro';
  sCAMPO_CEP_VALIDO = '88015260';
  sCAMPO_CIDADE_VALIDO = 'São Paulo';
  sCAMPO_UF_VALIDO = 'SP';

  sCAMPO_CNPJ_INVALIDO = '11111111111111';

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

{TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests}

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests.SetUp;
begin
  FoRegistroArquivoImportacaoEmpresaConveniadaTipo00 :=
    TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Fake.Create(null); //PC_OK  
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests.TearDown;
begin
  FreeAndNil(FoRegistroArquivoImportacaoEmpresaConveniadaTipo00); //PC_OK
end;

function TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests.PegarRegistro(
  psCAMPO_TIPO_REGISTRO, psCAMPO_EMPRESA, psCAMPO_CNPJ, psCAMPO_LOGRADOURO,
  psCAMPO_NUMERO, psCAMPO_COMPLEMENTO, psCAMPO_BAIRRO, psCAMPO_CEP, psCAMPO_CIDADE,
  psCAMPO_UF: string): string;
var
  slRegistro: TStringList;
begin
  slRegistro := TStringList.Create();
  try
    slRegistro.Add(psCAMPO_TIPO_REGISTRO);
    slRegistro.Add(psCAMPO_EMPRESA);
    slRegistro.Add(psCAMPO_CNPJ);
    slRegistro.Add(psCAMPO_LOGRADOURO);
    slRegistro.Add(psCAMPO_NUMERO);
    slRegistro.Add(psCAMPO_COMPLEMENTO);
    slRegistro.Add(psCAMPO_BAIRRO);
    slRegistro.Add(psCAMPO_CEP);
    slRegistro.Add(psCAMPO_CIDADE);
    slRegistro.Add(psCAMPO_UF);
    slRegistro.Add(STRING_INDEFINIDO);
    result := slRegistro.CommaText;
  finally
    FreeAndNil(slRegistro);
  end;
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests.
TestDecodificarRegistroCamposPreenchidos;
var
  slRegistro: TStringList;
begin
  slRegistro := TStringList.Create();
  try
    slRegistro.CommaText := PegarRegistro(sCAMPO_TIPO_REGISTRO_VALIDO,
      sCAMPO_EMPRESA_VALIDO, sCAMPO_CNPJ_VALIDO, sCAMPO_LOGRADOURO_VALIDO,
      sCAMPO_NUMERO_VALIDO, sCAMPO_COMPLEMENTO_VALIDO, sCAMPO_BAIRRO_VALIDO,
      sCAMPO_CEP_VALIDO, sCAMPO_CIDADE_VALIDO, sCAMPO_UF_VALIDO);
    FoRegistroArquivoImportacaoEmpresaConveniadaTipo00.DecodificarRegistro(slRegistro);
    CheckTrue(TestarArquivoPreenchido(slRegistro));
  finally
    FreeAndNil(slRegistro);
  end;
end;


function TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests.TestarArquivoPreenchido(
  pslRegistro: TStringList): boolean;
var
  i: integer;
begin
  for i := 0 to Length(FoRegistroArquivoImportacaoEmpresaConveniadaTipo00.
      FaEstruturaRegistro) - 1 do
  begin
    if not (FoRegistroArquivoImportacaoEmpresaConveniadaTipo00.FaEstruturaRegistro[i].sValorCampo
      = pslRegistro[i]) then
    begin
      TspExcecao.EmitirExcecaoRegraNegocio(n_avFPGImportacaoArquivoCamposObrigatoriosInvalidos,
        FoRegistroArquivoImportacaoEmpresaConveniadaTipo00.FaEstruturaRegistro[i].sNomeCampo);
    end;
  end;
  result := True;
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests.
TestDecodificarRegistroCamposPreenchidosCorretamente;
var
  slRegistro: TStringList;
begin
  slRegistro := TStringList.Create();
  try
    slRegistro.CommaText := PegarRegistro(sCAMPO_TIPO_REGISTRO_VALIDO,
      sCAMPO_EMPRESA_VALIDO, sCAMPO_CNPJ_VALIDO, sCAMPO_LOGRADOURO_VALIDO,
      sCAMPO_NUMERO_VALIDO, sCAMPO_COMPLEMENTO_VALIDO, sCAMPO_BAIRRO_VALIDO,
      sCAMPO_CEP_VALIDO, sCAMPO_CIDADE_VALIDO, sCAMPO_UF_VALIDO);
    FoRegistroArquivoImportacaoEmpresaConveniadaTipo00.DecodificarRegistro(slRegistro);
    CheckTrue(TestDecodificarRegistroCamposPreenchidosCorretamenteValidacao);
  finally
    FreeAndNil(slRegistro);
  end;
end;

function TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests.
TestDecodificarRegistroCamposPreenchidosCorretamenteValidacao: boolean;
begin
  result := True;
  try
    FoRegistroArquivoImportacaoEmpresaConveniadaTipo00.ValidarRegistro;
  except
    result := False;
  end;
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests.
TestDecodificarRegistroCNPJIncorreto;
var
  slRegistro: TStringList;
begin
  slRegistro := TStringList.Create();
  try
    slRegistro.CommaText := PegarRegistro(sCAMPO_TIPO_REGISTRO_VALIDO,
      sCAMPO_EMPRESA_VALIDO, sCAMPO_CNPJ_INVALIDO, sCAMPO_LOGRADOURO_VALIDO,
      sCAMPO_NUMERO_VALIDO, sCAMPO_COMPLEMENTO_VALIDO, sCAMPO_BAIRRO_VALIDO,
      sCAMPO_CEP_VALIDO, sCAMPO_CIDADE_VALIDO, sCAMPO_UF_VALIDO);
    FoRegistroArquivoImportacaoEmpresaConveniadaTipo00.DecodificarRegistro(slRegistro);
    CheckException(TestDecodificarRegistroCNPJIncorretoException, EspRegraNegocio);
  finally
    FreeAndNil(slRegistro);
  end;
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests.
TestDecodificarRegistroCNPJIncorretoException;
begin
  FoRegistroArquivoImportacaoEmpresaConveniadaTipo00.ValidarRegistro;
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests.
TestValidarRegistroCamposObrigatoriosNaoPreenchido;
const
  nQT_CAMPOS_OBRIGATORIOS = 9;
var
  slRegistro: TStringList;
  i: integer;
  arRegistro: array of string;
begin
  slRegistro := TStringList.Create();
  try
    FnqtCamposObrigatorios := 0;
    SetLength(arRegistro, nQTDE_VALORES_REGISTRO);
    arRegistro[nPOSICAO_TIPO_REGISTRO] := sCAMPO_TIPO_REGISTRO_VALIDO;
    arRegistro[nPOSICAO_EMPRESA] := sCAMPO_EMPRESA_VALIDO;
    arRegistro[nPOSICAO_CNPJ] := sCAMPO_CNPJ_VALIDO;
    arRegistro[nPOSICAO_LOGRADOURO] := sCAMPO_LOGRADOURO_VALIDO;
    arRegistro[nPOSICAO_NUMERO] := sCAMPO_NUMERO_VALIDO;
    arRegistro[nPOSICAO_COMPLEMENTO] := sCAMPO_COMPLEMENTO_VALIDO;
    arRegistro[nPOSICAO_BAIRRO] := sCAMPO_BAIRRO_VALIDO;
    arRegistro[nPOSICAO_CEP] := sCAMPO_CEP_VALIDO;
    arRegistro[nPOSICAO_CIDADE] := sCAMPO_CIDADE_VALIDO;
    arRegistro[nPOSICAO_UF] := sCAMPO_UF_VALIDO;
    arRegistro[10] := STRING_INDEFINIDO;
    for i := Length(FoRegistroArquivoImportacaoEmpresaConveniadaTipo00.FaEstruturaRegistro) -
      1 downto 0 do
    begin
      arRegistro[i] := STRING_INDEFINIDO;
      slRegistro.CommaText := PegarRegistro(arRegistro[nPOSICAO_TIPO_REGISTRO],
        arRegistro[nPOSICAO_EMPRESA], arRegistro[nPOSICAO_CNPJ], arRegistro[nPOSICAO_LOGRADOURO],
        arRegistro[nPOSICAO_NUMERO], arRegistro[nPOSICAO_COMPLEMENTO], arRegistro[nPOSICAO_BAIRRO],
        arRegistro[nPOSICAO_CEP], arRegistro[nPOSICAO_CIDADE], arRegistro[nPOSICAO_UF]);
      FoRegistroArquivoImportacaoEmpresaConveniadaTipo00.DecodificarRegistro(slRegistro);
      if not (i = nPOSICAO_COMPLEMENTO) then
        CheckException(TestValidarRegistroCamposObrigatoriosNaoPreenchidoException,
          EspRegraNegocio);
    end;
    CheckTrue(FnqtCamposObrigatorios = nQT_CAMPOS_OBRIGATORIOS);
  finally
    FreeAndNil(slRegistro);
  end;
end;

procedure TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests.
TestValidarRegistroCamposObrigatoriosNaoPreenchidoException;
begin
  try
    FoRegistroArquivoImportacaoEmpresaConveniadaTipo00.ValidarRegistro;
  except
    Inc(FnqtCamposObrigatorios);
    raise;
  end;
end;

initialization

  TestFrameWork.RegisterTest(
    'Unitário\PG5\Componentes\RegistroArquivoImportacaoEmpresaConveniadaTipo00',
    TfpgRegistroArquivoImportacaoEmpresaConveniadaTipo00Tests.Suite);

end.

