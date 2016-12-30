unit ufpgVisualizaFluxoTrabalhoTests;

interface

uses
  ufpgGUITestCase, ufpgVisualizaFluxoTrabalhoPG, ufpgVisualizaFluxoTrabalhoModelTests,
  ufpgDataModelTests, dcinfotree, uspLabel, ufpgControleFiltroItemLista,
  FutureWindows, ufpgVisualizaFluxoTrabalhoBasico, uspClientDataSet, DB,
  uspDataSource, Classes, DBClient;

type
  TffpgVisualizaFluxoTrabalhoBasicoCrack = class(TffpgVisualizaFluxoTrabalhoBasico);


type
  TffpgVisualizaFluxoTrabalhoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgVisualizaFluxoTrabalhoPG;
    FoDados: TffpgVisualizaFluxoTrabalhoModelTests;
    procedure FluxoTrabalho;
    procedure ConsultarProcessoFluxo;
    procedure VerificarFilaProcesso;
    procedure EditarObservacaoFluxoTrabalho(psNuProcesso1: string; psNuProcesso2: string = '';
      psNuProcesso3: string = '');
    procedure ExecutarAtividadeFilaMenu(psAtividade: string);
    procedure InserirObservacaoCadMemo;
    procedure SelecionarProcessoNoGrid(psNuProcesso, psnmNoPai, psnmFila, psCampo: string;
      pbTextoParcial: boolean = False);
    procedure VerificaObservacao;
    procedure MoverFila;
    procedure SelecionarItemPopUpMenu(psCaptionMenu: string);
    procedure SelecionarNodo(psNodoPai, psNodoFilho: string; poArvore: TDcInfoTree;
      pbTextoParcial: boolean = False);
    procedure EncaminharProcesso;
    function PegarDescricaoNodo(psTexto: string): string;
    //    procedure CopiarOutraFila;
    function VerificarObservacaoOutraFila: boolean;
    procedure VerificarRecebimentoMandadoFila;
    function VerificarFila(psPai, psFila, psCampo, psValor: string;
      psSomenteNumeros: boolean = True): boolean;
    procedure DistribuirMandadoFluxo;
    procedure DistribuirMandadoOficial;
    procedure JustificarDirecionamento;
    procedure ImprimirMandado;
    procedure AcionarBotaoAtividade(psNomeBotaoAtividade: string);
    procedure GerarCertidao;
    // 27/10/2016 - cesar.almeida - 66988 - Verificar filtro de foro
    procedure VerificarFiltroForo;
    // 27/10/2016 - cesar.almeida - 67004 - Verificar a impressão pela visualização
    procedure TestarImpressaoVisualizacao;
    procedure PegarTelaImpressao(const poWindow: IWindow);
    //    procedure VerificarOrdemTarja;
    //    function VerficarOrdemTarjaFluxo: boolean;
    function LocalizarProcessoNoGrid: boolean;
    procedure EmitirAtoOrdinatorioFilaInicial;
    //Luciano.fagundes - 03/10/2011 - Emitir Ato Ordinatório com Vista ao MP
    procedure EmitirAtoOrdinatorioVistaMP;
    procedure EmissaoDocumentoBloco;
    procedure EmitirAtoOrdinatorioFilaEnviada;

    // 09/11/2016 - cesar.almeida - 67198 - Verificar duplicidade parte config atos
    procedure SelecionarProcesso;
    procedure DependenciaProcesso;
    procedure PesquisarProcesso;
    procedure VisualizarAtos;
    procedure ConfirmarAto;
    procedure AguardarPesquisa;

    procedure EmitirAtoOrdinatorioChecarProcesso;
    procedure VisualizarFila;
    function RetornarForosGridUsuario: string;
    function RetornarQtdeForosUsuario: integer;
    function RetornarQtdeProcessosFilaUsuario: integer;
    procedure VerificarQtdeProcessosFilaUsuario;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure SetUp; override;
  published
    procedure TestarFluxoTrabalho;
  end;

implementation

{ TffpgVisualizaFluxoTrabalhoTests }

uses
  uspInterface, ufpgFuncoesGUITestes, Windows, ADODB, Forms, SysUtils, Controls,
  TestFramework, uspForm, usajConstante, uwflCadMemo, uwflEncaminhaProcesso,
  ufpgVariaveisTestesGUI, usmdDistribuicaoUnitaria, dcntree, usmdConsZonaVinculadas,
  usmdCadMemo, dxBar, ufpgRemessaAgenteCentralCompleta, uedtFormImprimir,
  ufpgEmissaoDocumentoBloco, ufpgVisualizaDependentes, ufpgConfigAtosDocumento, ufpgConfigAtos;


var
  bPesquisa: boolean;
  FsCombo: string;

const
  CS_FORO = 'Foro';
  CN_TIPO_CITACAO = 4;

