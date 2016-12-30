unit ufpgControleCertificadoDigitalTests;

interface

uses
  ufpgControleCertificadoDigitalFake, TestFrameWork, Windows, Forms, FutureWindows, SysUtils;

type
  TfpgControleCertificadoDigitalTests = class(TTestCase)
  private
    FoControleCertificadoDigital: TfpgControleCertificadoDigitalFake;
    procedure TestTestarCPFcertificadoInvalidoException;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestTestarCPFcertificadoValido;
    procedure TestTestarCPFcertificadoInvalido;
  end;

implementation

uses
  uspExcecao;

const
  nCOD_CERTIFICADO_CPF_VALIDO = 0;
  nCOD_CERTIFICADO_CPF_INVALIDO = 1;

{ TfpgControleCertificadoDigitalTests }

procedure TfpgControleCertificadoDigitalTests.SetUp;
begin
  FoControleCertificadoDigital := TfpgControleCertificadoDigitalFake.Create;  //PC_OK

  inherited;
end;

procedure TfpgControleCertificadoDigitalTests.TearDown;
begin
  FoControleCertificadoDigital.Free; //PC_OK

  inherited;
end;

procedure TfpgControleCertificadoDigitalTests.TestTestarCPFcertificadoInvalidoException;
begin
  FoControleCertificadoDigital.ValidarCPFCertificado(nCOD_CERTIFICADO_CPF_INVALIDO);
end;

procedure TfpgControleCertificadoDigitalTests.TestTestarCPFcertificadoInvalido;
begin
  CheckException(TestTestarCPFcertificadoInvalidoException, EspRegraNegocio);
end;

procedure TfpgControleCertificadoDigitalTests.TestTestarCPFcertificadoValido;
var
  bGerouExcecao: boolean;
begin
  bGerouExcecao := False;
  try
    FoControleCertificadoDigital.ValidarCPFCertificado(nCOD_CERTIFICADO_CPF_VALIDO);
  except
    bGerouExcecao := True;
  end;

  CheckFalse(bGerouExcecao);
end;

initialization
  TestFrameWork.RegisterTest('Unitário\PG5\Classes\ufpgControleCertificadoDigitalTests',
    TfpgControleCertificadoDigitalTests.Suite);

end.

