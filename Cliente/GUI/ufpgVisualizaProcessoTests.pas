unit ufpgVisualizaProcessoTests;

interface

uses
  ufpgVisualizaProcesso, ufpgGUITestCase, ufpgVisualizaProcessoModelTests,
  TestFrameWork, Windows, Forms, FutureWindows, SysUtils, usajConstante,
  ufpgConsProcBasica, uspForm, ufpgDataModelTests, uspDataModelTests,
  uspVerificadorTelas, ufpgCadProcesso, ufpgDigPecaProcessual, Consts, Messages,
  Classes, Graphics, ExtCtrls, Controls, StdCtrls, Menus, Dialogs, uspFuncoes,
  DB, ComCtrls, VirtualTrees, usaj5TreeView, ufpgSelecaoCeritificadoDigital;

type
  TffpgVisualizaProcessoCrack = class(TffpgVisualizaProcesso);

type
  TffpgVisualizaProcessoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgVisualizaProcesso;
    FoDados: TffpgVisualizaProcessoModelTests;
    procedure PreencherDadosTelaVisualizacao;
    procedure AlterarOrdenacaoAnotacoes;
    procedure PegarTelaModal(const poWindow: IWindow);
    procedure InserirAnotacao;
    procedure AlterarTipoDoc;
    procedure TornarDocSemEfeito;
    procedure LiberarNosAutos;
    procedure VerificarNuProcTarjaAss;
    procedure TvChecaNodo(pTree: TBaseVirtualTree; pNodo: PVirtualNode; pbChecado: boolean);
    procedure PegarTelaCertificado(const poWindow: IWindow);
    procedure ConsultarPropriedadesRegistros(psNuProcessoCompleto, psTpDocumento: string);
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarVisualizacaoAutos;
  end;

implementation

uses
  uspInterface, ufpgVariaveisTestesGUI, uedtSelecaoCeritificadoDigital, uspSendKeys,
  udigConfirmacaoExclusao, ufpgConsTipoParte, ufpgFuncoesGUITestes,
  ufpgResultadoDistribuicao, ufpgConsTipoDocDigital, udigPropriedadesDocumento,
  ufpgConstanteGUITests, udigGeral;

var
  FsAnotacao: string;

{ TffpgVisualizaProcessoTests }

function TffpgVisualizaProcessoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgVisualizaProcessoModelTests;
end;

//30/11/2015 - Shirleano.Junior - SALT: 186660/23/4
procedure TffpgVisualizaProcessoTests.TestarVisualizacaoAutos;
begin
  ExecutarRoteiroTestes(PreencherDadosTelaVisualizacao);
end;

procedure TffpgVisualizaProcessoTests.PreencherDadosTelaVisualizacao;
var
  sTpDocumento: string;
begin
  AbrirTela;
  FoTela := TffpgVisualizaProcesso(spTela);
  FoDados := TffpgVisualizaProcessoModelTests(spDataModelTests);

  sTpDocumento := FoDados.fpgTipoDocumento;
  FsAnotacao := FoDados.fpgAnotacao + '' + sTpDocumento;

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de processo não encontrado.');

  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  if FoDados.fpgVerificarNuProcTarjaAss then
  begin
    VerificarNuProcTarjaAss;
    FecharTela;
    exit;
  end;

  FoTela.ccCadastro.Execute(acSalvar);

  if FoDados.fpgLiberarNosAutos then
    LiberarNosAutos;

  if FoDados.fpgConsultarPropriedades then
    ConsultarPropriedadesRegistros(FoDados.fpgNuProcesso, sTpDocumento);

  if FoDados.fpgAlterarOrdenacaoAnotacoes then
    AlterarOrdenacaoAnotacoes;

  if FoDados.fpgInserirAnotacao then
    InserirAnotacao;

  if FoDados.fpgAlterarTipoDoc then
    AlterarTipoDoc;

  if FoDados.fpgTornarDocSemEfeito then
    TornarDocSemEfeito;
end;

procedure TffpgVisualizaProcessoTests.PegarTelaModal(const poWindow: IWindow);
var
  oTela: TForm;
  i: integer;
begin
  oTela := poWindow.asControl as TForm;
  for i := 0 to oTela.ComponentCount - 1 do
  begin
    if oTela.Components[i].ClassType = TEdit then
    begin
      TEdit(oTela.Components[i]).Text := FsAnotacao;
      TButton(PegarBotaoPeloCaption(oTela, 'OK')).Click;
    end;
  end;
end;

procedure TffpgVisualizaProcessoTests.InserirAnotacao;
begin
  TFutureWindows.Expect('TForm').ExecProc(PegarTelaModal);
  FoTela.dxNovaAnotacao.Click;
  FoTela.ccCadastro.Execute(acSalvar);
  Check(FoDados.VerificacoesTesteConsultaAltos(SomenteNumeros(FoDados.fpgNuProcesso),
    FsAnotacao, FoDados.fpgNomeCampoAnotacao, FoDados.fpgEncontrouAnotacao),
    'O sistema não criou a anotação.');
end;

procedure TffpgVisualizaProcessoTests.AlterarTipoDoc;
var
  oTelaTpDocumento: TffpgConsTipoDocDigital;
begin
  FoTela.imAlteraTipoDoc.Click;
  oTelaTpDocumento := PegarTela('ffpgConsTipoDocDigital') as TffpgConsTipoDocDigital;
  oTelaTpDocumento.ccCadastro.Execute(acSelecionar);
  Check(FoDados.VerificacoesTesteConsultaAltos(SomenteNumeros(FoDados.fpgNuProcesso),
    FsAnotacao, FoDados.fpgNomeCampoDoc, FoDados.fpgEncontrouDoc),
    'O sistema não alterou o tipo do documento.');