procedure TffpgVisualizaFluxoTrabalhoTests.FluxoTrabalho;
begin
  FoDados := TffpgVisualizaFluxoTrabalhoModelTests(spDataModelTests);
  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('ffpgVisualizaFluxoTrabalhoPG');
  FoTela := TffpgVisualizaFluxoTrabalhoPG(spTela);

  // 27/10/2016 - cesar.almeida - 67004 - Verificar a impressão pela visualização
  if FoDados.fpgTestarImpressaoVisualizacao then
  begin
    TestarImpressaoVisualizacao;
    FecharTela;
    exit;
  end;

  if FoDados.fpgVerificaForosUsuario then
  begin
    VisualizarFila;
    VerificarQtdeProcessosFilaUsuario;
    FecharTela;
    exit;
  end;

  // 27/10/2016 - cesar.almeida - 66988 - Verificar filtro de foro
  if FoDados.fpgVerificarFiltroForo then
  begin
    VerificarFiltroForo;
    FecharTela;
    exit;
  end;

  FsCombo := FoDados.fpgFluxoTrabalho;
  //  if IsStrANumber(FoDados.fpgFluxoTrabalho) then
  //    FsCombo := FoDados.RetornaDescricaoFluxo(FsCombo);
  if FoDados.fpgVariosProcessos then
  begin
    FoDados.fpgNuProcesso := UsarProcessoArray;
    FoDados.fpgNuProcesso2 := UsarProcessoArray;
    FoDados.fpgNuProcesso3 := UsarProcessoArray;
  end
  else
    FoDados.fpgNuProcesso := UsarProcessoArray;


  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de processo não encontrado.');

  if FoDados.fpgPesquisarProcesso then
    PesquisarProcesso;

  if FoDados.fpgVerDependenciasObjeto then
    DependenciaProcesso;

  if FoDados.fpgSelecionarProcessoGrid then
    SelecionarProcessoNoGrid(FoDados.fpgNuProcesso, FoDados.fpgnmNoPai,
      FoDados.fpgnmFila2, FoDados.fpgCampo, True);

  if FoDados.fpgConsultarProcesso then
    ConsultarProcessoFluxo;

  if FoDados.fpgExecutarAtividadeFilaMenu then
    ExecutarAtividadeFilaMenu(FoDados.fpgBotaoAtividade);

  if FoDados.fpgAcionarBotaoAtividade then
    AcionarBotaoAtividade(FoDados.fpgBotaoAtividade);

  if FoDados.fpgEditarObservacao then
    EditarObservacaoFluxoTrabalho(FoDados.fpgNuProcesso, FoDados.fpgNuProcesso2,
      FoDados.fpgNuProcesso3);

  if FoDados.fpgDistribuirMandado then
  begin
    if FoDados.fpgNuMandado = STRING_INDEFINIDO then
      FoDados.fpgNuMandado := gsNuMandado;

    Check(FoDados.fpgNuMandado <> STRING_INDEFINIDO, 'Número de mandado não foi encontrado.');
    DistribuirMandadoFluxo;
  end;

  // 07/11/2016  - Carlos.Gaspar - TASK: 67184
  if FoDados.fpgEmitirAtoOrdinatorio then
  begin
    if FoDados.fpgPrimeiroTeste then
      EmitirAtoOrdinatorioFilaInicial;

    if FoDados.fpgSegundoTeste then
      EmitirAtoOrdinatorioFilaEnviada;

    if FoDados.fpgTerceiroTeste then
      EmitirAtoOrdinatorioChecarProcesso;

    FecharTela;
    exit;
  end;

  //Luciano.fagundes - 03/10/2011 - Emitir Ato Ordinatório com Vista ao MP
  if FoDados.fpgEmitirAtoOrdinatorioVistaMP then
    EmitirAtoOrdinatorioVistaMP;

  if FoDados.fpgVerificarProcesso then
    VerificarFilaProcesso;

  if FoDados.fpgVerificarRecebimentoMandadoFila then
    VerificarRecebimentoMandadoFila;

  if FoDados.fpgImprimirMandado then
    ImprimirMandado;

  if FoDados.fpgFecharTela then
    FecharTela;

  if FoDados.fpgGerarCertidao then
    GerarCertidao;
end;

function TffpgVisualizaFluxoTrabalhoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgVisualizaFluxoTrabalhoModelTests;
end;

procedure TffpgVisualizaFluxoTrabalhoTests.TestarFluxoTrabalho;
begin
  ExecutarRoteiroTestes(FluxoTrabalho);
end;

procedure TffpgVisualizaFluxoTrabalhoTests.ConsultarProcessoFluxo;
begin
  bPesquisa := True;
  FoTela.tsFilasDeTrabalho.ActivePage := FoTela.tsFluxoDeTrabalho;
  FoTela.tsFilasDeTrabalhoChange(FoTela);
  Application.ProcessMessages;
  sleep(2000);

  EnterTextInto(FoTela.cbFluxoTrabalho, FoDados.fpgfluxotrabalho);
  FoTela.cbFluxoTrabalhoChange(FoTela);
  FoTela.tsFilasDeTrabalho.ActivePage := FoTela.tsPesquisar;
  FoTela.tsFilasDeTrabalhoChange(FoTela);
  if FoTela.tbxNovaPesquisa.Enabled then
    FoTela.tbxNovaPesquisa.Click;
  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  FoTela.tbxiConsultar.Click;
  Application.ProcessMessages;
  sleep(2000);
end;

procedure TffpgVisualizaFluxoTrabalhoTests.VerificarFilaProcesso;
var
  i: integer;
  bEncontrou: boolean;
  sTexto: string;
  oNodo: TDCTreeNode;
begin
  bEncontrou := False;
  EnterTextInto(FoTela.cbFluxoTrabalho, FsCombo);
  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);
  sleep(2000);
  Application.ProcessMessages;

  if bPesquisa then
  begin
    for i := 0 to FoTela.tvResultadoFluxo.Items.Count - 1 do
    begin
      oNodo := FoTela.tvResultadoFluxo.Items[i];
      sTexto := Trim(oNodo.Text);
      if pos(FoDados.fpgFilaProcesso, Trim(Copy(sTexto, 0, Pos(' (', sTexto)))) > 0 then
      begin
        bEncontrou := LocalizarProcessoNoGrid;
        break;
      end;
    end;
  end
  else
  begin
    for i := 0 to FoTela.tvFluxoTrabalho.Items.Count - 1 do
    begin
      oNodo := FoTela.tvFluxoTrabalho.Items[i];
      sTexto := Trim(oNodo.Text);
      if pos(FoDados.fpgFilaProcesso, sTexto) > 0 then
      begin
        SelecionarNodo(FoDados.fpgnmNoPai, sTexto, FoTela.tvFluxoTrabalho, False);
        sleep(5000);
        application.ProcessMessages;
        bEncontrou := LocalizarProcessoNoGrid;
        break;
      end;
    end;
  end;

  if FoDados.fpgEmitirAtoOrdinatorioVistaMP then
  begin
    CheckFalse(bEncontrou, 'Processo não foi excluido.');
    CheckFalse(FoDados.RetornarNomeFilaObjeto(gsCdObjeto) = FoDados.fpgFilaProcesso,
      ' BD: Processo não foi excluido.');
  end
  else
  begin
    Check(bEncontrou, 'Processo não se encontra na fila correta.');
    Check(FoDados.RetornarNomeFilaObjeto(gsCdObjeto) = FoDados.fpgFilaProcesso,
      ' BD: Processo não se encontra na fila correta.');
  end;

end;

procedure TffpgVisualizaFluxoTrabalhoTests.EditarObservacaoFluxoTrabalho(psNuProcesso1: string;
  psNuProcesso2: string = ''; psNuProcesso3: string = '');
