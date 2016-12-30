unit ufpgEditorTests;

interface

uses
  ufpgEditor, ufpgGUITestCase, ufpgEditorModelTests, FutureWindows, ufpgDataModelTests,
  uedtDocumentoEDT, ufpgConfigAtos;

type
  TffpgEditorTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgEditor;
    FoDados: TffpgEditorModelTests;
    FoDocAtual: TDocumentoEDT;
    procedure Editor;
    procedure AplicarEstilosTexto;
    procedure ExportarArquivo;
    procedure FecharArquivo;
    procedure ImportarArquivo;
    procedure PropriedadesDocumento;
    procedure FinalizarDocumento;
    procedure PreencherImportacao;
    procedure SalvarDocumento;
    procedure CorrigirTexto;
    procedure NomearDocumento(const poWindow: IWindow);
    procedure TrocarPalavras(const poWindow: IWindow);
    procedure AlterarEndereco(const poWindow: IWindow);
    procedure EditarOficio;
    procedure VerificarDadosAR;
    procedure VerificarDocumento;
    procedure FinalizarDocPeloPainelAuxiliar;
    function DestacarTexto(psTexto: string): integer;
    procedure ImprimirAR;
    procedure ConfigurarAtos;
    procedure PreencherDadosConfiguracaoAtos(poTela: TffpgConfigAtos);
    procedure ConfigurarNovoAtos;
    procedure InserirObservacao;
    procedure ImprimirBotao;
    // 18/10/16 - cesar.almeida - Verificação do Cut and Paste
    procedure CopiarColarTexto;
    // 27/10/16 - cesar.almeida - Inserir Complemento da movimentação
    procedure InserirCompMovParagrafo;
    //31/10/2016 - Luciano.fagundes - Verificar quantidade de caracteres da parte requerente
    function VerificaQtdeCaratcer: boolean;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure SetUp; override;
  published
    procedure TestarEditor;
  end;

implementation

uses
  TestFrameWork, uedtSelecaoCeritificadoDigital, uspInterface, uedtWPRichText,
  SysUtils, Windows, Forms, usajConstante, ufpgVariaveisTestesGUI, Controls,
  ufpgPropriedadesDocumentoInspec, uggpImportacaoDocumentos, Classes, StdCtrls,
  ufpgConstanteGUITests, ufpgFuncoesGUITestes, uspSendKeys, ComCtrls, dxExEdtr,
  Graphics, ufpgRepositorioRelatorios, ufpgConfigAtosDocumentoReduzido,
  ufpgEdicaoDocumento, ufpgEdicaoDocumentoAutomatico, uedtFuncoes;

var
  bAutoSalvamento: boolean;
  bChecarDocumento: boolean;
  bChecarAr: boolean;
  sNomeArquivoSalvar: string;

procedure TffpgEditorTests.TestarEditor;
begin
  ExecutarRoteiroTestes(Editor);
end;

