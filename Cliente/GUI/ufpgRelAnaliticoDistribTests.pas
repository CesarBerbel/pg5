//29/04/2016 - Shirleano.Junior - Task: 43061
// Refatorado.
unit ufpgRelAnaliticoDistribTests;

interface

uses
  ufpgRelAnaliticoDistrib, ufpgGUITestCase, ufpgRelAnaliticoDistribModelTests,
  ufpgDataModelTests, FutureWindows;


type
  TffpgRelAnaliticoDistribTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRelAnaliticoDistrib;
    FoDados: TffpgRelAnaliticoDistribModelTests;
    procedure RelAnaliticoDistrib;
    procedure PreencheDados;
    procedure FecharTelaRelatorio(const poWindow: IWindow);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarRelAnaliticoDistrib;
  end;

implementation

uses
  ufpgFuncoesGUITestes, ufpgConstanteGUITests, TestFrameWork, Forms, SysUtils,
  uspInterface, uspFuncoesDate, uspRPPreviewForm, usajConstante;

{ TffpgRelAnaliticoDistribTests }

procedure TffpgRelAnaliticoDistribTests.TestarRelAnaliticoDistrib;
begin
  ExecutarRoteiroTestes(RelAnaliticoDistrib);
end;

function TffpgRelAnaliticoDistribTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRelAnaliticoDistribModelTests;
end;

procedure TffpgRelAnaliticoDistribTests.RelAnaliticoDistrib;
begin
  AbrirTela;
  FoTela := TffpgRelAnaliticoDistrib(spTela);
  FoDados := TffpgRelAnaliticoDistribModelTests(spDataModelTests);
  PreencheDados;
  Application.ProcessMessages;
  TFutureWindows.Expect('TfspRPPreviewForm').ExecProc(FecharTelaRelatorio);
  FoTela.pbVisualizar.Click;
  Application.ProcessMessages;
end;

procedure TffpgRelAnaliticoDistribTests.PreencheDados;
begin
  case StrToInt(FoDados.spIDTeste) of
    1:
    begin
      if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
        FoDados.fpgNuProcesso := UsarProcessoArray;
      Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

      EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);
    end;
    2:
    begin
      EnterTextInto(FoTela.sajPeriodo.FdfDataInicial, FuncaoData(FoDados.fpgDataInicio,
        CS_MASCARA_DATA_CURTA));
      EnterTextInto(FoTela.sajPeriodo.FdfDataFinal, FuncaoData(FoDados.fpgDataFim,
        CS_MASCARA_DATA_CURTA));
      EnterTextInto(FoTela.sajPeriodo.FdfHoraFinal, FoDados.fpgHoraFim);
    end;
    3:
    begin
      EnterTextInto(FoTela.sajPeriodo.FdfDataInicial, FuncaoData(FoDados.fpgDataInicio,
        CS_MASCARA_DATA_CURTA));
      EnterTextInto(FoTela.sajPeriodo.FdfDataFinal, FuncaoData(FoDados.fpgDataFim,
        CS_MASCARA_DATA_CURTA));
      EnterTextInto(FoTela.csClasse.dfCodigo, FoDados.fpgClasse);
      EnterTextInto(FoTela.csTipoCartorio.dfCdTipoCartorio, FoDados.fpgCompetencia);
    end
  end;

end;

procedure TffpgRelAnaliticoDistribTests.FecharTelaRelatorio(const poWindow: IWindow);
var
  oTelaRelatorio: TfspRPPreviewForm;
begin
  oTelaRelatorio := poWindow.asControl as TfspRPPreviewForm;
  CheckTrue(Assigned(oTelaRelatorio), 'O Relatório não foi exibido!');
  oTelaRelatorio.SBLastPage.Click;
  oTelaRelatorio.SBDone.click;
end;

procedure TffpgRelAnaliticoDistribTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.