begin
  FoTela.tsFilasDeTrabalho.ActivePage := FoTela.tsFluxoDeTrabalho;
  FoTela.tsFilasDeTrabalhoChange(FoTela);
  //  AllowChange := False;
  FoTela.tsFilasDeTrabalhoChange(FoTela.tsFilasDeTrabalho);
  //  FoTela.tsFilasDeTrabalhoChanging(FoTela, AllowChange);

  sleep(2000);
  Application.ProcessMessages;

  EnterTextInto(FoTela.cbFluxoTrabalho, FoDados.fpgFluxoTrabalho, False);
  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);
  sleep(2000);
  Application.ProcessMessages;

  FoTela.tsFilasDeTrabalho.ActivePage := FoTela.tsPesquisar;
  FoTela.tsFilasDeTrabalhoChange(FoTela);


  if FoTela.tbxNovaPesquisa.Enabled then
    FoTela.tbxNovaPesquisa.Click;

  if (psNuProcesso2 <> STRING_INDEFINIDO) or (psNuProcesso3 <> STRING_INDEFINIDO) then
  begin
    FoTela.tsFilasDeTrabalho.ActivePage := FoTela.tsFluxoDeTrabalho;
    FoTela.tsFilasDeTrabalhoChange(FoTela);

    SelecionarProcessoNoGrid(psNuProcesso1, FoDados.fpgnmNoPai, FoDados.fpgnmFila,
      FoDados.fpgCampo, True);
    SelecionarProcessoNoGrid(psNuProcesso2, FoDados.fpgnmNoPai, FoDados.fpgnmFila,
      FoDados.fpgCampo, True);
    SelecionarProcessoNoGrid(psNuProcesso3, FoDados.fpgnmNoPai, FoDados.fpgnmFila,
      FoDados.fpgCampo, True);

    ExecutarAtividadeFilaMenu('Editar observação');
    InserirObservacaoCadMemo;
    MoverFila;

    SelecionarProcessoNoGrid(psNuProcesso1, FoDados.fpgnmNoPai, FoDados.fpgnmFila2,
      FoDados.fpgCampo, True);
    SelecionarProcessoNoGrid(psNuProcesso2, FoDados.fpgnmNoPai, FoDados.fpgnmFila2,
      FoDados.fpgCampo, True);
    SelecionarProcessoNoGrid(psNuProcesso3, FoDados.fpgnmNoPai, FoDados.fpgnmFila2,
      FoDados.fpgCampo, True);

    check(VerificarObservacaoOutraFila, 'As Observações na outra fila não foran encontradas');
    check(FoDados.VerificaObservacaoProcessoFluxo(psNuProcesso1, FoDados.fpgObservacao,
      FoDados.fpgObservacao2), 'As observações não foram inseridas');
    check(FoDados.VerificaObservacaoProcessoFluxo(psNuProcesso2, FoDados.fpgObservacao,
      FoDados.fpgObservacao2), 'As observações não foram inseridas');
    check(FoDados.VerificaObservacaoProcessoFluxo(psNuProcesso3, FoDados.fpgObservacao,
      FoDados.fpgObservacao2), 'As observações não foram inseridas');
  end
  else
  begin
    EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, psNuProcesso1);
    FoTela.tbxiConsultar.Click;
    sleep(2000);
    Application.ProcessMessages;
    ExecutarAtividadeFilaMenu('Editar observação');
    InserirObservacaoCadMemo;
    VerificaObservacao;
  end;
end;

procedure TffpgVisualizaFluxoTrabalhoTests.ExecutarAtividadeFilaMenu(psAtividade: string);
begin
  Application.ProcessMessages;
  PosicionarPonteiroMouse(FoTela.grDados);
  Check((FoTela.grDados.DataSource.DataSet.Active) and
    (FoTela.grDados.DataSource.DataSet.RecordCount > 0), 'Processo nao selecionado!');
  if (FoTela.grDados.DataSource.DataSet.FieldByName('FLSELECIONADO').AsString <> 'S') then
  begin
    FoTela.grDados.DataSource.DataSet.Edit;
    FoTela.grDados.DataSource.DataSet.FieldByName('FLSELECIONADO').AsString := 'S';
  end;
  CliqueDireitoMouse;
  SelecionarItemPopUpMenu(psAtividade);
  Application.ProcessMessages;
  Sleep(3000);
end;

procedure TffpgVisualizaFluxoTrabalhoTests.InserirObservacaoCadMemo;
var
  poTelaCadMemo: TfwflCadMemo;
begin
  poTelaCadMemo := TfwflCadMemo(PegarTela('fwflCadMemo'));
  Application.ProcessMessages;
  PosicionarPonteiroMouse(poTelaCadMemo.dbmJustificativa);
  CliqueEsquerdoMouse;
  poTelaCadMemo.dbmJustificativaChange(poTelaCadMemo.dbmJustificativa);
  EnterTextInto(poTelaCadMemo.dbmJustificativa, FoDados.fpgObservacao2);
  potelaCadMemo.ccCadastro.Execute(acSalvar);
  poTelaCadMemo.ccCadastro.Execute(acFecharForm);
end;

procedure TffpgVisualizaFluxoTrabalhoTests.VerificaObservacao;
begin
  check(FoDados.VerificaObservacaoProcessoFluxo(FoDados.fpgNuProcesso,
    FoDados.fpgObservacao, FoDados.fpgObservacao2), 'As observações não foram inseridas');
end;

procedure TffpgVisualizaFluxoTrabalhoTests.SelecionarProcessoNoGrid(
  psNuProcesso, psnmNoPai, psnmFila: string; psCampo: string; pbTextoParcial: boolean = False);
var
  sNumeroProcesso_Auxiliar: string;
  bAchou: boolean;
begin
  bAchou := False;
  SelecionarNodo(psnmNoPai, psnmFila, FoTela.tvFluxoTrabalho, pbTextoParcial);
  sleep(5000);
  application.ProcessMessages;
  FoTela.grdados.DataSource.DataSet.First;
  while not FoTela.grdados.DataSource.DataSet.EOF do
  begin
    sNumeroProcesso_Auxiliar := SomenteNumeros(FoTela.grDados.DataSource.DataSet.FieldByName(
      psCampo).AsString);
    if (psNuProcesso = sNumeroProcesso_Auxiliar) then
    begin
      FoTela.grDados.DataSource.DataSet.Edit;
      FoTela.grDados.DataSource.DataSet.FieldByName('flSelecionado').AsString := 'S';
      FoTela.grDados.DataSource.DataSet.Post;
      bAchou := True;
      Break;
    end;
    FoTela.grDados.DataSource.DataSet.Next;
  end;
  Check(bAchou, 'Processo não localizado!');
