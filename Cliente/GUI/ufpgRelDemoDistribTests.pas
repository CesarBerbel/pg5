unit ufpgRelDemoDistribTests;

interface

uses
  ufpgRelDemoDistrib, ufpgGUITestCase, ufpgRelDemoDistribModelTests, ufpgDataModelTests,
  FutureWindows;

type
  TffpgRelDemoDistribTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRelDemoDistrib;
    FoDados: TffpgRelDemoDistribModelTests;
    procedure ProcessoDemonsDistribVara;
    procedure FecharTelaRelatorio(const poWindow: IWindow);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarProcessoDemonsDistribVara;

  end;

implementation

uses
  TestFrameWork, Windows, Forms, uspRPPreviewForm, ufpgRelDemoBasicoRPDev,
  uspInterface, usajConstante, ufpgFuncoesGUITestes;

{ TffpgRelDemoDistribTests }

function TffpgRelDemoDistribTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRelDemoDistribModelTests;
end;

procedure TffpgRelDemoDistribTests.TestarProcessoDemonsDistribVara;
begin
  ExecutarRoteiroTestes(ProcessoDemonsDistribVara);
end;

procedure TffpgRelDemoDistribTests.ProcessoDemonsDistribVara;
var
  oTelaRelDemoBasicoRPDev: TffpgRelDemoBasicoRPDev;
begin
  AbrirTela;
  FoTela := TffpgRelDemoDistrib(spTela);
  FoDados := TffpgRelDemoDistribModelTests(spDataModelTests);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);

  FoTela.ccFiltro.Execute(acConsultar);
  oTelaRelDemoBasicoRPDev := TffpgRelDemoBasicoRPDev(PegarTela('ffpgRelDemoBasicoRPDev'));
  TFutureWindows.Expect('TfspRPPreviewForm').ExecProc(FecharTelaRelatorio);
  oTelaRelDemoBasicoRPDev.pbvisualizar.Click;
  FecharTela;
end;

//28/07/2015 - LUCIANO.FAGUNDES - SALT: 186660/9/2
procedure TffpgRelDemoDistribTests.FecharTelaRelatorio(const poWindow: IWindow);
var
  oTelaRelatorio: TfspRPPreviewForm;
begin
  oTelaRelatorio := poWindow.asControl as TfspRPPreviewForm;
  CheckTrue(Assigned(oTelaRelatorio), 'O Relatório não foi exibido!');
  oTelaRelatorio.SBLastPage.Click;
  Application.ProcessMessages;
  sleep(1000);
  Application.ProcessMessages;
  oTelaRelatorio.SBDone.click;
end;

end.

