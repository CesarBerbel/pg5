unit ufpgRegrasLotacaoUnificadaTests;

interface

uses
  ufpgRegrasLotacaoUnificadaFake, TestFrameWork, SysUtils;

type
  TfpgRegrasLotacaoUnificadaTests = class(TTestCase)
  private
    FoLotacaoCartorioUnico: TfpgRegrasLotacaoUnificadaFake;
  protected
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure TestTestarTelaPodeSerFechadaTelaNaoExiste;
    procedure TestTestarTelaPodeSerFechadaGerenciador;
    procedure TestTestarTelaPodeSerFechadaFluxo;
    procedure TestTestarTelaPodeSerFechadaFundoMenu;
    procedure TestTestarTelaPodeSerFechadaTelaAtual;
    procedure TestTestarTelaPodeSerFechadaTelaDiferente;
  end;

implementation

uses
  Forms;

procedure TfpgRegrasLotacaoUnificadaTests.SetUp;
var
  oFundoMenu: TForm;
begin
  oFundoMenu := TForm.Create(nil); //PC_OK
  oFundoMenu.Name := 'fundomenu';
  FoLotacaoCartorioUnico := TfpgRegrasLotacaoUnificadaFake.Create;//PC_OK
  FoLotacaoCartorioUnico.FoFundoMenu := oFundoMenu;
end;

procedure TfpgRegrasLotacaoUnificadaTests.TearDown;
begin
  FreeAndNil(FoLotacaoCartorioUnico.FoFundoMenu); //PC_OK
  FreeAndNil(FoLotacaoCartorioUnico); //PC_OK
end;

procedure TfpgRegrasLotacaoUnificadaTests.TestTestarTelaPodeSerFechadaGerenciador;
var
  oForm: TForm;
begin
  oForm := TForm.Create(nil);
  oForm.Name := 'ffpgGerenciadorArquivo';
  try
    CheckTrue(FoLotacaoCartorioUnico.TestarTelaPodeSerFechada(oForm));
  finally
    FreeAndNil(oForm);
  end;
end;

procedure TfpgRegrasLotacaoUnificadaTests.TestTestarTelaPodeSerFechadaFluxo;
var
  oForm: TForm;
begin
  oForm := TForm.Create(nil);
  oForm.Name := 'ffpgVisualizaFluxoTrabalho';
  try
    CheckFalse(FoLotacaoCartorioUnico.TestarTelaPodeSerFechada(oForm));
  finally
    FreeAndNil(oForm);
  end;
end;

procedure TfpgRegrasLotacaoUnificadaTests.TestTestarTelaPodeSerFechadaTelaAtual;
var
  oForm: TForm;
begin
  oForm := TForm.Create(nil);
  oForm.Name := 'fpgUmaTelaTeste';
  FoLotacaoCartorioUnico.fpgNomeTelaAtual := 'fpgUmaTelaTeste';
  try
    CheckFalse(FoLotacaoCartorioUnico.TestarTelaPodeSerFechada(oForm));
  finally
    FreeAndNil(oForm);
  end;
end;

procedure TfpgRegrasLotacaoUnificadaTests.TestTestarTelaPodeSerFechadaTelaDiferente;
var
  oForm: TForm;
begin
  oForm := TForm.Create(nil);
  oForm.Name := 'fpgUmaTelaQualquer';
  FoLotacaoCartorioUnico.fpgNomeTelaAtual := 'fpgUmaTelaTeste';
  try
    CheckTrue(FoLotacaoCartorioUnico.TestarTelaPodeSerFechada(oForm));
  finally
    FreeAndNil(oForm);
  end;
end;

procedure TfpgRegrasLotacaoUnificadaTests.TestTestarTelaPodeSerFechadaFundoMenu;
begin
  checkFalse(FoLotacaoCartorioUnico.TestarTelaPodeSerFechada(FoLotacaoCartorioUnico.FoFundoMenu));
end;

procedure TfpgRegrasLotacaoUnificadaTests.TestTestarTelaPodeSerFechadaTelaNaoExiste;
begin
  CheckFalse(FoLotacaoCartorioUnico.TestarTelaPodeSerFechada(nil));
end;

initialization
  TestFramework.RegisterTest(
    'Unitário\PG5\Componentes\pg5Componentes\ufpgRegrasLotacaoUnificadaTests',
    TfpgRegrasLotacaoUnificadaTests.Suite);
end.