end;

procedure TffpgVisualizaFluxoTrabalhoTests.SelecionarProcesso;
var
  sNumeroProcesso_Auxiliar: string;
  bAchou: boolean;
begin
  bAchou := False;

  FoTela.grdados.DataSource.DataSet.First;
  while not FoTela.grdados.DataSource.DataSet.EOF do
  begin
    sNumeroProcesso_Auxiliar := SomenteNumeros(FoTela.grDados.DataSource.DataSet.FieldByName(
      'NUPROCESSO').AsString);
    if (FoDados.fpgNuProcesso = sNumeroProcesso_Auxiliar) then
    begin
      FoTela.grDados.DataSource.DataSet.Edit;
      FoTela.grDados.DataSource.DataSet.FieldByName('flSelecionado').AsString := 'S';
      FoTela.grDados.DataSource.DataSet.Post;
      bAchou := True;
      Break;
    end;
    FoTela.grDados.DataSource.DataSet.Next;
  end;
  Check(bAchou, 'Processo não localizado!');
end;

procedure TffpgVisualizaFluxoTrabalhoTests.MoverFila;
begin
  Application.ProcessMessages;
  //  ExecutarAtividadeFilaMenu('Mover para outra &fila');
  ExecutarAtividadeFilaMenu(FoDados.fpgBotaoAtividade);
  EncaminharProcesso;
  Application.ProcessMessages;
end;

procedure TffpgVisualizaFluxoTrabalhoTests.SelecionarItemPopUpMenu(psCaptionMenu: string);
var
  nItem: integer;
begin
  nItem := 0;
  while nItem >= 0 do
  begin
    if (CompareText(FoTela.PopupMenu.ItemLinks.Items[nItem].Caption, psCaptionMenu) = 0) then
    begin
      FoTela.PopupMenu.ItemLinks.Items[nItem].Item.Click;
      break;
    end;
    nItem := nItem + 1;
    if nItem >= FoTela.PopupMenu.ItemLinks.Count then
    begin
      Break;
      Check(False, 'SelecionarItemPopUpMenu - Falhou!');
    end;
  end;

  //  CliqueSetaBaixo(nItem);
  //  CliqueEnter;
end;

procedure TffpgVisualizaFluxoTrabalhoTests.SelecionarNodo(psNodoPai, psNodoFilho: string;
  poArvore: TDcInfoTree; pbTextoParcial: boolean = False);
var
  nIdx: integer;
  oNodo, oNodoFilho, oNodoUltimoFilho: TDCTreeNode;
  sTextoNodo: string;
  bEncontrou, bPodeContinuar: boolean;
begin
  bEncontrou := False;
  for nIdx := 0 to poArvore.Items.Count - 1 do
  begin
    oNodo := poArvore.Items[nIdx];
    sTextoNodo := Trim(PegarDescricaoNodo(oNodo.Text));
    if sTextoNodo = Trim(psNodoPai) then
    begin
      oNodo.Expand(True);
      oNodoUltimoFilho := oNodo.GetLastChild;
      oNodoFilho := oNodo.GetFirstChild;
      bPodeContinuar := True;
      while Assigned(oNodoFilho) and Assigned(oNodoUltimoFilho) and (not bEncontrou) and
        bPodeContinuar do
      begin
        Application.ProcessMessages;
        if pbTextoParcial then
          bEncontrou := pos(psNodoFilho, oNodoFilho.Text) > 0
        else
        begin
          bEncontrou := (oNodoFilho.Text = psNodoFilho) or
            (pos(psNodoFilho + ' (', oNodoFilho.Text) > 0);
        end;
        bPodeContinuar := oNodoUltimoFilho.Text <> oNodoFilho.Text;
        if not bEncontrou then
          oNodoFilho := oNodoFilho.GetNextSibling;
      end;
      if Assigned(oNodoFilho) and bEncontrou then
      begin
        poArvore.Selected := oNodoFilho;
        FoTela.tvFluxoTrabalhoChange(FoTela.tvFluxoTrabalho, oNodoFilho);
        Break;
      end;
    end;
  end;
  if not bEncontrou then
    poArvore.Items.GetFirstNode;

  Check(bEncontrou, 'Não encontrou a fila: ' + psNodoFilho + ' em ' + psNodoPai + '!');
end;

procedure TffpgVisualizaFluxoTrabalhoTests.EncaminharProcesso;
var
  oTelaCopia: TfwflEncaminhaProcesso;
begin
  TFutureWindows.Expect('TfwflDemoEvento').ExecProc(FecharJanelaModal);
  oTelaCopia := PegarTela('fwflEncaminhaProcesso') as TfwflEncaminhaProcesso;
  // 07/11/2016  - Carlos.Gaspar - TASK: 67184
  EnterTextCheckBox(oTelaCopia.cbxMostrarTodos, True);
  //--
  Application.ProcessMessages;
  oTelaCopia.grFila.DataSource.DataSet.Locate('CDFILA', FoDados.fpgCopiarFila, []);
  oTelaCopia.grFila.DataSource.DataSet.Edit;
  oTelaCopia.grFila.DataSource.DataSet.FieldByName('flSelecionado').AsString :=
    FoDados.fpgSelecionado;

  if not FoDados.fpgVariosProcessos then
  begin
    EnterTextInto(oTelaCopia.dfdePendencia, FoDados.fpgDescricao);
    EnterTextInto(oTelaCopia.dfdtInicio, DateToStr(Now));
    EnterTextInto(oTelaCopia.dfnuPrazo, FoDados.fpgDias);
  end;
  Application.ProcessMessages;
  oTelaCopia.ccCadastro.Execute(acSalvar);
end;

function TffpgVisualizaFluxoTrabalhoTests.PegarDescricaoNodo(psTexto: string): string;
var
  nCount: integer;
begin
  result := '';
  if (pos('(', psTexto) > 0) then
  begin
    nCount := 1;
    while (nCount <= Length(psTexto)) and (psTexto[nCount] <> '(') do
    begin
      if (Length(psTexto) > nCount) and (psTexto[nCount + 1] = '(') then
      begin
        if (Length(psTexto) > nCount + 1) and (not (psTexto[nCount + 2] in ['1'..'9'])) then
        begin
          result := result + psTexto[nCount];
          Inc(nCount);
        end;
      end;
      result := result + psTexto[nCount];
      Inc(nCount);
    end;
  end
  else
    result := psTexto;
  result := Trim(result);
