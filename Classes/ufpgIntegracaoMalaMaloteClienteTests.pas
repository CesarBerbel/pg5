unit ufpgIntegracaoMalaMaloteClienteTests;

interface

uses
  ufpgIntegracaoMalaMaloteCliente, TestFrameWork, Windows, Forms, FutureWindows, SysUtils;

type
  TfpgIntegracaoMalaMaloteClienteTests = class(TTestCase)
  private
    FoIntegracaoMalaMaloteCliente: TfpgIntegracaoMalaMaloteCliente;
    //Cancelamento
    procedure TestVerificarErrosCancelamentoMalaMaloteExceptionErroIntegracaoCancelamento;
    procedure TestVerificarErrosCancelamentoMalaMaloteExceptionErroNaoEncontrouServidor;
    procedure TestVerificarErrosCancelamentoMalaMaloteExceptionErroWebService;
    procedure TestVerificarErrosCancelamentoMalaMaloteExceptionUsuarioNaoEncontrado;
    //Carga
    procedure TestVerificarErrosCargaMalaMaloteExceptionErroIntegracaoCancelamento;
    procedure TestVerificarErrosCargaMalaMaloteExceptionErroNaoEncontrouServidor;
    procedure TestVerificarErrosCargaMalaMaloteExceptionErroWebService;
    procedure TestVerificarErrosCargaMalaMaloteExceptionUsuarioNaoEncontrado;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    //Cancelamento
    procedure TestVerificarErrosCancelamentoMalaMaloteErroIntegracaoCancelamento;
    procedure TestVerificarErrosCancelamentoMalaMaloteErroNaoEncontrouServidor;
    procedure TestVerificarErrosCancelamentoMalaMaloteErroWebService;
    procedure TestVerificarErrosCancelamentoMalaMaloteUsuarioNaoEncontrado;
    //Carga
    procedure TestVerificarErrosCargaMalaMaloteErroIntegracaoCancelamento;
    procedure TestVerificarErrosCargaMalaMaloteMalaMaloteErroNaoEncontrouServidor;
    procedure TestVerificarErrosCargaMalaMaloteErroWebService;
    procedure TestVerificarErrosCargaMalaMaloteUsuarioNaoEncontrado;
  end;

implementation

uses
  ufpgMensagem2, uspExcecao;

{ TfpgIntegracaoMalaMaloteClienteTests }
{n_avFPGErroWebServiceMalaMaloteTimeoutConexao
n_avFPGErroNaoEncontrouServidorAplicacaoMalaMalote
n_avFPGUsuarioNaoEncontradoAplicacaoMalaMalote
n_avFPGErroIntegracaoCargaComMalaMaloteGravarGuias
n_avFPGErroIntegracaoCancelamentoCargaComMalaMalote}

procedure TfpgIntegracaoMalaMaloteClienteTests.SetUp;
begin
  inherited;
  FoIntegracaoMalaMaloteCliente := TfpgIntegracaoMalaMaloteCliente.Create(); //PC_OK
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.TearDown;
begin
  inherited;
  FoIntegracaoMalaMaloteCliente.Free; //PC_OK
  FoIntegracaoMalaMaloteCliente := nil;
end;

//Cancelamento

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCancelamentoMalaMaloteErroWebService;
begin
  CheckException(TestVerificarErrosCancelamentoMalaMaloteExceptionErroWebService, EspRegraNegocio);
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCancelamentoMalaMaloteErroNaoEncontrouServidor;
begin
  CheckException(TestVerificarErrosCancelamentoMalaMaloteExceptionErroNaoEncontrouServidor,
    EspRegraNegocio);
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCancelamentoMalaMaloteUsuarioNaoEncontrado;
begin
  CheckException(TestVerificarErrosCancelamentoMalaMaloteExceptionUsuarioNaoEncontrado,
    EspRegraNegocio);
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCancelamentoMalaMaloteErroIntegracaoCancelamento;
begin
  CheckException(TestVerificarErrosCancelamentoMalaMaloteExceptionErroIntegracaoCancelamento,
    EspRegraNegocio);
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCancelamentoMalaMaloteExceptionErroWebService;
begin
  FoIntegracaoMalaMaloteCliente.VerificarErrosCancelamentoMalaMalote(
    n_avFPGErroWebServiceMalaMaloteTimeoutConexao, '');
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCancelamentoMalaMaloteExceptionErroNaoEncontrouServidor;
begin
  FoIntegracaoMalaMaloteCliente.VerificarErrosCancelamentoMalaMalote(
    n_avFPGErroNaoEncontrouServidorAplicacaoMalaMalote, '');
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCancelamentoMalaMaloteExceptionUsuarioNaoEncontrado;
begin
  FoIntegracaoMalaMaloteCliente.VerificarErrosCancelamentoMalaMalote(
    n_avFPGUsuarioNaoEncontradoAplicacaoMalaMalote, '');
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCancelamentoMalaMaloteExceptionErroIntegracaoCancelamento;
begin
  FoIntegracaoMalaMaloteCliente.VerificarErrosCancelamentoMalaMalote(
    n_avFPGErroIntegracaoCancelamentoCargaComMalaMalote, '');
end;

//Carga

procedure TfpgIntegracaoMalaMaloteClienteTests.TestVerificarErrosCargaMalaMaloteErroWebService;
begin
  CheckException(TestVerificarErrosCargaMalaMaloteExceptionErroWebService, EspRegraNegocio);
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCargaMalaMaloteMalaMaloteErroNaoEncontrouServidor;
begin
  CheckException(TestVerificarErrosCargaMalaMaloteExceptionErroNaoEncontrouServidor,
    EspRegraNegocio);
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCargaMalaMaloteUsuarioNaoEncontrado;
begin
  CheckException(TestVerificarErrosCargaMalaMaloteExceptionUsuarioNaoEncontrado, EspRegraNegocio);
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCargaMalaMaloteErroIntegracaoCancelamento;
begin
  CheckException(TestVerificarErrosCargaMalaMaloteExceptionErroIntegracaoCancelamento,
    EspRegraNegocio);
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCargaMalaMaloteExceptionErroWebService;
begin
  FoIntegracaoMalaMaloteCliente.VerificarErrosCargaMalaMalote(
    n_avFPGErroWebServiceMalaMaloteTimeoutConexao, '');
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCargaMalaMaloteExceptionErroNaoEncontrouServidor;
begin
  FoIntegracaoMalaMaloteCliente.VerificarErrosCargaMalaMalote(
    n_avFPGErroNaoEncontrouServidorAplicacaoMalaMalote, '');
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCargaMalaMaloteExceptionUsuarioNaoEncontrado;
begin
  FoIntegracaoMalaMaloteCliente.VerificarErrosCargaMalaMalote(
    n_avFPGUsuarioNaoEncontradoAplicacaoMalaMalote, '');
end;

procedure TfpgIntegracaoMalaMaloteClienteTests.
TestVerificarErrosCargaMalaMaloteExceptionErroIntegracaoCancelamento;
begin
  FoIntegracaoMalaMaloteCliente.VerificarErrosCargaMalaMalote(
    n_avFPGErroIntegracaoCargaComMalaMaloteGravarGuias, '');
end;

initialization

  TestFrameWork.RegisterTest('Unitário\PG5\Classes\ufpgIntegracaoMalaMaloteClienteTests',
    TfpgIntegracaoMalaMaloteClienteTests.Suite);

end.

