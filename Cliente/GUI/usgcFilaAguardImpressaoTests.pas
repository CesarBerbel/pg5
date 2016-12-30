unit usgcFilaAguardImpressaoTests;

interface

uses
  ufpgDataModelTests, ufpgGUITestCase, Forms, Windows, FutureWindows, usgcConsSituacao,
  usgcFilaAguardImpressao, usgcFilaAguardImpressaoModelTests;

type
  TfsgcFilaAguardImpressaoTests = class(TfpgGUITestCase)
  private
    FoTela: TfsgcFilaAguardImpressao;
    FoDados: TfsgcFilaAguardImpressaoModelTests;
    procedure FilaAguardImpressao;
    procedure Emitir;
    procedure FecharTelaRelatorio(const poWindow: IWindow);
    procedure CheckResultadoEntrega;
    procedure SelecionarPedidoNaGrid;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarFilaAguardImpressao;
    procedure TestarFilaAguardImpressaoReprocessar;
  end;

implementation

{ TfsgcFilaAguardEntregaTests }

uses
  ufpgConstanteGUITests, ufpgVariaveisTestesGUI, SysUtils, uspInterface,
  ufpgFuncoesGUITestes, usgcEmisCertidao, usgcRPPreviewForm;

//06/12/2016 - Luciano.Fagundes - Task: 70052
procedure TfsgcFilaAguardImpressaoTests.FilaAguardImpressao;
begin
  FoDados := TfsgcFilaAguardImpressaoModelTests(spDataModelTests);

  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('fsgcFilaAguardImpressao');

  FoTela := TfsgcFilaAguardImpressao(spTela);

  if FoDados.fpgNuPedido = STRING_INDEFINIDO then
    FoDados.fpgNuPedido := gsNuPedido;

  if not FoDados.fpgMarcarTodos then
  begin
    FoTela.pbDesmarcarTodos.Click;
    SelecionarPedidoNaGrid;
  end
  else
    FoTela.pbMarcarTodos.Click;

  if FoDados.fpgEmitir then
  begin
    spVerificadorTelas.RegistrarMensagem('Deseja *', 'Sim');
    Emitir;
  end;

  if FoDados.fpgReprocessar then
  begin
    spVerificadorTelas.RegistrarMensagem('Há pedidos *', 'Sim');
    FoTela.pbReprocessar.Click;

  end;

  Application.ProcessMessages;
  Sleep(1000);

  CheckResultadoEntrega;

end;

//06/12/2016 - Luciano.Fagundes - Task: 70052
function TfsgcFilaAguardImpressaoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TfsgcFilaAguardImpressaoModelTests;
end;

//06/12/2016 - Luciano.Fagundes - Task: 70052
procedure TfsgcFilaAguardImpressaoTests.TearDown;
begin
  if FoDados.fpgFecharTela then
    FecharTela;
  inherited;
end;

//06/12/2016 - Luciano.Fagundes - Task: 70052
procedure TfsgcFilaAguardImpressaoTests.TestarFilaAguardImpressao;
begin
  ExecutarRoteiroTestes(FilaAguardImpressao);
end;

//06/12/2016 - Luciano.Fagundes - Task: 70052
procedure TfsgcFilaAguardImpressaoTests.Emitir;
var
  FoTelaEmisCertidao: TfsgcEmisCertidao;
begin
  FoTela.pbEmitir.Click;

  Application.ProcessMessages;
  FoTelaEmisCertidao := PegarTela('fsgcEmisCertidao') as TfsgcEmisCertidao;
  TFutureWindows.Expect('TfsgcRPPreviewForm').ExecProc(FecharTelaRelatorio);
  FoTelaEmisCertidao.pbVisualizar.Click;
  Application.ProcessMessages;

end;

//06/12/2016 - Luciano.Fagundes - Task: 70052
procedure TfsgcFilaAguardImpressaoTests.FecharTelaRelatorio(const poWindow: IWindow);
var
  FoTelaRelatorio: TfsgcRPPreviewForm;
begin
  FoTelaRelatorio := poWindow.asControl as TfsgcRPPreviewForm;
  CheckTrue(Assigned(FoTelaRelatorio), 'O Relatório não foi exibido!');
  FoTelaRelatorio.SBLastPage.Click;
  FoTelaRelatorio.SBDone.click;
end;

//06/12/2016 - Luciano.Fagundes - Task: 70053
procedure TfsgcFilaAguardImpressaoTests.TestarFilaAguardImpressaoReprocessar;
begin
  ExecutarRoteiroTestes(FilaAguardImpressao);
end;

//06/12/2016 - Luciano.Fagundes - Task: 70053
procedure TfsgcFilaAguardImpressaoTests.CheckResultadoEntrega;
var
  sMensagem: string;
begin
  Check(not FoTela.grDados.DataSource.DataSet.Locate('NUPEDIDO', FoDados.fpgNuPedido, []),
    'Pedido não saiu da grid');
  sMensagem := 'O pedido: ' + FoDados.fpgNuPedido + ', não encontra-se com a situação: ' +
    FoDados.fpgCDSituacao + ' - Aguardando Processamento';
  Check(FoDados.VerificaSituacaoPedido(FoDados.fpgNuPedido, FoDados.fpgCDSituacao), sMensagem);
end;

//06/12/2016 - Luciano.Fagundes - Task: 70053
procedure TfsgcFilaAguardImpressaoTests.SelecionarPedidoNaGrid;
begin
  FoTela.grDados.DataSource.DataSet.Locate('NUPEDIDO', FoDados.fpgNuPedido, []);
  FoTela.grDados.DataSource.DataSet.Edit;
  FoTela.grDados.DataSource.DataSet.FieldByName('CC_OK').AsString := 'S';
  FoTela.grDados.DataSource.DataSet.Post;
end;

end.