procedure TffpgEditorTests.Editor;
begin
  FoDados := TffpgEditorModelTests(spDataModelTests);
  bAutoSalvamento := True;


  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgEditor');

  FoTela := TffpgEditor(spTela);


  if FoDados.fpgUsaProcesso then
  begin
    if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
      FoDados.fpgNuProcesso := UsarProcessoArray;
    Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de processo não encontrado.');
  end;

  if FoDados.fpgRgistrarMensagemModeloDependente then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'O modelo deste documento possui modelo(s) dependente(s).*', 'Sim');
  end;

  if FoDados.FpgNovoDocumento then
    FoTela.dxbbArquivoNovo.Click;

  FoDocAtual := (FoTela.oDocumentoAtual) as TDocumentoEDT;
  CheckTrue(Assigned(FoDocAtual), 'O documento não foi exibido!');

  if FoDados.fpgCorrigirTexto then
    CorrigirTexto
  else if FoDados.fpgTextoCerto <> STRING_INDEFINIDO then
    FoTela.oWPRichText.LoadFromString(FoDados.fpgTextoCerto);

  Application.ProcessMessages;

  //31/10/2016 - Luciano.fagundes - Verificar quantidade de caracteres da parte requerente
  if FoDados.fpgVerificaQtdeCaracter then
    Check(VerificaQtdeCaratcer, 'O texto não possui 200 caracteres');

  if FoDados.fpgPintarAmarelo then
    DestacarTexto('Texto Amarelo');

  if FoDados.fpgMsgSemSalvar then
    spVerificadorTelas.RegistrarMensagem('Houve alterações no conteúdo*', 'Não');

  if FoDados.fpgInserirObeservacao then
    InserirObservacao;

  if FoDados.fpgSalvarDocumento then
    SalvarDocumento;

  if FoDados.fpgAplicarEstilos then
    AplicarEstilosTexto;

  gsNuDocumento := IntToStr(TDocumentoEDT(FoTela.oDocumentoAtual).ncdDocumento);
  gsDataEmissao := TDocumentoEDT(FoTela.oDocumentoAtual).sDataHoraUltimoSalvamentoNoBanco;
  if StrToInt(FoDados.fpgCategoria) = CN_MANDADO then
    gsNuMandado := SomenteNumeros(Copy(TDocumentoEDT(FoTela.oDocumentoAtual).sComplemento,
      12, 18));

  if FoDados.fpgExportar then
    ExportarArquivo;

  application.ProcessMessages;

  if FoDados.fpgImportar then
    ImportarArquivo;

  if FoDados.fpgInserirMov then
    FoTela.dxBarFerramentasMovimentacaoUnitaria.Click;

  // 27/10/16 - cesar.almeida - Inserir Complemento da movimentação
  if FoDados.fpgInserirCompMovParagrafo then
    InserirCompMovParagrafo;

  if FoDados.fpgLancarMovimentacao then
    PropriedadesDocumento;

  if FoDados.fpgImportarMultimidia then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'Deseja vincular os arquivos que serão importados ao documento visualizado?', 'Sim');
    FoTela.dxImportacaoMultimidia.Click;
  end;

  if FoDados.fpgGerarAto then
  begin
    FoTela.dxbbFerramentasAtosDocumento.Click;
    ConfigurarAtos;
  end;

  if FoDados.fpgFinalizaDocumento then
    FinalizarDocumento;

  if FoDados.fpgAbrirEdicaoModelo then
    exit;

  if FoDados.fpgFinalizarPainelAuxiliar then
    FinalizarDocPeloPainelAuxiliar;

  if FoDados.fpgImprimirAR then
  begin
    FoTela.dxbbArquivoVisualizarAR.Click;
    ImprimirAR;
  end;

  // 18/10/16 - cesar.almeida - Verificação do Cut and Paste
  if FoDados.fpgVerifcarCopiarColar then
    CopiarColarTexto;

  if FoDados.fpgEditarOficio then
    EditarOficio;

  if FoDados.fpgImprimirBotao then
    ImprimirBotao;

  if FoDados.fpgCadastrarAutoTexto then
    FoTela.oWPRichText.SetFocus;

  if FoDados.fpgFecharArquivo then
    FecharArquivo;

  if FoDados.fpgFecharTela then
    spVerificadorTelas.FecharTelasAbertas;


  VerificarDocumento;
end;

procedure TffpgEditorTests.AlterarEndereco(const poWindow: IWindow);
var
  DlgHandle: HWND;
begin
  DlgHandle := poWindow.GetHandle;
  bAutoSalvamento := False;
  Windows.SetDlgItemText(DlgHandle, 1152, PChar(sNomeArquivoSalvar));
end;

function TffpgEditorTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgEditorModelTests;
end;

procedure TffpgEditorTests.TrocarPalavras(const poWindow: IWindow);
var
  oControl: TControl;
  oList: TStrings;
  FoDados: TffpgEditorModelTests;
