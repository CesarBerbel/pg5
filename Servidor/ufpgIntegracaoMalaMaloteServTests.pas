{$A+,B-,C+,D+,E-,F-,G+,H+,I+,J+,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
unit ufpgIntegracaoMalaMaloteServTests;

interface

uses
  ufpgIntegracaoMalaMaloteServ, ufpgIntegracaoMalaMaloteServFake, TestFrameWork,
  Windows, Forms, FutureWindows, SysUtils, ufpgIntegracaoMMConfigServ, DB, DBClient;

type
  TfpgIntegracaoMalaMaloteServTests = class(TTestCase)
  private
    FoIntegracaoMalaMalote: TfpgIntegracaoMalaMaloteServFake;

    /// <summary>
    ///  Cria estrutura do dataset para envio ao M&M.
    /// </summary>
    /// <returns>
    ///  TClientDataSet
    /// </returns>
    /// <remarks>
    ///  15/10/2013 - Luiz.marques - SALT: 147569/1
    /// </remarks>
    function CriarEstruturaDadosPegarPdf: TClientDataSet;

    /// <summary>
    ///  Gera dados de acordo com o contrato feito com o servidor do M&M.
    /// </summary>
    /// <param name="paGuias">
    /// </param>
    /// <returns>
    ///  olevariant
    /// </returns>
    /// <remarks>
    ///  15/10/2013 - Luiz.marques - SALT: 147569/1
    /// </remarks>
    function GerarDadosPegarPdfPadrao(paGuias: array of string): olevariant;

    /// <summary>
    ///  Simula o comportamento do webservice.
    /// </summary>
    /// <param name="paGuiasFake">
    /// </param>
    /// <returns>
    ///  olevariant
    /// </returns>
    /// <remarks>
    ///  15/10/2013 - Luiz.marques - SALT: 147569/1
    /// </remarks>
    function ExecutarPegarGuiasMM(paGuiasFake: array of string): olevariant;

    /// <summary>
    ///  Executa função, cercando a exceção para o unt test.
    /// </summary>
    /// <remarks>
    ///  15/10/2013 - Luiz.marques - SALT: 147569/1
    /// </remarks>
    procedure TestPegarPdfGuiasTimeoutException;

    function CriarDadosControlePadrao: TfpgIntegracaoMMConfigServ;
  protected
    procedure TearDown; override;
    procedure SetUp; override;
  published
    /// <summary>
    ///  Testa os códigos de eerros relativos ao cadastro de local de origem.
    /// </summary>
    /// <remarks>
    ///  15/10/2013 - Luiz.marques - SALT: 147569/1
    /// </remarks>
    procedure TestVerificarCodigosErroCadastroOrigem;

    /// <summary>
    ///  Testa os códigos de erros relativos ao cadastro de local de destino.
    /// </summary>
    /// <remarks>
    ///  15/10/2013 - Luiz.marques - SALT: 147569/1
    /// </remarks>
    procedure TestVerificarCodigosErroCadastroDestino;

    /// <summary>
    ///  Testa os códigos de erros relativos ao número de guia enviado.
    /// </summary>
    /// <remarks>
    ///  15/10/2013 - Luiz.marques - SALT: 147569/1
    /// </remarks>
    procedure TestVerificarCodigosErroProblemaComGuia;

    /// <summary>
    ///  Executa um "caminho feliz" ao solicitar guia.
    /// </summary>
    /// <remarks>
    ///  15/10/2013 - Luiz.marques - SALT: 147569/1
    /// </remarks>
    procedure TestPegarPdfGuias;

    /// <summary>
    ///  Testa a situação em que o servidor de aplicação retornaria timeout na conexão
    ///  com o webservice.
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  15/10/2013 - Luiz.marques - SALT: 147569/1
    /// </remarks>
    procedure TestPegarPdfGuiasTimeoutConexao;

    /// <summary>
    ///  Testa a situção em que o número de guia enviado não está disponível no webservice.
    /// </summary>
    /// <remarks>
    ///  15/10/2013 - Luiz.marques - SALT: 147569/1
    /// </remarks>
    procedure TestPegarPdfGuiaInexistente;

    procedure TestExcluirGuiasTransporte;
    procedure TestExcluirGuiasTransporteUsuarioInvalido;
    procedure TestExcluirGuiasTransporteGuiaInexistente;
  end;

implementation

uses
  ufpgMensagem2, usajConstante, uspExcecao, Classes;

procedure TfpgIntegracaoMalaMaloteServTests.TestPegarPdfGuiasTimeoutConexao;
begin
  CheckException(TestPegarPdfGuiasTimeoutException, EspRegraNegocio);
end;

function TfpgIntegracaoMalaMaloteServTests.CriarDadosControlePadrao: TfpgIntegracaoMMConfigServ;
var
  sUsuario: string;
  sSenha: string;
begin
  sUsuario := 'SOFTPLAN';
  sSenha := '123456';
  result := TfpgIntegracaoMMConfigServ.Create; //PC_OK
  result.fpgLoginWs := sUsuario;
  result.fpgSenhaws := sSenha;
  result.fpgIPServidor := '127.0.0.1';
  result.fpgIpUsuario := '127.0.0.1';
  result.fpgIDRdm := 1;
  result.fpgLoginUsuario := sUsuario;
  result.fpgSistema := 'PG5';
end;

{ TfpgIntegracaoMalaMaloteServTests }

procedure TfpgIntegracaoMalaMaloteServTests.TestExcluirGuiasTransporte;
var
  nCdErro: integer;
  sComplErro: WideString;
  slGuias: TStringList;
begin
  slguias := TStringList.Create;
  try
    slGuias.add('00000000001201300000043410007000466');
    slGuias.add('00000000001201300000044250007000466');
    FoIntegracaoMalaMalote.fpgDadosServidor.fpgLoginWs := 'SOFTPLAN-WS';
    FoIntegracaoMalaMalote.fpgDadosServidor.fpgSenhaWs := '456789';
    FoIntegracaoMalaMalote.ExcluirGuiasTransporte(slGuias, nCdErro, sComplErro);
    CheckTrue(nCdErro = NUMERO_INDEFINIDO);
  finally
    FreeAndNil(slGuias);
  end;
end;

procedure TfpgIntegracaoMalaMaloteServTests.TestPegarPdfGuiaInexistente;
const
  aListaPdf: array [0..1] of string =
    ('00000000001201300000043410007000466', '00000000001201300000043999007000999');
begin
  Check(ExecutarPegarGuiasMM(aListaPdf)[0] = 'ERRO');
end;

procedure TfpgIntegracaoMalaMaloteServTests.TestPegarPdfGuiasTimeoutException;
var
  vDados: olevariant;
begin
  vDados := null;
  FoIntegracaoMalaMalote.ValidarRetornoPegarGuias(vDados);
end;

procedure TfpgIntegracaoMalaMaloteServTests.TestPegarPdfGuias;
const
  aListaPdf: array [0..1] of string =
    ('00000000001201300000043410007000466', '00000000001201300000043410007000466');
begin
  Check(ExecutarPegarGuiasMM(aListaPdf)[0] = 'OK');
end;

function TfpgIntegracaoMalaMaloteServTests.ExecutarPegarGuiasMM(
  paGuiasFake: array of string): olevariant;
var
  vDados: olevariant;
begin
  vDados := GerarDadosPegarPdfPadrao(paGuiasFake);

  result := FoIntegracaoMalaMalote.PegarPdfGuias(vDados);
end;

function TfpgIntegracaoMalaMaloteServTests.GerarDadosPegarPdfPadrao(
  paGuias: array of string): olevariant;
var
  cdsDados: TClientDataSet;
  i: integer;
begin
  try
    cdsDados := CriarEstruturaDadosPegarPdf;

    for i := 0 to Length(paGuias) - 1 do
    begin
      cdsDados.append;
      cdsDados.FieldByName('NUMALAMALOTE').AsString := paGuias[i];
      cdsDados.FieldByName('FLRETRATO').AsString := sFLAG_NAO;
      cdsDados.post;
    end;

    result := cdsDados.Data;
  finally
    FreeAndNil(cdsDados); //PC_OK
  end;
end;

function TfpgIntegracaoMalaMaloteServTests.CriarEstruturaDadosPegarPdf: TClientDataSet;
begin
  result := TCLientDataset.Create(nil); //PC_OK
  result.FieldDefs.Clear;
  result.fieldDefs.Add('NUMALAMALOTE', ftString, 255);
  result.FieldDefs.Add('FLRETRATO', ftString, 1);
  result.CreateDataSet;
end;

procedure TfpgIntegracaoMalaMaloteServTests.TearDown;
begin
  if Assigned(FoIntegracaoMalaMalote) then
    FreeAndNil(FoIntegracaoMalaMalote);//PC_OK
  inherited;
end;

procedure TfpgIntegracaoMalaMaloteServTests.TestExcluirGuiasTransporteGuiaInexistente;
var
  nCdErro: integer;
  sComplErro: WideString;
  slGuias: TStringList;
begin
  slguias := TStringList.Create;
  try
    slGuias.add('00000000001201300000043410007000465');
    slGuias.add('00000000001201300000044250007000466');
    FoIntegracaoMalaMalote.ExcluirGuiasTransporte(slguias, nCdErro, sComplErro);
    CheckTrue(nCdErro = n_avFPGErroIntegracaoCancelamentoCargaComMalaMalote);
  finally
    FreeAndNil(slGuias);
  end;
end;

procedure TfpgIntegracaoMalaMaloteServTests.TestExcluirGuiasTransporteUsuarioInvalido;
var
  nCdErro: integer;
  sComplErro: WideString;
  slGuias: TStringList;
begin
  slguias := TStringList.Create;
  slGuias.add('00000000001201300000043410007000466');
  slGuias.add('00000000001201300000044250007000466');

  try
    FoIntegracaoMalaMalote.fpgDadosServidor.fpgLoginUsuario := 'SOFTPLAN1';

    FoIntegracaoMalaMalote.ExcluirGuiasTransporte(slGuias, nCdErro, sComplErro);

    CheckTrue(nCdErro = n_avFPGUsuarioNaoEncontradoAplicacaoMalaMalote);
  finally
    FreeAndNil(slGuias);
  end;
end;

procedure TfpgIntegracaoMalaMaloteServTests.TestVerificarCodigosErroCadastroOrigem;
begin
  CheckEquals(n_avFPGErroWebServiceMalaMaloteLocalOrigemNaoConfiguradoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(nERRO_001_WSMM_CAMPO_CDSETORORIGEM_OBRIGATORIO));
  CheckEquals(n_avFPGErroWebServiceMalaMaloteLocalOrigemNaoConfiguradoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(
    nERRO_003_WSMM_CAMPO_CDIMOVELORIGEM_OBRIGATORIO));
  CheckEquals(n_avFPGErroWebServiceMalaMaloteLocalOrigemNaoConfiguradoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(nERRO_005_WSMM_CAMPO_CDLOCALORIGEM_OBRIGATORIO));
  CheckEquals(n_avFPGErroWebServiceMalaMaloteLocalOrigemNaoConfiguradoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(nERRO_008_WSMM_CAMPO_CDSETORORIGEM_OBRIGATORIO));
  CheckEquals(n_avFPGErroWebServiceMalaMaloteLocalOrigemNaoConfiguradoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(
    nERRO_010_WSMM_LOCAL_ORIGEM_NAO_ENCONTRADO_TAB_ESIPOCUPACAOINT));
end;

procedure TfpgIntegracaoMalaMaloteServTests.TestVerificarCodigosErroCadastroDestino;
begin
  CheckEquals(n_avFPGErroWebServiceMalaMaloteLocalDestinoNaoConfiguradoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(
    nERRO_011_WSMM_LOCAL_DESTINO_NAO_ENCONTRADO_TAB_ESIPOCUPACAOINT));
  CheckEquals(n_avFPGErroWebServiceMalaMaloteLocalDestinoNaoConfiguradoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(
    nERRO_006_WSMM_CAMPO_CDLOCALDESTINO_OBRIGATORIO));
  CheckEquals(n_avFPGErroWebServiceMalaMaloteLocalDestinoNaoConfiguradoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(
    nERRO_002_WSMM_CAMPO_CDSETORDESTINO_OBRIGATORIO));
  CheckEquals(n_avFPGErroWebServiceMalaMaloteLocalDestinoNaoConfiguradoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(
    nERRO_004_WSMM_CAMPO_CDIMOVELDESTINO_OBRIGATORIO));
end;

procedure TfpgIntegracaoMalaMaloteServTests.TestVerificarCodigosErroProblemaComGuia;
begin
  CheckEquals(n_avFPGErroWebServiceMalaMaloteProcessoNaoInformadoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(nERRO_007_WSMM_CAMPO_NUDOCUMENTOS_OBRIGATORIO));

  CheckEquals(n_avFPGErroWebServiceMalaMaloteProcessoNaoInformadoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(
    nERRO_009_WSMM_CAMPO_NUDOCUMENTO_POSICAO_ZERO_OBRIGATORIO));

  CheckEquals(n_avFPGErroWebServiceMalaMaloteProcessoNaoInformadoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(nERRO_012_WSMM_CAMPO_NUCODIGOBARRA_OBRIGATORIO));

  CheckEquals(n_avFPGErroWebServiceMalaMaloteProcessoNaoInformadoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(nERRO_013_WSMM_CODIGO_BARRA_TAMANHO_INVALIDO));

  CheckEquals(n_avFPGErroWebServiceMalaMaloteProcessoNaoInformadoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(nERRO_016_WSMM_CODIGO_BARRA_POSICAO_ZERO_VAZIO));

  CheckEquals(n_avFPGErroWebServiceMalaMaloteProcessoNaoInformadoCorretamente,
    FoIntegracaoMalaMalote.PegarCodigoErroSistema(
    nERRO_017_WSMM_CODIGO_BARRA_POSICAO_ZERO_TAMANHO_INVALIDO));
end;

procedure TfpgIntegracaoMalaMaloteServTests.SetUp;
var
  oDadosServidor: TfpgIntegracaoMMConfigServ;
begin
  oDadosServidor := CriarDadosControlePadrao;
  try
    FoIntegracaoMalaMalote := TfpgIntegracaoMalaMaloteServFake.Create(oDadosServidor); //PC_OK
  finally
    FreeAndNil(oDadosServidor); //PC_OK
  end;

  inherited;
end;

initialization

  TestFrameWork.RegisterTest('Unitário\PG5\Servidor\ufpgIntegracaoMalaMaloteServTests',
    TfpgIntegracaoMalaMaloteServTests.Suite);

end.

