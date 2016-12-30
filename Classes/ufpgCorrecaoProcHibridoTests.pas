unit ufpgCorrecaoProcHibridoTests;

interface

uses
  ufpgCorrecaoProcHibridoFake, TestFrameWork, Windows, Forms, FutureWindows, SysUtils;

type
  TfpgCorrecaoProcHibridoTests = class(TTestCase)
  private
    FoCorrecaoProcHibrido: TfpgCorrecaoProcHibridoFake;
    procedure TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaQtdePecaFisicaMaiorException;
    procedure TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaCaracterNaoPermitidoException;
    procedure TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaLimiteMaximoExcedidoException;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestTestarNovoNumeroPrimeiraPaginaValidaCorrecaoCPH;
    procedure TestTestarNovoNumeroPrimeiraPaginaValidaTornaProcessoDigital;
    procedure TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaQtdePecaFisicaMaior;
    procedure TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaCaracterNaoPermitido;
    procedure TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaLimiteMaximoExcedido;
  end;

implementation

uses
  uspFuncoesString, uspExcecao;

{ TfpgCorrecaoProcHibridoTests }

procedure TfpgCorrecaoProcHibridoTests.SetUp;
begin
  FoCorrecaoProcHibrido := TfpgCorrecaoProcHibridoFake.Create(); //PC_OK

  inherited;
end;

procedure TfpgCorrecaoProcHibridoTests.TearDown;
begin
  FoCorrecaoProcHibrido.Free; //PC_OK

  inherited;
end;

procedure TfpgCorrecaoProcHibridoTests.
TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaCaracterNaoPermitidoException;
begin
  FoCorrecaoProcHibrido.fpgQtdePecaFisica := 0;
  FoCorrecaoProcHibrido.TestarNovoNumeroPrimeiraPaginaCPH('A');
end;

procedure TfpgCorrecaoProcHibridoTests.
TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaQtdePecaFisicaMaiorException;
begin
  FoCorrecaoProcHibrido.fpgQtdePecaFisica := 5;
  FoCorrecaoProcHibrido.TestarNovoNumeroPrimeiraPaginaCPH('1');
end;

procedure TfpgCorrecaoProcHibridoTests.
TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaCaracterNaoPermitido;
begin
  CheckException(TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaCaracterNaoPermitidoException,
    EspRegraNegocio);
end;

procedure TfpgCorrecaoProcHibridoTests.
TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaQtdePecaFisicaMaior;
begin
  CheckException(TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaQtdePecaFisicaMaiorException,
    EspRegraNegocio);
end;

procedure TfpgCorrecaoProcHibridoTests.TestTestarNovoNumeroPrimeiraPaginaValidaCorrecaoCPH;
var
  bGerouExcecao: boolean;
begin
  bGerouExcecao := False;
  try
    FoCorrecaoProcHibrido.fpgQtdePecaFisica := 0;
    FoCorrecaoProcHibrido.TestarNovoNumeroPrimeiraPaginaCPH('1');
  except
    bGerouExcecao := True;
  end;

  CheckFalse(bGerouExcecao);
end;

procedure TfpgCorrecaoProcHibridoTests.
TestTestarNovoNumeroPrimeiraPaginaValidaTornaProcessoDigital;
var
  bGerouExcecao: boolean;
begin
  bGerouExcecao := False;
  try
    FoCorrecaoProcHibrido.fpgQtdePecaFisica := 5;
    FoCorrecaoProcHibrido.TestarNovoNumeroPrimeiraPaginaCPH('5');
  except
    bGerouExcecao := True;
  end;

  CheckFalse(bGerouExcecao);
end;

procedure TfpgCorrecaoProcHibridoTests.
TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaLimiteMaximoExcedidoException;
begin
  FoCorrecaoProcHibrido.fpgQtdePecaFisica := 5;
  FoCorrecaoProcHibrido.TestarNovoNumeroPrimeiraPaginaCPH('999999');
end;

procedure TfpgCorrecaoProcHibridoTests.
TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaLimiteMaximoExcedido;
begin
  CheckException(TestTestarNovoNumeroPrimeiraPaginaCPHInvalidaLimiteMaximoExcedidoException,
    EspRegraNegocio);
end;

initialization
  TestFrameWork.RegisterTest('Unitário\PG5\Classes\ufpgCorrecaoProcHibridoTests',
    TfpgCorrecaoProcHibridoTests.Suite);

end.
  
