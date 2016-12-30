unit ufpgDigPecaProcessualTests;

interface

uses
  ufpgDigPecaProcessualModelTests, ufpgDigPecaProcessual, ufpgGUITestCase,
  ufpgDataModelTests, FutureWindows, VirtualTrees;

type
  TffpgDigPecaProcessualTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgDigPecaProcessual;
    FoDados: TffpgDigPecaProcessualModelTests;
    procedure NovaPeca;
    procedure DigitalizacaoPeca;
    procedure SelecionarTipoDocDigital(psCdDocumento: string);
    procedure PegarTelaCertificado(const poWindow: IWindow);
    procedure LiberarNosAutos;
    procedure RecategorizarPeca;
    procedure ImportarArquivo;
    procedure PegarTelaAbrirArquivo(const poWindow: IWindow);
    procedure AlterarTipoDocumento;
    function RetornarTipoDocumento: string;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarDigitalizacaoPeca;
    procedure TestarImportarArquivo;
    procedure TestarAlterarTipoDocumento;
  end;


implementation

uses
  udigCopiaPagina, udigGeral, ufpgVisualizaProcesso, Forms, Classes, SysUtils,
  uspInterface, ufpgVariaveisTestesGUI, ufpgConstanteGUITests, ufpgFuncoesGUITestes,
  ufpgConsTipoDocDigital, Controls, uspSendKeys, uedtSelecaoCeritificadoDigital,
  usajConstante, Windows, TestFramework, udigPropriedadesDocumento;

var
  FsTipoDoc1: string;
  FsTipoDoc2: string;

function TffpgDigPecaProcessualTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgDigPecaProcessualModelTests;
end;

procedure TffpgDigPecaProcessualTests.NovaPeca;
begin
  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  if FoDados.fpgOrigem <> '' then
    FoTela.imOrigem.ItemIndex := FoTela.imOrigem.Items.IndexOf(FoDados.fpgOrigem);
  ClicarBotaoDXBar(FoTela, '&Nova peça');
end;

procedure TffpgDigPecaProcessualTests.SelecionarTipoDocDigital(psCdDocumento: string);
var
  ffpgConsTipoDocDigital: TffpgConsTipoDocDigital;
begin
  ffpgConsTipoDocDigital := TffpgConsTipoDocDigital(PegarTela('ffpgConsTipoDocDigital'));
  ffpgConsTipoDocDigital.grDados.DataSource.DataSet.Locate('CDTIPODOCDIGITAL', psCdDocumento, []);
  Application.ProcessMessages;
  ffpgConsTipoDocDigital.ccCadastro.Execute(acSelecionar);
  application.ProcessMessages;
end;

procedure TffpgDigPecaProcessualTests.PegarTelaCertificado(const poWindow: IWindow);
var
  FoDadosCertificado: TfedtSelecaoCeritificadoDigital;
begin
  FoDadosCertificado := TfedtSelecaoCeritificadoDigital(poWindow.AsControl);
  Application.ProcessMessages;
  EnterTextInto(FoDadosCertificado.cbCertificados, FoDados.fpgcertificado);
  FoDadosCertificado.dxbbBotoesSelecionar.Click;
end;

procedure TffpgDigPecaProcessualTests.DigitalizacaoPeca;
begin
  FoDados := TffpgDigPecaProcessualModelTests(spDataModelTests);
  if FoDados.fpgGrauRecurso then
    spVerificadorTelas.RegistrarMensagem('O processo está em grau de recurso*', 'Ok');
  if FoDados.fpgAbrirDoMenu then
  begin
    AbrirTela;
    FoTela := TffpgDigPecaProcessual(spTela);
    if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
      FoDados.fpgNuProcesso := UsarProcessoArray;
    Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de processo não encontrado.');
    EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);
    tab;
  end
  else
  begin
    FoTela := TffpgDigPecaProcessual(PegarTela('ffpgDigPecaProcessual'));
  end;


  if FoDados.fpgDigitalizarPecas then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'Deseja digitalizar outra página deste documento?', 'Não');
    NovaPeca;
    SelecionarTipoDocDigital(FoDados.fpgTipoDoc);
  end;

  if FoDados.fpgImportarArquivos then
    ImportarArquivo;

  FoTela.ccCadastro.Execute(acSalvar);

  if FoDados.fpgLiberarNosAutos then
    LiberarNosAutos;

  if FoDados.fpgRecategorizarPeca then
    RecategorizarPeca;

  if FoDados.fpgTornarDocSigiloso then
  begin
    EnviarTeclas(FoTela.tvLiberado, '({END})');
    FoTela.bbPoloPassivoTerceiro.Click;
  end;

  if FoDados.fpgAlterarTpDoc then
    AlterarTipoDocumento;