begin
  FoDados := (Self.spDataModelTests) as TffpgEditorModelTests;
  oList := TStringList.Create;
  try
    oList.CommaText := FoDados.fpgTextoCerto;
    oControl := poWindow.AsControl;

    TEdit(oControl.Components[4]).Text := oList[1];
    TButton(oControl.Components[10]).Click; //10 - TrocarTodas - 'ChangeAllButton'

    TEdit(oControl.Components[4]).Text := oList[3];
    TButton(oControl.Components[10]).Click; //10 - TrocarTodas - 'ChangeAllButton'
  finally
    FreeAndNil(oList);
  end;
end;

procedure TffpgEditorTests.FecharArquivo;
begin
  //  spVerificadorTelas.RegistrarMensagem('Houve alterações no conteúdo*', 'Não');
  FoTela.dxbbArquivoFechar.Click;
end;

procedure TffpgEditorTests.AplicarEstilosTexto;
begin
  FoTela.oWPRichText.MoveCursorParaInicioDoParagrafo(False);
  FoTela.oWPRichText.SelecioneRestoDoParagrafo(False);

  FoTela.dxbbWPNegrito.click;
  FoTela.dxbbWPItalico.click;
  FoTela.dxbbWPSublinhado.click;
end;

procedure TffpgEditorTests.ExportarArquivo;
begin
  sNomeArquivoSalvar := somenteNumeros(DateTimeToStr(now)) + '.rtf';
  TFutureWindows.Expect(MESSAGE_BOX_WINDOW_CLASS).ExecProc(NomearDocumento).ExecSendKey(VK_RETURN);
  FoTela.dxbbArquivoExportar.click;
  FoTela.dxbbArquivoFechar.Click;
end;

procedure TffpgEditorTests.ImportarArquivo;
begin
  TFutureWindows.Expect(MESSAGE_BOX_WINDOW_CLASS).ExecProc(NomearDocumento).ExecSendKey(VK_RETURN);
  FoTela.dxbbArquivoImportar.click;
  PreencherImportacao;
  FoDocAtual := (FoTela.oDocumentoAtual) as TDocumentoEDT;
  CheckTrue(Assigned(FoDocAtual), 'O documento não foi exibido!');
  application.ProcessMessages;
  FecharArquivo;
end;

procedure TffpgEditorTests.PreencherImportacao;
var
  oTelaImportacao: TfggpImportacaoDocumentos;
begin
  oTelaImportacao := TfggpImportacaoDocumentos(PegarTela('fggpImportacaoDocumentos'));

  EnterTextInto(oTelaImportacao.edtCategoriaCons.dfCodigo, FoDados.fpgCategoria);

  TFutureWindows.Expect('TfsajAssistente', 1000).ExecCloseWindow;
  EnterTextInto(oTelaImportacao.sajProcesso.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcesso, False);

  EnterTextInto(oTelaImportacao.edArquivoImportado, sNomeArquivoSalvar);

  Application.ProcessMessages;

  oTelaImportacao.dxbbBotoesSelecionar.Click;
end;

procedure TffpgEditorTests.FinalizarDocumento;
var
  oTelaFinalizar: TfedtSelecaoCeritificadoDigital;
