//30/04/2016 - Shirleano.Junior - Task: 43061
// Refatorado.
unit ufpgRelFichaProcTests;

interface

uses
  ufpgRelFichaProc, ufpgGUITestCase, FutureWindows, ufpgRelFichaProcModelTests, ufpgDataModelTests;

type
  TffpgRelFichaProcTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRelFichaProc;
    FoDados: TffpgRelFichaProcModelTests;
    procedure FecharTelaRelatorio(const poWindow: IWindow);
    procedure RelFichaProcesso;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarRelFichaProcesso1_2_31;
  end;

implementation

uses
  TestFrameWork, Forms, Windows, uspRPPreviewForm, usajConstante, ufpgFuncoesGUITestes;

{ TffpgRelFichaProcTests }

procedure TffpgRelFichaProcTests.TestarRelFichaProcesso1_2_31;
begin
  ExecutarRoteiroTestes(RelFichaProcesso);
end;

function TffpgRelFichaProcTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRelFichaProcModelTests;
end;

procedure TffpgRelFichaProcTests.RelFichaProcesso;
begin
  AbrirTela;
  FoTela := TffpgRelFichaProc(spTela);
  FoDados := TffpgRelFichaProcModelTests(spDataModelTests);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado.');

  EnterTextInto(FoTela.edProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  TFutureWindows.Expect('TfspRPPreviewForm').ExecProc(FecharTelaRelatorio);
  FoTela.pbVisualizar.Click;
  Application.ProcessMessages;
end;

procedure TffpgRelFichaProcTests.FecharTelaRelatorio(const poWindow: IWindow);
var
  oTelaRelatorio: TfspRPPreviewForm;
begin
  oTelaRelatorio := poWindow.asControl as TfspRPPreviewForm;
  CheckTrue(Assigned(oTelaRelatorio), 'O Relatório não foi exibido!');
  Sleep(1000);
  oTelaRelatorio.SBDone.click;
end;

procedure TffpgRelFichaProcTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.
  