end;

procedure TffpgDigPecaProcessualTests.TestarDigitalizacaoPeca;
begin
  ExecutarRoteiroTestes(DigitalizacaoPeca);
end;

procedure TffpgDigPecaProcessualTests.LiberarNosAutos;
begin
  EnviarTeclas(FoTela.TvNaoLiberado, '({Home}) ');
  application.ProcessMessages;
  TFutureWindows.Expect('TffpgSelecaoCeritificadoDigital').ExecProc(PegarTelaCertificado);
  FoTela.bbJuntarDocumentos.Click;
end;

procedure TffpgDigPecaProcessualTests.RecategorizarPeca;
var
  nCnt: integer;
begin
  Click(FoTela.TvLiberado);
  Application.ProcessMessages; //OK
  EnviarTeclas(FoTela.TvLiberado, '({end}{up})');
  spVerificadorTelas.RegistrarMensagem(
    'Alterando o tipo do documento, será excluída a movimenta*', 'Sim');
  nCnt := 0;
  while not FoTela.imAlteraTipoDoc.Enabled do
  begin
    Application.ProcessMessages;
    Sleep(500);
    Inc(nCnt);
    CheckFalse((nCnt > 5), 'Falha - Botão alterar tipo não habilitado!');
  end;
  FoTela.imAlteraTipoDoc.Click;
  FoDados.fpgTipoDoc := FoDados.fpgTipoDoc2;
  SelecionarTipoDocDigital(FoDados.fpgTipoDoc);
end;

procedure TffpgDigPecaProcessualTests.TestarImportarArquivo;
begin
  ExecutarRoteiroTestes(DigitalizacaoPeca);
end;

procedure TffpgDigPecaProcessualTests.ImportarArquivo;
begin
  NovaPeca;
  TFutureWindows.Expect('#32770', 10).ExecProc(PegarTelaAbrirArquivo).ExecSendKey(VK_RETURN);
  SelecionarTipoDocDigital(FoDados.fpgTipoDoc);
end;

procedure TffpgDigPecaProcessualTests.PegarTelaAbrirArquivo(const poWindow: IWindow);
var
  DlgHandle: HWND;
begin
  DlgHandle := poWindow.GetHandle;
  Application.ProcessMessages;
  Windows.SetDlgItemText(DlgHandle, 1152, PChar(ExtractFilePath(Application.ExeName) +
    CS_ARQUIVO_PDF));
end;

procedure TffpgDigPecaProcessualTests.TestarAlterarTipoDocumento;
begin
  ExecutarRoteiroTestes(DigitalizacaoPeca);
end;

procedure TffpgDigPecaProcessualTests.AlterarTipoDocumento;
begin
  FsTipoDoc1 := RetornarTipoDocumento;
  FoTela.imAlteraTipoDoc.Click;
  if gsCliente <> CS_CLIENTE_PG5_TJMS then
    spVerificadorTelas.RegistrarMensagem(
      'Alterando o tipo do documento, será excluída a movimentação associada*', 'Sim');
  SelecionarTipoDocDigital(FoDados.fpgTipoDoc2);
  FsTipoDoc2 := RetornarTipoDocumento;
  Check(FsTipoDoc1 <> FsTipoDoc2, 'O tipo de documento não foi alterado');
end;

function TffpgDigPecaProcessualTests.RetornarTipoDocumento: string;
var
  oTelaProp: TfdigPropriedadesDocumento;
begin
  FoTela.bbPropriedades.Click;
  oTelaProp := TfdigPropriedadesDocumento(PegarTela('fdigPropriedadesDocumento'));
  result := oTelaProp.lglTipoDoc.Caption;
  oTelaProp.ccPai.Execute(acFecharForm);
end;

end.

