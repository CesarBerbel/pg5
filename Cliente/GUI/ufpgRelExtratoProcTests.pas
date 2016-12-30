//30/04/2016 - Shirleano.Junior - Task: 43061
// Refatorado.
unit ufpgRelExtratoProcTests;

interface

uses
  ufpgRelExtratoProc, ufpgGUITestCase, ufpgRelExtratoProcModelTests, ufpgDataModelTests,
  FutureWindows;

type
  TffpgRelExtratoProcTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRelExtratoProc;
    FoDados: TffpgRelExtratoProcModelTests;
    procedure RelExtratoProcesso;
    procedure FecharTelaRelatorio(const poWindow: IWindow);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarRelExtratoProcesso;
  end;

implementation

uses
  TestFrameWork, Forms, uspRPPreviewForm, ufpgFuncoesGUITestes, usajConstante;

{ TffpgRelExtratoProcTests }

procedure TffpgRelExtratoProcTests.TestarRelExtratoProcesso;
begin
  ExecutarRoteiroTestes(RelExtratoProcesso);
end;

function TffpgRelExtratoProcTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRelExtratoProcModelTests;
end;

procedure TffpgRelExtratoProcTests.RelExtratoProcesso;
begin
  AbrirTela;
  FoTela := TffpgRelExtratoProc(spTela);
  FoDados := TffpgRelExtratoProcModelTests(spDataModelTests);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado.');

  EnterTextInto(FoTela.edProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  TFutureWindows.Expect('TfspRPPreviewForm').ExecProc(FecharTelaRelatorio);
  Application.ProcessMessages;
  FoTela.pbVisualizar.Click;
  Application.ProcessMessages;
end;

procedure TffpgRelExtratoProcTests.FecharTelaRelatorio(const poWindow: IWindow);
var
  oTelaRelatorio: TfspRPPreviewForm;
begin
  oTelaRelatorio := poWindow.asControl as TfspRPPreviewForm;
  CheckTrue(Assigned(oTelaRelatorio), 'O Relatório não foi exibido!');
  oTelaRelatorio.SBDone.click;
end;

procedure TffpgRelExtratoProcTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.