end;


procedure TffpgVisualizaFluxoTrabalhoTests.SetUp;
begin
  spNomeTela := 'ffpgVisualizaFluxoTrabalhoPG';
  spNomeMenuItem := 'imffpgVisualizaFluxoTrabalho';
  inherited;
end;

//procedure TffpgVisualizaFluxoTrabalhoTests.CopiarOutraFila;
//begin
//  ExecutarAtividadeFilaMenu('&Copiar para outra fila');
//end;

function TffpgVisualizaFluxoTrabalhoTests.VerificarObservacaoOutraFila: boolean;
var
  poTelaCadMemo: TfwflCadMemo;
begin
  result := False;
  ExecutarAtividadeFilaMenu(FoDados.fpgBotaoAtividade);
  poTelaCadMemo := TfwflCadMemo(PegarTela('fwflCadMemo'));
  Application.ProcessMessages;
  PosicionarPonteiroMouse(poTelaCadMemo.dbmJustificativa);
  CliqueEsquerdoMouse;
  if (Pos(FoDados.fpgObservacao2, poTelaCadMemo.dbmJustificativa.Text) >= 0) then
    result := True;
  potelaCadMemo.ccCadastro.Execute(acSalvar);
  potelaCadMemo.ccCadastro.Execute(acFecharForm);
end;

procedure TffpgVisualizaFluxoTrabalhoTests.VerificarRecebimentoMandadoFila;
begin
  EnterTextInto(FoTela.cbFluxoTrabalho, FsCombo);
  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);
  SelecionarProcessoNoGrid(FoDados.fpgNuMandado, FoDados.fpgnmNoPai, FoDados.fpgnmFila,
    FoDados.fpgCampo);
  check(VerificarFila(FoDados.fpgnmNoPai, FoDados.fpgnmFila, FoDados.fpgCampo,
    FoDados.fpgNuMandado), 'O mandado não está na fila ' + FoDados.fpgnmFila);
  check(FoDados.VerificarSituacaoMandado(FoDados.fpgSituacaoMandado, FoDados.fpgNuMandado),
    'Falhou Situação Mandado!');
end;

function TffpgVisualizaFluxoTrabalhoTests.VerificarFila(psPai: string;
  psFila: string; psCampo: string; psValor: string; psSomenteNumeros: boolean = True): boolean;
var
  sValorCampo: string;
  bEncontrou: boolean;
begin
  SelecionarNodo(psPai, psFila, FoTela.tvFluxoTrabalho, True);
  Application.ProcessMessages;
  sleep(1000);
  bEncontrou := False;
  FoTela.grdados.DataSource.Dataset.First;
  while not FoTela.grdados.DataSource.Dataset.EOF do
  begin
    Application.ProcessMessages;
    if psSomenteNumeros then
      sValorCampo := SomenteNumeros(FoTela.grDados.DataSource.Dataset.FieldByName(
        psCampo).AsString)
    else
      sValorCampo := FoTela.grDados.DataSource.Dataset.FieldByName(psCampo).AsString;
    if (psValor = sValorCampo) then
    begin
      bEncontrou := True;
      Break;
    end;
    FoTela.grDados.DataSource.Dataset.Next;
  end;
  result := bEncontrou;
end;

procedure TffpgVisualizaFluxoTrabalhoTests.DistribuirMandadoFluxo;
begin
  EnterTextInto(FoTela.cbFluxoTrabalho, FsCombo);
  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);
  SelecionarProcessoNoGrid(FoDados.fpgNuMandado, FoDados.fpgnmNoPai, FoDados.fpgnmFila,
    FoDados.fpgCampo);
  spVerificadorTelas.RegistrarMensagem('Deseja incluir este Documento na seleção também ?', 'Não');
  ExecutarAtividadeFilaMenu(FoDados.fpgBotaoAtividade);
  DistribuirMandadoOficial;
  checkTrue(VerificarFila(FoDados.fpgnmNoPai, FoDados.fpgnmFila2, FoDados.fpgCampo,
    FoDados.fpgNuMandado), 'O mandado não está na fila ' + FoDados.fpgnmFila2);
  FoDados.PegarDadosMandado(FoDados.fpgNuMandado, True);
  check((FoDados.fpgCodDistribuicao = gscdTipoDistMand) and
    (FoDados.fpgOficialJustica = gsCdAgente),
    'Falha Verificação Distribuição Mandado!');
  if (FoDados.fpgCodZona <> STRING_INDEFINIDO) then
    check(FoDados.fpgCodZona = gsZona, 'Falha - Ao validar Zona da Distribuição!');
end;

procedure TffpgVisualizaFluxoTrabalhoTests.DistribuirMandadoOficial;
var
  oTelaDistribuicao: TfsmdDistribuicaoUnitaria;
  oTelaZonas: TfsmdConsZonaVinculadas;
begin
  oTelaDistribuicao := PegarTela('fsmdDistribuicaoUnitaria') as TfsmdDistribuicaoUnitaria;
  EnterTextInto(oTelaDistribuicao.smdNumeroMandado.sajNumeroProcesso.FdfNumeroProcessoExterno,
    FoDados.fpgNuProcesso, False);
  EnterTextInto(oTelaDistribuicao.smdTipoDistMandConsDados.dfCodigo, FoDados.fpgCodDistribuicao);
  EnterTextInto(oTelaDistribuicao.fsmdZonaConsDados.dfCodigo, FoDados.fpgCodZona);
  if TelaExiste('fsmdConsZonaVinculadas') then
  begin
    oTelaZonas := TfsmdConsZonaVinculadas(PegarTela('fsmdConsZonaVinculadas'));
    Check(oTelaZonas.esmdZona.Locate('CDZONA', FoDados.fpgCodZona, []),
      'Falha - Ao selecionar Zona!');
    oTelaZonas.bcBotoesCadastro.spControleCadastro.Execute(acSelecionar);
  end;
  EnterTextInto(oTelaDistribuicao.csAgenteDados.dfcdAgente, FoDados.fpgOficialJustica);
  oTelaDistribuicao.btnDistribuir.Click;
  JustificarDirecionamento;
  oTelaDistribuicao.Fecha;
end;

procedure TffpgVisualizaFluxoTrabalhoTests.JustificarDirecionamento;
var
  oTelaJustificativa: TfsmdCadMemo;
