unit ufpgCadRegSentencaTests;

interface

uses
  ufpgGUITestCase, ufpgDataModelTests, ufpgCadRegSentenca, ufpgCadRegSentencaModelTests,
  ufpgEditor;

type
  TffpgCadRegSentencaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCadRegSentenca;
    FoDados: TffpgCadRegSentencaModelTests;
    procedure CadRegSenteca;
    procedure FecharEditorDocumento(psNuProcesso: string);
    procedure PreencheDados;
    procedure VisualizaDocumento;
    function VerifiqueProcessoDocumentoEditor(poTelaEditor: TffpgEditor; psTexto: string): boolean;
  protected
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  public
  published
    procedure TestarCadRegSenteca;
  end;

implementation

uses
  TestFramework, FutureWindows, Forms, ufpgFuncoesGUITestes, SysUtils, uspInterface,
  ufpgConsDocEmitido, usajConstante;

{ TffpgCadRegSentencaTests }

procedure TffpgCadRegSentencaTests.TestarCadRegSenteca;
begin
  ExecutarRoteiroTestes(CadRegSenteca);
end;

procedure TffpgCadRegSentencaTests.CadRegSenteca;
begin
  AbrirTela;
  FoTela := TffpgCadRegSentenca(spTela);
  FoDados := TffpgCadRegSentencaModelTests(spDataModelTests);

  PreencheDados;

  FoTela.pbVincular.Click;

  VisualizaDocumento;
  Application.ProcessMessages;
  FoTela.ccCadastro.Execute(acSalvar);
  fecharTela;
  check(FoDados.VerificaProcessoRegSentenca(FoDados.fpgTipoMovimento, FoDados.fpgNuProcesso),
    'Processo informado não foi vinculado');

  check(FoDados.VerificaRegistroSentenca(FoDados.fpgNuProcesso), 'O registro não foi cadastrado');

end;

procedure TffpgCadRegSentencaTests.VisualizaDocumento;
var
  oTelaConsDocEmitido: TffpgConsDocEmitido;
  sNuProcessoFormatado: string;
begin
  oTelaConsDocEmitido := TffpgConsDocEmitido(PegarTela('ffpgConsDocEmitido'));
  oTelaConsDocEmitido.ccCadastro.Execute(acVisualizar);
  sNuProcessoFormatado := FoTela.dfCodigo.FdfNumeroProcessoExterno.Text + '.' +
    FoTela.dfCodigo.FdfNumeroProcessoExterno2.Text;
  FecharEditorDocumento(sNuProcessoFormatado);
  oTelaConsDocEmitido.ccCadastro.Execute(acSelecionar);
end;

procedure TffpgCadRegSentencaTests.PreencheDados;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  EnterTextInto(FoTela.dfCodigo.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);
  EnterTextInto(FoTela.csTipoMv.dfCodigo, FoDados.fpgTipoMovimento);
end;

procedure TffpgCadRegSentencaTests.FecharEditorDocumento(psNuProcesso: string);
var
  oTelaEditor: TffpgEditor;
begin
  oTelaEditor := TffpgEditor(PegarTela('ffpgEditor'));
  CheckTrue(Assigned(oTelaEditor), 'O documento não foi exibido!');
  check(VerifiqueProcessoDocumentoEditor(oTelaEditor, FoDados.fpgNuProcesso),
    'O documento não pertence ao processo informado');
  oTelaEditor.dxbbArquivoFecharEditor.Click;
end;

function TffpgCadRegSentencaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCadRegSentencaModelTests;
end;

function TffpgCadRegSentencaTests.VerifiqueProcessoDocumentoEditor(poTelaEditor: TffpgEditor;
  psTexto: string): boolean;
var
  i: integer;
begin
  result := False;
  i := pos(psTexto, poTelaEditor.oWPRichText.Text);
  poTelaEditor.oWPRichText.SelStart := i;
  poTelaEditor.oWPRichText.SelLength := length(psTexto);
  Application.ProcessMessages;
  if SomenteNumeros(poTelaEditor.oWPRichText.SelText) = SomenteNumeros(psTexto) then
  begin
    result := True;
  end;
end;

end.