begin

  if FoDados.fpgFinalizaDocumentoMenu then
    FoTela.dxAssinaturaDigital.Click
  else
    FoTela.dxFinalizarDocumento.Click;

  if FoDados.fpgRgistrarMensagemModeloDependente then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'O modelo deste documento possui modelo(s) dependente(s).*', 'Sim');
  end;


  oTelaFinalizar := TfedtSelecaoCeritificadoDigital(PegarTela('fedtSelecaoCeritificadoDigital'));


  EnterTextRadioGroup(oTelaFinalizar.rgOpcao, FoDados.fpgAcaoFinalizar);


  if FoDados.fpgRegistrarMsgAssinaturaJuiz then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'O documento selecionado necessita da assinatura de Juiz*', 'Sim');
  end;

  if FoDados.fpgRegistrarConfirmarConfiguracao then
  begin
    spVerificadorTelas.RegistrarMensagem('Os documentos do tipo*', 'Confirmar configuração');
  end;

  if FoDados.fpgRegistrarConfirmarConfiguracaoImpressao then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'O documento Outros está configurado para ser impresso anexo a este documento.',
      'Confirmar configuração');
  end;
  if FoDados.fpgRegistrarMsgNaoConfirmado then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'Não foi possível confirmar os atos automaticamente*', 'OK');
  end;

  if FoDados.fpgRegistraMsgMandado then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'O documento Despacho está configurado para ser impresso anexo a este documento.',
      'Cancelar');
  end;

  if FoDados.fpgRegistrarMsgNaoConfirmado then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'Não foi possível confirmar os atos automaticamente*', 'OK');
  end;
  if FoDados.fpgRegistrarMsgAssinaturaOficialJustica then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'O documento selecionado necessita da assinatura de Oficial*', 'Sim');
  end;
  if FoDados.fpgRegistrarMsgEscrivao then
  begin
    spVerificadorTelas.RegistrarMensagem(
      'O documento selecionado necessita da assinatura de Escrivão*', 'Sim');
  end;

  EnterTextInto(oTelaFinalizar.cbCertificados, FoDados.fpgCertificado);
  oTelaFinalizar.dxbbBotoesSelecionar.Click;
end;

procedure TffpgEditorTests.PropriedadesDocumento;
var
  oTelaPropriedades: TffpgPropriedadesDocumentoInspec;
begin
  FoTela.dxbbPainelAuxiliarPropriedades.Click;
  oTelaPropriedades := PegarTela('ffpgPropriedadesDocumentoInspec') as
    TffpgPropriedadesDocumentoInspec;

  oTelaPropriedades.rowMovimentacao.spConsulta.spValorCodigo := FoDados.fpgMovimentacao;

  if FoDados.fpgVerificarDocFinalizado then
    checkTrue(oTelaPropriedades.rowDataFinalizacao.Text <> STRING_INDEFINIDO,
      'Documento não finalizado');

  if FoDados.fpgVerificarDocAssinado then
    checkTrue(oTelaPropriedades.rowAssinadoDigitalmente.ValueChecked = sFLAG_SIM,
      'Documento não assinado');
end;

procedure TffpgEditorTests.NomearDocumento(const poWindow: IWindow);
var
  DlgHandle: HWND;
begin
  DlgHandle := poWindow.GetHandle;
  Windows.SetDlgItemText(DlgHandle, 1152, PChar(sNomeArquivoSalvar));
end;

procedure TffpgEditorTests.SalvarDocumento;
var
  sCaminhoCompleto: string;
begin
  sNomeArquivoSalvar := somenteNumeros(DateTimeToStr(now)) + '.rtf';

  TFutureWindows.Expect(MESSAGE_BOX_WINDOW_CLASS).ExecProc(AlterarEndereco);
  TFutureWindows.Expect(MESSAGE_BOX_WINDOW_CLASS).ExecSendKey(VK_TAB);
  TFutureWindows.Expect(MESSAGE_BOX_WINDOW_CLASS).ExecSendKey(VK_TAB);
  TFutureWindows.Expect(MESSAGE_BOX_WINDOW_CLASS).ExecSendKey(VK_RETURN);

  FoTela.dxbbArquivoSalvar.Click;
  sleep(3000);

  sCaminhoCompleto := copy(FoDocAtual.sPathLocalDocumento, 0,
    Length(FoDocAtual.sPathLocalDocumento) - 4) + '(' + IntToStr(FoDocAtual.nCdDocumento) +
    ')' + copy(FoDocAtual.sPathLocalDocumento, Length(FoDocAtual.sPathLocalDocumento) -
    3, Length(FoDocAtual.sPathLocalDocumento));

  if bAutoSalvamento then
    check(FileExists(sCaminhoCompleto), 'O documento não foi salvo.')
  else
    check(FileExists(sNomeArquivoSalvar), 'O documento não foi salvo.');
end;

