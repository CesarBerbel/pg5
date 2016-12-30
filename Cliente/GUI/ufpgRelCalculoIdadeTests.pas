//29/04/2016 - Shirleano.Junior - Task: 43061
// Refatorado.
unit ufpgRelCalculoIdadeTests;

interface

uses
  ufpgRelCalculoIdade, ufpgGUITestCase, ufpgRelCalculoIdadeModelTests,
  ufpgDataModelTests, FutureWindows;

type
  TffpgRelCalculoIdadeTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRelCalculoIdade;
    FoDados: TffpgRelCalculoIdadeModelTests;
    procedure FecharTelaRelatorio(const poWindow: IWindow);
    procedure RelCalculoIdade;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarRelCalculoIdade;

  end;

implementation

uses
  TestFrameWork, Forms, SysUtils, uspRPPreviewForm, ufpgFuncoesGUITestes, Windows,
  ufpgVariaveisTestesGUI, ufpgConstanteGUITests, usajConstante;

{ TffpgRelCalculoIdadeTests }

procedure TffpgRelCalculoIdadeTests.TestarRelCalculoIdade;
begin
  ExecutarRoteiroTestes(RelCalculoIdade);
end;

function TffpgRelCalculoIdadeTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRelCalculoIdadeModelTests;
end;

procedure TffpgRelCalculoIdadeTests.RelCalculoIdade;
begin
  AbrirTela;
  FoTela := TffpgRelCalculoIdade(spTela);
  FoDados := (Self.spDataModelTests) as TffpgRelCalculoIdadeModelTests;
  EnterTextInto(FoTela.sajConsVara.dfcdVara, FoDados.fpgVara);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.sajNumeroProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  TFutureWindows.Expect('TfspRPPreviewForm').ExecProc(FecharTelaRelatorio);
  Application.ProcessMessages;
  FoTela.pbVisualizar.Click;
  Application.ProcessMessages;
end;

procedure TffpgRelCalculoIdadeTests.FecharTelaRelatorio(const poWindow: IWindow);
var
  oTelaRelatorio: TfspRPPreviewForm;
begin
  oTelaRelatorio := poWindow.asControl as TfspRPPreviewForm;
  CheckTrue(Assigned(oTelaRelatorio), 'O Relatório não foi exibido!');
  Sleep(1000);
  oTelaRelatorio.SBDone.click;
end;

procedure TffpgRelCalculoIdadeTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.

