unit ufpgCalcCustaCompletaIntermediariaProcTests;

interface

uses
  ufpgCalcCustaCompletaIntermediariaProc, ufpgGUITestCase, ufpgDataModelTests,
  ufpgCalcCustaCompletaIntermediariaProcModelTests, FutureWindows;


type
  TffpgCalcCustaCompletaIntermediariaProcTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgCalcCustaCompletaIntermediariaProc;
    FoDados: TffpgCalcCustaCompletaIntermediariaProcModelTests;
    procedure GeracaoImpressaoGRJCustasIntermediarias;         
    procedure PreencherDadosPrincipais;
    procedure SelecionarTipoCustas;
    procedure PegarTelaModal(const poWindow: IWindow);
    procedure RelatorioCalcCustaGRJ;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarGeracaoImpressaoGRJCustasIntermediarias;
  end;

implementation

uses
  uccp5ConsTipoCusta, uccp5RelCalcCustaGrj, ufpgVariaveisTestesGUI, ufpgCadGrjBaixa, Windows,
  uspInterface, Forms, SysUtils, , ufpgFuncoesGUITestes, dIALOGS;

var
  FsNomeArquivo: string;

const
  CONST1 = 'Atos do Oficial de Justiça - Fazenda Pública sem Convênio';
  CONST2 = 'Atos do Oficial de Justiça - Justiça Paga';
  CONST3 = 'Despesas Extras';
  CONST4 = 'Quilometragem (KM)';


function TffpgCalcCustaCompletaIntermediariaProcTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgCalcCustaCompletaIntermediariaProcModelTests;
end;


procedure TffpgCalcCustaCompletaIntermediariaProcTests.GeracaoImpressaoGRJCustasIntermediarias;
begin
  FoTela := TffpgCalcCustaCompletaIntermediariaProc(spTela);
  FoDados := TffpgCalcCustaCompletaIntermediariaProcModelTests(spDataModelTests);

  SelecionarTipoCustas;
  PreencherDadosPrincipais;

  FecharTela;
end;

procedure TffpgCalcCustaCompletaIntermediariaProcTests.PegarTelaModal(const poWindow: IWindow);
var
  DlgHandle: HWND;
begin
  DlgHandle := poWindow.GetHandle;
  Application.ProcessMessages;
  Windows.SetDlgItemText(DlgHandle, 1152, PChar(FsNomeArquivo));
end;


procedure TffpgCalcCustaCompletaIntermediariaProcTests.PreencherDadosPrincipais;
begin
  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := usarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Número de Processo não encontrado');

  EnterTextInto(FoTela.dfnuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  FoTela.grVincRecolCusta.DataSource.DataSet.First;
  while not FoTela.grVincRecolCusta.DataSource.DataSet.EOF do
  begin
    if FoTela.grVincRecolCusta.DataSource.DataSet.FieldByName('CC_DETIPORECOL').AsString
      = CONST1 then
    begin
      FoTela.ccCalcCustaHist.Execute(acNovo);
      EnterTextGrid(FoTela.grCalcCustaHist, FoDados.fpgQtdeAtos, 1);
    end
    else
    if FoTela.grVincRecolCusta.DataSource.DataSet.FieldByName('CC_DETIPORECOL').AsString
      = CONST2 then
    begin
      FoTela.ccCalcCustaHist.Execute(acNovo);
      EnterTextGrid(FoTela.grCalcCustaHist, FoDados.fpgQtdeJusPaga, 1);
    end
    else
    if FoTela.grVincRecolCusta.DataSource.DataSet.FieldByName('CC_DETIPORECOL').AsString
      = CONST3 then
    begin
      FoTela.ccCalcCustaHist.Execute(acNovo);
      FoTela.grFiltroCalcCustaHist.DataSource.DataSet.Edit;
      FoTela.grFiltroCalcCustaHist.DataSource.DataSet.FieldByName('vlUnitario').AsString :=
        FoDados.fpgVlInformado;
      FoTela.grFiltroCalcCustaHist.DataSource.DataSet.post;
      Application.ProcessMessages;
    end
    else
    if FoTela.grVincRecolCusta.DataSource.DataSet.FieldByName('CC_DETIPORECOL').AsString
      = CONST4 then
    begin
      FoTela.ccCalcCustaHist.Execute(acNovo);
      EnterTextGrid(FoTela.grCalcCustaHist, FoDados.fpgKm, 1);
    end;
    FoTela.grVincRecolCusta.DataSource.DataSet.Next;
  end;

  FoTela.ccCadastro.Execute(acSalvar);

  FoTela.ccCadastro.Execute(acImprimir);

  RelatorioCalcCustaGRJ;
end;

procedure TffpgCalcCustaCompletaIntermediariaProcTests.SelecionarTipoCustas;
var
  FoTela: Tfccp5ConsTipoCusta;
begin
  FoTela := PegarTela('fccp5ConsTipoCusta') as Tfccp5ConsTipoCusta;
  FoTela.grDados.DataSource.DataSet.Locate('CDTIPOCUSTA', FoDados.fpgTipoCusta, []);
  EnterTextGrid(FoTela.grFiltro, FoDados.fpgTipoCusta, 0);
  FoTela.ccCadastro.Execute(acSelecionar);
end;

procedure TffpgCalcCustaCompletaIntermediariaProcTests.
TestarGeracaoImpressaoGRJCustasIntermediarias;
begin
  ExecutarRoteiroTestes(GeracaoImpressaoGRJCustasIntermediarias);
end;

procedure TffpgCalcCustaCompletaIntermediariaProcTests.RelatorioCalcCustaGRJ;
var
  oTelaGRJ: Tfccp5RelCalcCustaGrj;
begin
  oTelaGRJ := PegarTela('fccp5RelCalcCustaGrj') as Tfccp5RelCalcCustaGrj;
  EnterTextInto(oTelaGRJ.dfnmInteressado, FoDados.fpgInteressado);
  EnterTextInto(oTelaGRJ.dfdeEndereco, FoDados.fpgEndereco);
  EnterTextRadioGroup(oTelaGRJ.rgTipoRelatorio, '&' + FoDados.fpgTpRelatorio);
  EnterTextCheckBox(oTelaGRJ.ckArquivo, True);
  FsNomeArquivo := gsNuProcesso;
  TFutureWindows.Expect('#32770', 10).ExecProc(PegarTelaModal).ExecSendKey(VK_RETURN);
  spVerificadorTelas.RegistrarMensagem(
    'A guia foi emitida com sucesso através da(s) GRJ(s) nº*', 'OK');
  oTelaGRJ.pbImprimir.Click;

  spVerificadorTelas.RegistrarMensagem(
    'Este cálculo ainda não está disponível na internet. Deseja disponibilizá-lo agora?', 'Não');


  //  TFutureWindows.Expect('TMessageForm', 60000).ExecProc(PressionarNaoNaTelaDeConfirmacao);

  oTelaGRJ.pbFechar.Click;
end;

initialization

  TestFrameWork.RegisterTest('Interface\Custas\Intermediárias',
    TffpgCalcCustaCompletaIntermediariaProcTests.Suite);

end.