procedure TffpgEditorTests.CorrigirTexto;
var
  sTextoDocumento: string;
  sTextoCorreto: string;
begin
  FoTela.oWPRichText.LoadFromString(FoDados.fpgTextoErrado);
  Application.ProcessMessages;

  TFutureWindows.Expect('TSpellDialog', 2000).ExecProc(TrocarPalavras);
  TFutureWindows.Expect(MESSAGE_BOX_WINDOW_CLASS).ExecCloseWindow;

  FoTela.dxbbFerramentasOrtografia.Click;
  sTextoDocumento := trim(FoTela.oWPRichText.Lines.GetText);
  sTextoCorreto := StringReplace(FoDados.fpgTextoCerto, ',', ' ', [rfReplaceAll, rfIgnoreCase]);
  check(sTextoDocumento = sTextoCorreto, 'A verificação ortográfica falhou');
  Application.ProcessMessages;
end;

procedure TffpgEditorTests.EditarOficio;
var
  oTelaPropriedades: TffpgPropriedadesDocumentoInspec;
begin
  FoTela.dxbbPainelAuxiliarPropriedades.Click;
  oTelaPropriedades := PegarTela('ffpgPropriedadesDocumentoInspec') as
    TffpgPropriedadesDocumentoInspec;
  oTelaPropriedades.rowModoFinalizacao.Text := FoDados.fpgModoFinalizacao;
  oTelaPropriedades.rowFinalizarToggleClick(oTelaPropriedades.rowFinalizar,
    STRING_INDEFINIDO, cbsChecked);
  Application.ProcessMessages;
  FoTela.acPainelAuxiliarFecharExecute(Self);
  //  spVerificadorTelas.RegistrarMensagem('O documento não*', 'SIM');
  FoTela.dxbbArquivoSalvar.Click;
  FoTela.dxbbArquivoVisualizarAR.Click;
  Application.ProcessMessages;

  if FoDados.fpgTipoDocumento = CS_AR then
  begin
    bChecarDocumento := False;
    VerificarDadosAR;
  end;

  Application.ProcessMessages;
  FoTela.dxbbArquivoFecharEditor.Click;
end;

procedure TffpgEditorTests.VerificarDadosAR;
var
  oTelaRelatorioAR: TffpgRepositorioRelatorios;
  cdsDadosPagina: PDadosAR;
begin
  bChecarAr := True;
  oTelaRelatorioAR := PegarTela('ffpgRepositorioRelatorios') as TffpgRepositorioRelatorios;
  cdsDadosPagina := oTelaRelatorioAR.edtDocumentoAtual.ptrDadosAr;
  oTelaRelatorioAR.edtDocumentoAtual.InicializeDadosAR(True);
  gsNuAR := cdsDadosPagina.ncdAR;
  oTelaRelatorioAR.dximImprimir.Click;
  Application.ProcessMessages;
  oTelaRelatorioAR.dximFechar.Click;
end;

procedure TffpgEditorTests.FinalizarDocPeloPainelAuxiliar;
var
  oTelaPropriedades: TffpgPropriedadesDocumentoInspec;
  sTexto: string;
begin
  FoTela.dxbbArquivoSalvar.Click;
  FoTela.acPainelAuxiliarFecharExecute(Self);
  FoTela.dxbbPainelAuxiliarPropriedades.Click;

  oTelaPropriedades := PegarTela('ffpgPropriedadesDocumentoInspec') as
    TffpgPropriedadesDocumentoInspec;

  oTelaPropriedades.rowModoFinalizacao.Text := FoDados.fpgModoFinalizacao;
  oTelaPropriedades.rowFinalizarToggleClick(oTelaPropriedades.rowFinalizar, sTexto, cbsChecked);
  Application.ProcessMessages;

  FoTela.acPainelAuxiliarFecharExecute(Self);
  FoTela.dxbbArquivoSalvar.Click;
end;

