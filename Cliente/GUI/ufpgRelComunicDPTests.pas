//30/04/2016 - Shirleano.Junior - Task: 43061
// Refatorado.
unit ufpgRelComunicDPTests;

interface

uses
  ufpgRelComunicDP, ufpgGUITestCase, ufpgRelComunicDPModelTests, ufpgDataModelTests;

type
  TffpgRelComunicDPTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRelComunicDP;
    FoDados: TffpgRelComunicDPModelTests;
    procedure RelComunicadoDelegaciaPoliciaPeriodo;
    procedure FecharEditorDocumento;
    procedure PreencherDados;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarRelComunicadoDelegaciaPolicia;
  end;

implementation

uses
  usajConstante, ufpgVariaveisTestesGUI, ufpgConstanteGUITests, ufpgFuncoesGUITestes,
  TestFrameWork, Windows, Forms, SysUtils, uspRPPreviewForm, ufpgEditor;

{ TffpgRelComunicDPTests }

procedure TffpgRelComunicDPTests.TestarRelComunicadoDelegaciaPolicia;
begin
  ExecutarRoteiroTestes(RelComunicadoDelegaciaPoliciaPeriodo);
end;

function TffpgRelComunicDPTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRelComunicDPModelTests;
end;

procedure TffpgRelComunicDPTests.RelComunicadoDelegaciaPoliciaPeriodo;
begin
  AbrirTela;
  FoTela := TffpgRelComunicDP(spTela);
  FoDados := TffpgRelComunicDPModelTests(spDataModelTests);

  PreencherDados;

  FoTela.pbVisualizar.Click;
  FecharEditorDocumento;
end;

procedure TffpgRelComunicDPTests.FecharEditorDocumento;
var
  oTelaEditor: TffpgEditor;
  bAchou: boolean;
begin
  oTelaEditor := TffpgEditor(PegarTela('ffpgEditor'));
  CheckTrue(Assigned(oTelaEditor), 'O documento não foi exibido!');

  if FoDados.fpgNuProcesso <> STRING_INDEFINIDO then
  begin
    bAchou := pos(copy(FoDados.fpgNuProcesso, 1, 13), oTelaEditor.oWPRichText.Text) > 0;
    check(bAchou, 'Falha - Não encontrou processo no texto do documento!');
  end;

  oTelaEditor.dxbbArquivoFecharEditor.Click;
end;

procedure TffpgRelComunicDPTests.PreencherDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado.');

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
  begin
    if FoDados.fpgDataInicio <> STRING_INDEFINIDO then
      EnterTextInto(FoTela.prDistribuicao.FdfDataInicial, FoDados.fpgDataInicio)
    else
      EnterTextInto(FoTela.prDistribuicao.FdfDataInicial, dateToStr(Now));

    if FoDados.fpgDataFim <> STRING_INDEFINIDO then
      EnterTextInto(FoTela.prDistribuicao.FdfDataFinal, FoDados.fpgDataFim)
    else
      EnterTextInto(FoTela.prDistribuicao.FdfDataFinal, dateToStr(Now));
  end
  else
    EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  EnterTextInto(FoTela.csTipoDocDP.dfCdTipoDocDP, FoDados.fpgDocumento);

  //if FoDados.fpgNuProcesso <> STRING_INDEFINIDO then;

end;

procedure TffpgRelComunicDPTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.

