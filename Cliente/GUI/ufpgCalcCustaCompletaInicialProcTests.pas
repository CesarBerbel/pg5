unit ufpgCalcCustaCompletaInicialProcTests;

interface

uses
  TestFrameWork, ufpgDataModelTests, uspGUITestCase, ufpgGUITestCase, FutureWindows,
  ufpgCalcCustaCompletaInicialProc, ufpgCalcCustaCompletaInicialProcModelTests;

type
  TffpgCalcCustaCompletaInicialProcTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCalcCustaCompletaInicialProc;
    FoDados: TffpgCalcCustaCompletaInicialProcModelTests;
    procedure CustaInicialProcesso;
    procedure PreencherDados;
    procedure RelatorioCustas;
    procedure PegarTelaSalvarArquivo(const poWindow: IWindow);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarCustaInicialProcesso;
  end;

implementation

uses
  uccp5RelCalcCustaGrj, uspInterface, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  Windows, Forms, ufpgFuncoesGUITestes, SysUtils;

var
  sValor: string;

procedure TffpgCalcCustaCompletaInicialProcTests.CustaInicialProcesso;
begin
  AbrirTela;
  FoTela := TffpgCalcCustaCompletaInicialProc(spTela);
  FoDados := TffpgCalcCustaCompletaInicialProcModelTests(spDataModelTests);

  PreencherDados;

  FoTela.bcBotoesCadastro.spControleCadastro.Execute(acSalvar);
  gsForo := FoTela.eccpCalcCusta.FieldByName('CDFORO').AsString;
  FoTela.bcBotoesCadastro.spControleCadastro.Execute(acImprimir);

  RelatorioCustas;

  FecharTela;
  sValor := Copy(gsNuGuiaGRJ, 4, Length(gsNuGuiaGRJ));
  check(FoDados.VerificarGuia(gsForo, sValor, False), 'Falha - Validar Guia Emitida!');
end;

function TffpgCalcCustaCompletaInicialProcTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCalcCustaCompletaInicialProcModelTests;
end;

procedure TffpgCalcCustaCompletaInicialProcTests.PreencherDados;
var
  i: integer;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  for i := 0 to FoTela.grvGrupoRecol.Count - 1 do
    if FoTela.grvGrupoRecol.Grupo[i].deResumida = FoDados.fpgDeResumida then
    begin
      FoTela.grvGrupoRecol.SelecionaGrupo(FoTela.grvGrupoRecol.Grupo[i].cdGrupoStr);
      Application.ProcessMessages;
      Break;
    end;

  if FoDados.fpgConducao then
  begin
    FoTela.grVincRecolCusta.DataSource.DataSet.First;
    FoTela.bcCalcCustaHist.spControleCadastro.Execute(acNovo);
    EnterTextGrid(FoTela.grCalcCustaHist, FoDados.fpgConducaoComplemento, 0);
    EnterTextGrid(FoTela.grCalcCustaHist, FoDados.fpgAgente, 2);
    EnterTextGrid(FoTela.grCalcCustaHist, FoDados.fpgLocalidade, 6);
    EnterTextGrid(FoTela.grCalcCustaHist, FoDados.fpgConducaoKm, 15);
    EnterTextGrid(FoTela.grCalcCustaHist, FoDados.fpgConducaoFator, 22);
    Click(FoTela.grCalcCustaHist);
    //    Tab;
    sValor := FoTela.grCalcCustaHist.DataSource.DataSet.FieldByName('VLCALCULADO').AsString;
    Check(sValor = FoDados.fpgConducaoCalculo, 'Falha - Valor Calculo Condução!');
  end;

  if FoDados.fpgIntimacao then
  begin
    FoTela.grVincRecolCusta.DataSource.DataSet.Next;
    FoTela.bcCalcCustaHist.spControleCadastro.Execute(acNovo);
    spVerificadorTelas.RegistrarMensagem('Este cálculo ainda não está disponível*', 'Não');
    spVerificadorTelas.RegistrarMensagem('A guia foi emitida com sucesso*', 'OK');
    EnterTextGrid(FoTela.grCalcCustaHist, FoDados.fpgIntimacaoComplemento, 0);
    EnterTextGrid(FoTela.grCalcCustaHist, FoDados.fpgIntimacaoFator, 22);
    Click(FoTela.grCalcCustaHist);
    //    Tab;
    sValor := FoTela.grCalcCustaHist.DataSource.DataSet.FieldByName('VLCALCULADO').AsString;
    Check(sValor = FoDados.fpgIntimacaoCalculo, 'Falha - Valor Calculo Intimação!');
  end;

  if FoDados.fpgTaxa then
  begin
    spVerificadorTelas.RegistrarMensagem('A guia foi emitida com sucesso*', 'OK');
    spVerificadorTelas.RegistrarMensagem('Este cálculo ainda não está disponível*', 'Não');
  end;
end;

procedure TffpgCalcCustaCompletaInicialProcTests.RelatorioCustas;
var
  oTelaRelCustaGRJ: Tfccp5RelCalcCustaGrj;
  sMensagemCapturada: string;
begin
  oTelaRelCustaGRJ := PegarTela('fccp5RelCalcCustaGrj') as Tfccp5RelCalcCustaGrj;
  oTelaRelCustaGRJ.dfnmInteressado.DefineTexto('TesteAutomatizado - ' + FoDados.fpgNuProcesso);
  oTelaRelCustaGRJ.dfdeEndereco.DefineTexto('Endereco Automatizado - ' + FoDados.fpgNuProcesso);
  EnterTextRadioGroup(oTelaRelCustaGRJ.rgTipoRelatorio, '&Guia');
  Check(oTelaRelCustaGRJ.dfnuCopiasGrj.Text = FoDados.fpgNuCopias,
    'Erro - Nro de Copias Não é igual a ' + FoDados.fpgNuCopias);
  EnterTextCheckBox(oTelaRelCustaGRJ.ckArquivo, True);
  TFutureWindows.Expect('#32770', 10).ExecProc(PegarTelaSalvarArquivo).ExecSendKey(VK_RETURN);
  oTelaRelCustaGRJ.pbImprimir.Click;

  check(FileExists(CS_SALVAR_ARQUIVO_PDF), 'Falha ao gerar PDF Guia!');
  sValor := FoTela.grCalcCustaHist.DataSource.DataSet.FieldByName('VLCALCULADO').AsString;
  Check(sValor = FoDados.fpgTotalCalculo, 'Falha - Valor Calculo Total!');

  sMensagemCapturada := copy(PChar(spVerificadorTelas.spMensagemForm),
    StrLen(PChar(spVerificadorTelas.spMensagemForm)) - 15, 15);
  gsNuGuiaGRJ := SomenteNumeros(sMensagemCapturada);
  oTelaRelCustaGRJ.pbFechar.Click;
end;

procedure TffpgCalcCustaCompletaInicialProcTests.PegarTelaSalvarArquivo(const poWindow: IWindow);
var
  DlgHandle: HWND;
begin
  DlgHandle := poWindow.GetHandle;
  Application.ProcessMessages;
  Windows.SetDlgItemText(DlgHandle, 1152, PChar(CS_SALVAR_ARQUIVO_PDF));
end;

procedure TffpgCalcCustaCompletaInicialProcTests.TestarCustaInicialProcesso;
begin
  ExecutarRoteiroTestes(CustaInicialProcesso);
end;

end.