procedure TffpgEditorTests.VerificarDocumento;
begin
  if bChecarDocumento then
    Check(FoDados.VerificarDocEmitido(FoDados.fpgCategoria, FoDados.fpgModelo,
      FoDados.fpgNuProcesso),
      'O documento não foi emitido.');
  if bChecarAr then
    Check(FoDados.VerificarARGerada(gsNuAR), 'A ar não foi gerado.');
end;

function TffpgEditorTests.DestacarTexto(psTexto: string): integer;
var
  nPos: integer;
begin
  FoTela.pbCorDeFundo.SetFocus;
  FoTela.pbCorDeFundo.ActiveColor := clYellow;
  EnviarTeclas(FoTela.oWPRichText, '(^{END})');
  EnviarTeclas(FoTela.oWPRichText, '(~)');
  EnviarTeclas(FoTela.oWPRichText, '(^{END})');
  nPos := FoTela.oWPRichText.CPPosition;
  EnviarTeclas(FoTela.oWPRichText, psTexto);
  FoTela.oWPRichText.SelecioneRestoDoParagrafo(False);
  Click(FoTela.pbCorDeFundo);
  EnviarTeclas(FoTela.oWPRichText, '(^{HOME})');
  FoTela.oWPRichText.SelStart := nPos;
  FoTela.oWPRichText.SelLength := Length(psTexto);
  result := nPos;
end;

procedure TffpgEditorTests.ImprimirAR;
var
  oTelaRelatorioAR: TffpgRepositorioRelatorios;
begin
  oTelaRelatorioAR := PegarTela('ffpgRepositorioRelatorios') as TffpgRepositorioRelatorios;
  oTelaRelatorioAR.edtDocumentoAtual.InicializeDadosAR(True);
  oTelaRelatorioAR.dximImprimir.Click;
  sleep(3000);
  Application.ProcessMessages;
  oTelaRelatorioAR.dximFechar.Click;
end;

procedure TffpgEditorTests.ConfigurarAtos;
var
  oTelaAtos: TffpgConfigAtosDocumentoReduzido;
begin
  oTelaAtos := PegarTela('ffpgConfigAtosDocumentoReduzido') as TffpgConfigAtosDocumentoReduzido;
  if FoDados.fpgNovoAto then
  begin
    oTelaAtos.dxbbBotoesNovo.Click;
    ConfigurarNovoAtos;
  end;
  spVerificadorTelas.RegistrarMensagem(
    'Deseja confirmar a configuração do(s) atos(s) selecionados(s)?', 'SIM');
  spVerificadorTelas.RegistrarMensagem('É obrigatória a informação do nome do Escrivão.', 'OK');
  oTelaAtos.bbGerarAtos.Click;

end;

procedure TffpgEditorTests.ConfigurarNovoAtos;
var
  oTelaConfig: TffpgConfigAtos;
begin
  oTelaConfig := PegarTela('ffpgConfigAtos') as TffpgConfigAtos;
  oTelaConfig.tvPessoas.Items.Item[2].Selected := True;
  oTelaConfig.tvPessoasChange(oTelaConfig.tvPessoas, oTelaConfig.tvPessoas.Selected);
  PreencherDadosConfiguracaoAtos(oTelaConfig);
  spVerificadorTelas.RegistrarMensagem(
    'Existem 1 pessoa(s) com ato(s) configurado(s). Deseja salvar?', 'SIM');
  oTelaConfig.ccPrincipal.Execute(acSalvar);
end;

