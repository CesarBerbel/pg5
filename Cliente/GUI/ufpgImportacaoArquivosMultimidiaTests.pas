//29/04/2016 - ANTONIO.SOUSA - Task: 43061
// Refatorado.
unit ufpgImportacaoArquivosMultimidiaTests;

interface

uses
  ufpgImportacaoArquivosMultimidia, ufpgGUITestCase, ufpgImportacaoArquivosMultimidiaModelTests,
  ufpgDataModelTests, Windows, FutureWindows;

type
  TffpgImportacaoArquivosMultimidiaTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgImportacaoArquivosMultimidia;
    FoDados: TffpgImportacaoArquivosMultimidiaModelTests;
    procedure ImportacaoArquivosMultimidia;
    procedure PegarTelaAbrirArquivo(const poWindow: IWindow);
    procedure PreencherCampos;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarImportacaoArquivosMultimidia;
  end;

implementation

uses
  TestFrameWork, uspInterface, Forms, usajConstante, ufpgFuncoesGUITestes;

function TffpgImportacaoArquivosMultimidiaTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgImportacaoArquivosMultimidiaModelTests;
end;

procedure TffpgImportacaoArquivosMultimidiaTests.ImportacaoArquivosMultimidia;
begin
  FoDados := TffpgImportacaoArquivosMultimidiaModelTests(spDataModelTests);
  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgImportacaoArquivosMultimidia');

  FoTela := TffpgImportacaoArquivosMultimidia(spTela);

  if FoDados.fpgRegistrarMensagem then
    spVerificadorTelas.RegistrarMensagem('Importação realizada com sucesso*', 'OK');

  TFutureWindows.Expect('#32770', 10).ExecProc(PegarTelaAbrirArquivo).ExecSendKey(VK_RETURN);
  FoTela.bcMaisMenos.spControleCadastro.Execute(acNovo);
  PreencherCampos;
  FoTela.bcBotoesCadastro.spControleCadastro.Execute(acSalvar);

  if FoDados.fpgFecharTela then
    FecharTela;
end;

procedure TffpgImportacaoArquivosMultimidiaTests.PegarTelaAbrirArquivo(const poWindow: IWindow);
var
  DlgHandle: HWND;
begin
  DlgHandle := poWindow.GetHandle;
  Application.ProcessMessages;
  Windows.SetDlgItemText(DlgHandle, 1152, PChar(FoDados.fpgNomeArquivo));
end;

procedure TffpgImportacaoArquivosMultimidiaTests.PreencherCampos;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de processo não encontrado.');
  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  EnterTextInto(FoTela.mmObjetivo, FoDados.fpgMotivo);
  EnterTextInto(FoTela.cbCertificados, FoDados.fpgCertificado);
end;

procedure TffpgImportacaoArquivosMultimidiaTests.TestarImportacaoArquivosMultimidia;
begin
  ExecutarRoteiroTestes(ImportacaoArquivosMultimidia);
end;

end.