begin
  oTelaJustificativa := PegarTela('fsmdCadMemo') as TfsmdCadMemo;
  oTelaJustificativa.dbmJustificativa.Lines.Add(FoDados.fpgJustificativaDistribuicao);
  oTelaJustificativa.ccCadastro.Execute(acSalvar);
end;


procedure TffpgVisualizaFluxoTrabalhoTests.ImprimirMandado;
begin
  EnterTextInto(FoTela.cbFluxoTrabalho, FsCombo);
  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);
  SelecionarProcessoNoGrid(FoDados.fpgNuMandado, FoDados.fpgnmNoPai, FoDados.fpgnmFila,
    FoDados.fpgCampo);
  Check(FoDados.VerificarUltimaMovimentacaoFluxo(FoDados.fpgNuMandado, FoDados.fpgnmFila),
    'Falha - Ultima movimentação não é a esperada');
  AcionarBotaoAtividade(FoDados.fpgBotaoAtividade);
  checkTrue(VerificarFila(FoDados.fpgnmNoPai, FoDados.fpgnmFila2, FoDados.fpgCampo,
    FoDados.fpgNuMandado), 'O mandado não está na fila ' + FoDados.fpgnmFila2);
  Check(FoDados.VerificarUltimaMovimentacaoFluxo(FoDados.fpgNuMandado, FoDados.fpgnmFila2),
    'Falha - Ultima movimentação não é a esperada');
end;

procedure TffpgVisualizaFluxoTrabalhoTests.AcionarBotaoAtividade(psNomeBotaoAtividade: string);
var
  nIndice: integer;
  bAchou: boolean;
begin
  bAchou := False;
  psNomeBotaoAtividade := AnsiUpperCase(psNomeBotaoAtividade);
  for nIndice := 0 to FoTela.ComponentCount - 1 do
  begin
    if FoTela.Components[nIndice].InheritsFrom(TdxBarButton) then
    begin
      if Trim(AnsiUpperCase(TdxBarButton(FoTela.Components[nIndice]).Caption)) =
        psNomeBotaoAtividade then
      begin
        if (TdxBarButton(FoTela.Components[nIndice]).Visible = ivAlways) then
        begin
          bAchou := True;
          Application.ProcessMessages;
          Sleep(1000);
          TdxBarButton(FoTela.Components[nIndice]).Click;
          Break;
        end;
      end;
    end;
  end;
  Application.ProcessMessages;
  Sleep(2000);
  check(bAchou, 'Falha - Não achou botão atividade ' + psNomeBotaoAtividade);
end;

procedure TffpgVisualizaFluxoTrabalhoTests.GerarCertidao;
begin
  EnterTextInto(FoTela.cbFluxoTrabalho, FsCombo);
  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);
  SelecionarProcessoNoGrid(FoDados.fpgNuMandado, FoDados.fpgnmNoPai, FoDados.fpgnmFila,
    FoDados.fpgCampo);
  AcionarBotaoAtividade(FoDados.fpgBotaoAtividade);
end;

procedure TffpgVisualizaFluxoTrabalhoTests.VerificarFiltroForo;
var
  i: integer;
  bAchou: boolean;
begin
  EnterTextInto(FoTela.cbFluxoTrabalho, FoDados.fpgFluxoTrabalho);
  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);

  SelecionarNodo(FoDados.fpgnmNoPai, FoDados.fpgnmFila2, FoTela.tvFluxoTrabalho, True);

  FoTela.fpgControleFiltro.Abrir;
  Application.ProcessMessages;

  bAchou := False;
  for i := 0 to FoTela.fpgControleFiltro.Controles.Count - 1 do
  begin
    if FoTela.fpgControleFiltro.Controles.Items[i].Caption = CS_FORO then
    begin
      bAchou := True;
      break;
    end;
  end;
  check(bAchou, 'O filtro do Foro não esta habilitado');
end;

// 01/11/2016  - Carlos.Gaspar - TASK: 67011
//procedure TffpgVisualizaFluxoTrabalhoTests.VerificarOrdemTarja;
//begin
//  EnterTextInto(FoTela.cbFluxoTrabalho, FoDados.fpgFluxoTrabalho);
//  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);

//  SelecionarNodo(FoDados.fpgnmNoPai, FoDados.fpgnmFila2, FoTela.tvFluxoTrabalho, True);

//  FoTela.fpgControleFiltro.Abrir;
//  Application.ProcessMessages;

//  CheckTrue(VerficarOrdemTarjaFluxo, 'O Fluxo não está ordenado por prioridade de tarja.');
//end;

// 01/11/2016  - Carlos.Gaspar - TASK: 67011
//function TffpgVisualizaFluxoTrabalhoTests.VerficarOrdemTarjaFluxo: boolean;
//var
//  oCds: TClientDataSet;
//  nContador: integer;
//  nPrioridade: integer;
//begin
//  ocds := TClientDataSet.Create(nil); //PC_OK
//  try
//    result := False;
//    nContador := 0;
//    nPrioridade := 0;
//    ocds.CloneCursor(FoTela.ewflHistObjeto, False, True);
//    ocds.First;
//    while not oCds.EOF do
//    begin
//      if (oCds.FieldByName('tpPrioridade').AsInteger <= 7) and
//        (oCds.FieldByName('deListaTarjaObjeto').AsString <> '') and (oCds.recno <= 5) then
//      begin
//        if oCds.FieldByName('tpPrioridade').AsInteger > nprioridade then
//        begin
//          nprioridade := oCds.FieldByName('tpPrioridade').AsInteger;
//          nContador := nContador + 1;
//        end;
//      end
//      else
//        Break;
//      oCds.Next;
//    end;
//    if nContador >= 1 then
//      result := True;
//  finally
//    FreeAndNil(ocds);  //PC_OK
//  end;
//end;

procedure TffpgVisualizaFluxoTrabalhoTests.TestarImpressaoVisualizacao;
begin
  EnterTextInto(FoTela.cbFluxoTrabalho, FoDados.fpgFluxoTrabalho);
  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);

  SelecionarNodo(FoDados.fpgnmNoPai, FoDados.fpgnmFila2, FoTela.tvFluxoTrabalho, True);

  application.ProcessMessages;
  FoTela.grdados.DataSource.DataSet.First;
  SelecionarItemPopUpMenu('Visualizar documentos');
  application.ProcessMessages;

  TFutureWindows.Expect('TfedtFormImprimir').ExecProc(PegarTelaImpressao);
  TffpgVisualizaFluxoTrabalhoBasicoCrack(FoTela).frmVisualizaDoc.pbImprimir.Click;
