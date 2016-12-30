//20/05/2016 - ANTONIO.SOUSA - Task: 46382
//Refatorado.
unit ufpgLogFluxoTests;

interface

uses
  FutureWindows, ufpgLogFluxo, ufpgGUITestCase, ufpgLogFluxoModelTests, ufpgDataModelTests;

type
  TffpgLogFluxoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgLogFluxo;
    FoDados: TffpgLogFluxoModelTests;
    procedure FecharTelaRelatorio(const poWindow: IWindow);
    procedure RelHistoricoProcessoFluxo1_2_31;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarRelHistoricoProcessoFluxo;
  end;

implementation

uses
  ufpgCadProcessoTests, TestFrameWork, Windows, Forms, ufpgVariaveisTestesGUI,
  SysUtils, uspRPPreviewForm, ufpgConstanteGUITests, usajConstante, ufpgFuncoesGUITestes;

{ TffpgLogFluxoTests }

procedure TffpgLogFluxoTests.TestarRelHistoricoProcessoFluxo;
begin
  ExecutarRoteiroTestes(RelHistoricoProcessoFluxo1_2_31);
end;

function TffpgLogFluxoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgLogFluxoModelTests;
end;

procedure TffpgLogFluxoTests.RelHistoricoProcessoFluxo1_2_31;
begin
  AbrirTela;
  FoTela := TffpgLogFluxo(spTela);
  FoDados := TffpgLogFluxoModelTests(spDataModelTests);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado.');

  EnterTextInto(FoTela.edProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  TFutureWindows.Expect('TfspRPPreviewForm').ExecProc(FecharTelaRelatorio);
  FoTela.pbVisualizar.Click;
  Application.ProcessMessages;
end;

procedure TffpgLogFluxoTests.FecharTelaRelatorio(const poWindow: IWindow);
var
  oTelaRelatorio: TfspRPPreviewForm;
begin
  oTelaRelatorio := poWindow.asControl as TfspRPPreviewForm;
  CheckTrue(Assigned(oTelaRelatorio), 'O Relatório não foi exibido!');
  Sleep(1000);
  oTelaRelatorio.SBDone.click;
end;

procedure TffpgLogFluxoTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.