procedure TffpgEditorTests.PreencherDadosConfiguracaoAtos(poTela: TffpgConfigAtos);
begin
  EnterTextInto(poTela.cbTipoAto, FoDados.fpgTipoAto, False);
  // Não consegui identificar porque estava limpando o combo
  // mas passando o texto duas vezes funciona
  EnterTextInto(poTela.cbTipoAto, FoDados.fpgTipoAto, False);
  EnterTextInto(poTela.sajConvenioConsFormaAto.dfcdConvenio, FoDados.fpgConvenio, False);

  EnterTextInto(poTela.wflFormaAtoCons.dfcdFormaAto, FoDados.fpgFormaAto, False);
  EnterTextInto(poTela.wflFormaAtoCons.dfcdFormaAto, FoDados.fpgFormaAto, False);

  EnterTextInto(poTela.dfnuDiasPrazo, FoDados.fpgPrazoAto, False);
  EnterTextInto(poTela.dfnuDiasPrazo, FoDados.fpgPrazoAto, False);

  EnterTextInto(poTela.edtModeloCons.dfcodigo, FoDados.fpgModeloAto, False);
  EnterTextInto(poTela.edtModeloCons.dfcodigo, FoDados.fpgModeloAto, False);
end;

procedure TffpgEditorTests.InserirObservacao;
begin
  FoTela.dxbbPainelAuxiliarObservacoes.Click;
  FoTela.dxbbPainelAuxiliarNovo.Click;
  EnterTextInto(FoTela.mmObservacao, FoDados.fpgObservacao);
  FoTela.dxbbPainelAuxiliarSalvar.Click;
end;

procedure TffpgEditorTests.SetUp;
begin
  spFecharTelaNoTearDown := False;
  inherited;
end;


// 18/10/16 - cesar.almeida - Verificação do Cut and Paste
procedure TffpgEditorTests.CopiarColarTexto;
var
  sTextoTela: string;
begin

  //  ClicarItemMenu('dxbbEditarSelecionarTudo');
  FoTela.dxbbEditarSelecionarTudo.Click;
  sleep(2000);
  //  ClicarItemMenu('dxbbEditarCopiar');
  FoTela.dxbbEditarCopiar.Click;
  sleep(2000);
  //  ClicarItemMenu('dxbbEditarColar');
  //  FoTela.dxbbEditarColar.Click;

  spVerificadorTelas.RegistrarMensagem('Houve alterações no conteúdo*', 'Não');

  FoTela.dxbbArquivoFechar.Click;

  FoTela.dxbbArquivoNovo.Click;

  FoTela.dxbbEditarColar.Click;

  sTextoTela := trim(FoTela.oWPRichText.Lines.GetText);

  check(sTextoTela = trim(FoDados.fpgTextoCerto), 'O texto não foi copiado e colado corretamente');
end;

// 27/10/16 - cesar.almeida - Inserir Complemento da movimentação
procedure TffpgEditorTests.InserirCompMovParagrafo;
begin
  FoTela.oWPRichText.MoveCursorParaInicioDoParagrafo(False);
  FoTela.oWPRichText.SelecioneRestoDoParagrafo(False);
  Application.ProcessMessages;

  FoTela.dxbbEditarComplemento.Click;
end;

//31/10/2016 - Luciano.fagundes - Verificar quantidade de caracteres da parte requerente
function TffpgEditorTests.VerificaQtdeCaratcer: boolean;
var
  sTexto: string;
begin
  result := False;
  sTexto := StringReplace(FoTela.oWPRichText.Text, #$D#$A, '', [rfReplaceAll]);
  sTexto := StringReplace(sTexto, #9, '', [rfReplaceAll]);
  stexto := copy(stexto, (pos(gsTextoCadPessoaControlado, (sTexto))), 200);

  Application.ProcessMessages;
  if stexto = gsTextoCadPessoaControlado then
  begin
    result := True;
  end;

  Application.ProcessMessages;

end;

procedure TffpgEditorTests.ImprimirBotao;
var
  sSenhaPartes: string;
begin

  FoTela.dxbbArquivoImprimirBotao.Click;
  sSenhaPartes := LeSenhaDoProcesso(FoDocAtual.oWPRichText,
    TDocumentoEDT(FoDocAtual).oCDSCamposDoModelo, TDocumentoEDT(FoDocAtual).sCdProcesso,
    TDocumentoEDT(FoDocAtual).PegarDadosMesclagem(1), NUMERO_INDEFINIDO);
  Check((sSenhaPartes <> ''), 'A senha não foi exibida na impressão');

end;

end.