end;

procedure TffpgVisualizaFluxoTrabalhoTests.PegarTelaImpressao(const poWindow: IWindow);
var
  oTelaImpressao: TfedtFormImprimir;
begin

  oTelaImpressao := (poWindow.asControl) as TfedtFormImprimir;
  oTelaImpressao.pbOk.Click;
end;

function TffpgVisualizaFluxoTrabalhoTests.LocalizarProcessoNoGrid: boolean;
var
  bAchou: boolean;
  sNumeroProcesso_Auxiliar: string;
begin
  bAchou := False;
  FoTela.grdados.DataSource.DataSet.First;
  while not FoTela.grdados.DataSource.DataSet.EOF do
  begin
    sNumeroProcesso_Auxiliar := SomenteNumeros(FoTela.grDados.DataSource.DataSet.FieldByName(
      FoDados.fpgCampo).AsString);
    if (FoDados.fpgNuProcesso = sNumeroProcesso_Auxiliar) then
    begin
      FoTela.grDados.DataSource.DataSet.Edit;
      FoTela.grDados.DataSource.DataSet.FieldByName('flSelecionado').AsString := 'S';
      FoTela.grDados.DataSource.DataSet.Post;
      bAchou := True;
      Break;
    end;
    FoTela.grDados.DataSource.DataSet.Next;
  end;

  if FoDados.fpgEmitirAtoOrdinatorioVistaMP then
    Checkfalse(bAchou, 'Processo não localizado!')
  else
    Check(bAchou, 'Processo não localizado!');

  result := bachou;
end;
// 07/11/2016  - Carlos.Gaspar - TASK: 67184
procedure TffpgVisualizaFluxoTrabalhoTests.EmitirAtoOrdinatorioFilaInicial;
begin
  EnterTextInto(FoTela.cbFluxoTrabalho, FsCombo);
  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);
  sleep(2000);
  Application.ProcessMessages;
  SelecionarProcessoNoGrid(FoDados.fpgNuProcesso, FoDados.fpgnmNoPai, FoDados.fpgnmFila,
    FoDados.fpgCampo);
  AcionarBotaoAtividade(FoDados.fpgBotaoAtividade);
  MoverFila;
  Application.ProcessMessages;
end;

// 08/11/2016  - Carlos.Gaspar - TASK: 67184
procedure TffpgVisualizaFluxoTrabalhoTests.EmitirAtoOrdinatorioFilaEnviada;
begin
  EnterTextInto(FoTela.cbFluxoTrabalho, FsCombo);
  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);
  sleep(2000);
  Application.ProcessMessages;
  SelecionarProcessoNoGrid(FoDados.fpgNuProcesso, FoDados.fpgnmNoPai, FoDados.fpgnmFila,
    FoDados.fpgCampo);
  AcionarBotaoAtividade(FoDados.fpgBotaoAtividade);
  Application.ProcessMessages;
  EmissaoDocumentoBloco;
end;

// 08/11/2016  - Carlos.Gaspar - TASK: 67184
procedure TffpgVisualizaFluxoTrabalhoTests.EmitirAtoOrdinatorioChecarProcesso;
begin
  EnterTextInto(FoTela.cbFluxoTrabalho, FsCombo);
  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);
  sleep(2000);
  Application.ProcessMessages;
  SelecionarProcessoNoGrid(FoDados.fpgNuProcesso, FoDados.fpgnmNoPai, FoDados.fpgnmFila,
    FoDados.fpgCampo);
  Application.ProcessMessages;
  VerificarFilaProcesso;
end;

//Luciano.fagundes - 03/10/2011 - Emitir Ato Ordinatório com Vista ao MP
procedure TffpgVisualizaFluxoTrabalhoTests.EmitirAtoOrdinatorioVistaMP;
begin
  EnterTextInto(FoTela.cbFluxoTrabalho, FsCombo);
  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);
  sleep(2000);
  Application.ProcessMessages;
  SelecionarProcessoNoGrid(FoDados.fpgNuProcesso, FoDados.fpgnmNoPai, FoDados.fpgnmFila,
    FoDados.fpgCampo);
  AcionarBotaoAtividade(FoDados.fpgBotaoAtividade);
  EmissaoDocumentoBloco;
end;

//Luciano.fagundes - 03/10/2011 - Emitir Ato Ordinatório com Vista ao MP
procedure TffpgVisualizaFluxoTrabalhoTests.EmissaoDocumentoBloco;
var
  oTelaEmissaoDocumentoBloco: TffpgEmissaoDocumentoBloco;
begin
  oTelaEmissaoDocumentoBloco := PegarTela('ffpgEmissaoDocumentoBloco') as
    TffpgEmissaoDocumentoBloco;
  spVerificadorTelas.RegistrarMensagem('Operação realizada com sucesso*', 'OK');
  EnterTextInto(oTelaEmissaoDocumentoBloco.cbCertificados, FoDados.fpgCertificado);
  oTelaEmissaoDocumentoBloco.dxbbBotoesSalvar.Click;
end;

procedure TffpgVisualizaFluxoTrabalhoTests.PesquisarProcesso;
begin
  FoTela.tsFilasDeTrabalho.ActivePage := FoTela.tsPesquisar;
  FoTela.tsFilasDeTrabalhoChange(FoTela);

  if FoTela.tbxNovaPesquisa.Enabled then
    FoTela.tbxNovaPesquisa.Click;

  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  sleep(2000);
  FoTela.tbxiConsultar.Click;
  AguardarPesquisa;

  SelecionarNodo(FoDados.fpgnmNoPai, FoDados.fpgnmFila, FoTela.tvResultadoFluxo, True);
  AguardarPesquisa;

end;

procedure TffpgVisualizaFluxoTrabalhoTests.VisualizarAtos;
var
  oTelaConfigAtosDocumento: TffpgConfigAtosDocumento;
begin
  oTelaConfigAtosDocumento := PegarTela('ffpgConfigAtosDocumento') as TffpgConfigAtosDocumento;

  oTelaConfigAtosDocumento.dxbbBotoesNovo.Click;
  ConfirmarAto;
  oTelaConfigAtosDocumento.dxbbBotoesSalvar.Click;
  spVerificadorTelas.RegistrarMensagem(
    'Deseja confirmar a configuração do(s) atos(s) selecionados(s)?', 'SIM');
  oTelaConfigAtosDocumento.bbGerarAtos.Click;
