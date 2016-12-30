unit ufpgControleLotacaoTests;

interface

uses
  ufpgControleLotacaoFake, TestFrameWork;

type
  TfpgControleLotacaoTests = class(TTestCase)
  private

  protected
    // Test methods
    procedure TestAlternarEntreLotacaoSemLotacaoException;
    procedure TestAlternarEntreLotacaoUmaLotacaoException;
    procedure TestAlternarEntreLotacaoDuasLotacaoNaoAutorizadoPelaBaseException;

    //    procedure SetUp; override;
    //    procedure TearDown; override;

  published

    procedure TestAlternarEntreLotacaoSemLotacao;
    procedure TestAlternarEntreLotacaoUmaLotacao;
    procedure TestAlternarEntreLotacaoDuasLotacaoNaoAutorizadoPelaBase;
    //    procedure TestAlternarEntreLotacao_VariasLotacao;

  end;

implementation

uses
  SysUtils, uspExcecao, ufpgGeral;

{ TfpgControleLotacaoTests }

procedure TfpgControleLotacaoTests.TestAlternarEntreLotacaoDuasLotacaoNaoAutorizadoPelaBase;
begin

  CheckException(TestAlternarEntreLotacaoDuasLotacaoNaoAutorizadoPelaBaseException,
    EspRegraNegocio);
end;

procedure TfpgControleLotacaoTests.
TestAlternarEntreLotacaoDuasLotacaoNaoAutorizadoPelaBaseException;
var
  fpgControleLotacao: TfpgControleLotacaoFake;
begin
  fpgControleLotacao := TfpgControleLotacaoFake.Create;
  try
    gNuSeqLotacao := 1;
    fpgControleLotacao.fpgAutorizarBase := False;
    fpgControleLotacao.AlternarLotacao('USUARIO2');
  finally
    FreeAndNil(fpgControleLotacao);
  end;
end;

procedure TfpgControleLotacaoTests.TestAlternarEntreLotacaoSemLotacao;
begin
  CheckException(TestAlternarEntreLotacaoSemLotacaoException, EspRegraNegocio);
end;

procedure TfpgControleLotacaoTests.TestAlternarEntreLotacaoSemLotacaoException;
var
  fpgControleLotacao: TfpgControleLotacaoFake;
begin
  fpgControleLotacao := TfpgControleLotacaoFake.Create;
  try
    gNuSeqLotacao := 1;
    fpgControleLotacao.AlternarLotacao('USUARIO0');
  finally
    FreeAndNil(fpgControleLotacao);
  end;
end;

procedure TfpgControleLotacaoTests.TestAlternarEntreLotacaoUmaLotacao;
begin
  CheckException(TestAlternarEntreLotacaoUmaLotacaoException, EspRegraNegocio);
end;

procedure TfpgControleLotacaoTests.TestAlternarEntreLotacaoUmaLotacaoException;
var
  fpgControleLotacao: TfpgControleLotacaoFake;
begin
  fpgControleLotacao := TfpgControleLotacaoFake.Create;
  try
    gNuSeqLotacao := 1;
    fpgControleLotacao.AlternarLotacao('USUARIO1');
  finally
    FreeAndNil(fpgControleLotacao);
  end;
end;

//procedure TfpgControleLotacaoTests.TestAlternarEntreLotacao_VariasLotacao;
//var
//  fpgRegrasLotacaoUnificada: TfpgRegrasLotacaoUnificadaFake;
//begin
//  fpgRegrasLotacaoUnificada := TfpgRegrasLotacaoUnificadaFake.Create;
//  try
//    fpgRegrasLotacaoUnificada.fpggNuSeqLotacao := 1;
//    fpgRegrasLotacaoUnificada.AlternarLotacao('USUARIO3');
//  finally
//    FreeAndNil(fpgRegrasLotacaoUnificada);
//  end;
//end;

initialization
  TestFramework.RegisterTest('Unitário\PG5\Componentes\pg5Componentes\ufpgControleLotacaoTests',
    TfpgControleLotacaoTests.Suite);

end.
 