end;

procedure TffpgVisualizaProcessoTests.TornarDocSemEfeito;
var
  oTelaConfirmacao: TfdigConfirmacaoExclusao;
begin
  FoTela.bbSemEfeito.click;
  oTelaConfirmacao := PegarTela('fdigConfirmacaoExclusao') as TfdigConfirmacaoExclusao;
  oTelaConfirmacao.dfedSenha.DefineTexto(spSenha);
  oTelaConfirmacao.mmExclusao.Text := FoDados.fpgMotivoSemEfeito;
  EnterTextInto(oTelaConfirmacao.cbCertificados, FoDados.fpgCertificado);
  oTelaConfirmacao.ccCadastro.Execute(acSelecionar);
  Check(FoDados.VerificacoesTesteConsultaAltos(SomenteNumeros(FoDados.fpgNuProcesso),
    FsAnotacao, FoDados.fpgNomeCampoSemEfeito, FoDados.fpgEncontrouSemEfeito),
    'O sistema não tornou sem efeito o documento.');
end;

procedure TffpgVisualizaProcessoTests.LiberarNosAutos;
begin
  TvChecaNodo(FoTela.tvNaoLiberado, FoTela.tvNaoLiberado.GetFirst, True);
  TFutureWindows.Expect('TffpgSelecaoCeritificadoDigital').ExecProc(PegarTelaCertificado);
  FoTela.bbJuntarDocumentos.Click;
end;

procedure TffpgVisualizaProcessoTests.TvChecaNodo(pTree: TBaseVirtualTree;
  pNodo: PVirtualNode; pbChecado: boolean);
begin
  if (pTree = nil) and (pNodo <> nil) then
    pTree := TreeFromNode(pNodo);

  if (pNodo = nil) or (pTree.CheckType[pNodo] = ctNone) then
    exit;

  if pbChecado then
    pTree.CheckState[pNodo] := cscheckedNormal
  else
    pTree.CheckState[pNodo] := csUncheckedNormal;
end;

procedure TffpgVisualizaProcessoTests.PegarTelaCertificado(const poWindow: IWindow);
var
  oTelaCertificado: TffpgSelecaoCeritificadoDigital;
begin
  oTelaCertificado := TffpgSelecaoCeritificadoDigital(poWindow.AsControl);
  Application.ProcessMessages;
  EnterTextInto(oTelaCertificado.cbCertificados, FoDados.fpgCertificado);
  oTelaCertificado.dxbbBotoesSelecionar.Click;
end;

procedure TffpgVisualizaProcessoTests.ConsultarPropriedadesRegistros(
  psNuProcessoCompleto, psTpDocumento: string);
var
  oTelaPropriedade: TfdigPropriedadesDocumento;
begin
  FoTela.bbPropriedades.Click;
  oTelaPropriedade := PegarTela('fdigPropriedadesDocumento') as TfdigPropriedadesDocumento;
  Check(SomenteNumeros(oTelaPropriedade.lbValorProcesso.Caption) = FoDados.fpgNuProcesso,
    'O número do processo na tela de propriedades está incorreto.');
  Check(oTelaPropriedade.lglTipoDoc.Caption = FoDados.fpgTipoDocumento,
    'O documento informado na tela de propriedades não é o correto.');
  oTelaPropriedade.ccPai.Execute(acFecharForm);
end;

// 21/08/2014 - Pio.Neto - Salt: 132782/1
procedure TffpgVisualizaProcessoTests.AlterarOrdenacaoAnotacoes;
var
  oTela: TffpgVisualizaProcesso;
  nOrdenacaoInicial: integer;
  nOrdenacaoNova: integer;
  sOrdenacaoSalva: string;

begin
  FoVerificadorTelas.PararVerificacao;
  oTela := TffpgVisualizaProcesso(spTela);
  oTela.pcDadosPesquisar.ActivePageIndex := 2;
  nOrdenacaoInicial := oTela.dfModoExibicaoAnotacoes.ItemIndex;
  if nOrdenacaoInicial = 0 then
  begin
    nOrdenacaoNova := 1;
  end
  else
  begin
    nOrdenacaoNova := 0;
  end;
  oTela.dfModoExibicaoAnotacoes.ItemIndex := nOrdenacaoNova;
  oTela.ccCadastro.Execute(acFecharForm);

  sOrdenacaoSalva := TdigIni.instanciaGlobal.ValorChave['OrdemAnotacoes'];

  CheckTrue(sOrdenacaoSalva <> STRING_INDEFINIDO,
    'Não existe parametro salvo no arquivo SAJ.ini para a ordenação');
  CheckTrue(nOrdenacaoInicial <> StrToInt(sOrdenacaoSalva),
    'Ordenação nova não foi salva no arquivo ini.');

end;

procedure TffpgVisualizaProcessoTests.VerificarNuProcTarjaAss;
var
  sNuProcesso: string;
begin
  sNuProcesso := '';
  check(TffpgVisualizaProcessoCrack(FoTela).TestarSeDocumentoEstaAssinado,
    'É necessário que o documento esteja assinado para verificar a Tarja.');
  sNuProcesso := FoTela.edigDocumento.FieldByName('CC_NUPROCESSO').AsString;
  check(snuProcesso = FoDados.fpgNuProcesso,
    'O processo não foi carregado corretamente no dataset');
end;

end.