end;

procedure TffpgVisualizaFluxoTrabalhoTests.ConfirmarAto;
var
  oTelaConfigAtos: TffpgConfigAtos;
  sNomeAnterior: string;
  i: integer;
begin
  oTelaConfigAtos := PegarTela('ffpgConfigAtos') as TffpgConfigAtos;

  for i := 0 to oTelaConfigAtos.tvPessoas.Items.Count - 1 do
  begin
    if sNomeAnterior = oTelaConfigAtos.tvPessoas.Items.Item[i].Text then
    begin
      check(False, 'Nome duplicado na gride');
      break;
    end;
    sNomeAnterior := oTelaConfigAtos.tvPessoas.Items.Item[i].Text;
  end;

  for i := 0 to oTelaConfigAtos.tvPessoas.Items.Count - 1 do
  begin
    if pos('Requerido', oTelaConfigAtos.tvPessoas.Items.Item[i].Text) <> 0 then
    begin
      oTelaConfigAtos.tvPessoas.Items.Item[i].Selected := True;
      Break;
    end;
  end;

  oTelaConfigAtos.cdsTela.Edit;
  oTelaConfigAtos.cdsTela.FieldByName('CDATO').AsInteger := CN_TIPO_CITACAO;
  oTelaConfigAtos.cdsTela.Post;

  oTelaConfigAtos.cbTipoAto.KeyValue := StrToInt(FoDados.fpgTipoAto);
  oTelaConfigAtos.cbTipoAtoChange(oTelaConfigAtos.cbTipoAto);
  EnTerTextInto(oTelaConfigAtos.wflFormaAtoCons.dfcdFormaAto, FoDados.fpgFormaAto);
  EnTerTextInto(oTelaConfigAtos.sajConvenioConsFormaAto.dfcdConvenio, FoDados.fpgConvenio);
  EnTerTextInto(oTelaConfigAtos.dfnuDiasPrazo, FoDados.fpgDiasPrazo);
  EnTerTextInto(oTelaConfigAtos.edtModeloCons.dfCodigo, FoDados.fpgCategoriaModelo);

  spVerificadorTelas.RegistrarMensagem(
    'Existem 1 pessoa(s) com ato(s) configurado(s). Deseja salvar?', 'SIM');
  spVerificadorTelas.RegistrarMensagem(
    'Deseja confirmar a configuração do(s) atos(s) selecionados(s)?', 'SIM');
  oTelaConfigAtos.ccPrincipal.Execute(acSalvar);

end;

procedure TffpgVisualizaFluxoTrabalhoTests.VisualizarFila;
begin
  EnterTextInto(FoTela.cbFluxoTrabalho, FoDados.fpgFluxoTrabalho);
  FoTela.cbFluxoTrabalhoChange(FoTela.cbFluxoTrabalho);
  sleep(2000);
  Application.ProcessMessages;
  SelecionarNodo(FoDados.fpgnmNoPai, FoDados.fpgnmFila2, FoTela.tvFluxoTrabalho, True);
end;

function TffpgVisualizaFluxoTrabalhoTests.RetornarForosGridUsuario: string;
var
  sForos: TStringList;
  sStringForos: string;
  I, Index: integer;
begin
  try
    sForos := TStringList.Create;
    FoTela.grdados.DataSource.Dataset.First;
    while not FoTela.grdados.DataSource.Dataset.EOF do
    begin
      if not sForos.Find(FoTela.grdados.DataSource.Dataset.FieldByName('CDFORO').AsString,
        Index) then
      begin
        sForos.Add(FoTela.grdados.DataSource.Dataset.FieldByName('CDFORO').AsString);
      end;
      sForos.Sort;
      FoTela.grDados.DataSource.Dataset.Next;
    end;
    check(RetornarQtdeForosUsuario = sForos.Count, 'Quantidade de foros na grid está errada.');

    sStringForos := '';
    for I := 0 to sForos.Count - 1 do
    begin
      sStringForos := sStringForos + QuotedStr(sForos.Strings[I]);
      if (I < sForos.Count - 1) then
        sStringForos := sStringForos + ', ';
    end;
    result := sStringForos;
  finally
    FreeAndNil(sForos);
  end;
end;

function TffpgVisualizaFluxoTrabalhoTests.RetornarQtdeForosUsuario: integer;
begin
  result := FoDados.RetornarQtdeForosUsuario(spUsuario);
end;

function TffpgVisualizaFluxoTrabalhoTests.RetornarQtdeProcessosFilaUsuario: integer;
begin
  result := FoDados.RetornarQtdeProcessosFilaUsuario(RetornarForosGridUsuario,
    FoTela.ewflUsuarioFluxo.FieldByName('CDFLUXOTRABALHO').AsString,
    FoTela.ewflUsuarioFluxo.FieldByName('CDFILA').AsString);
end;

procedure TffpgVisualizaFluxoTrabalhoTests.VerificarQtdeProcessosFilaUsuario;
begin
  check(RetornarQtdeProcessosFilaUsuario = FoTela.ewflUsuarioFluxo.FieldByName(
    'QTOBJETOS').AsInteger, 'Quantidade de processos na grid está errada.');
end;

procedure TffpgVisualizaFluxoTrabalhoTests.AguardarPesquisa;
begin
  while FoTela.TimerRefreshPesquisa.Enabled do
    application.ProcessMessages;
end;

// 09/11/2016 - cesar.almeida - 67198 - Verificar duplicidade parte config atos
procedure TffpgVisualizaFluxoTrabalhoTests.DependenciaProcesso;
var
  oTelaDependente: TffpgVisualizaDependentes;
begin
  SelecionarProcesso;
  SelecionarItemPopUpMenu('Mostrar dependência do objeto');
  application.ProcessMessages;

  oTelaDependente := PegarTela('ffpgVisualizaDependentes') as TffpgVisualizaDependentes;

  oTelaDependente.dxtlDependentes.DataSource.DataSet.First;
  while not oTelaDependente.dxtlDependentes.DataSource.DataSet.EOF do
  begin
    sleep(200);
    if oTelaDependente.pbVisualizarAtos.Enabled then
    begin
      oTelaDependente.pbVisualizarAtos.Click;
      application.ProcessMessages;
      VisualizarAtos;
      break;
    end;
    oTelaDependente.dxtlDependentes.DataSource.DataSet.Next;
  end;
end;

end.

