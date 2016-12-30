unit usgcFilaSuspProcesTests;

interface

uses
  ufpgDataModelTests, ufpgGUITestCase, Forms, Windows, FutureWindows,
  usgcFilaSuspProces, usgcFilaSuspProcesModelTests;

type
  TfsgcFilaSuspProcesTests = class(TfpgGUITestCase)
  private
    FoTela: TfsgcFilaSuspProces;
    FoDados: TfsgcFilaSuspProcesModelTests;
    procedure FilaProcSuspenso;
    procedure Processar;
    procedure CheckResultadoEntrega;
    procedure SelecionarPedidoNaGrid;
  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarFilaProcSuspenso;
  end;

implementation

{ TfsgcFilaAguardEntregaTests }

uses
  ufpgConstanteGUITests, ufpgVariaveisTestesGUI, SysUtils, uspInterface, ufpgFuncoesGUITestes;


//06/12/2016 - Luciano.Fagundes - Task: 70048
procedure TfsgcFilaSuspProcesTests.FilaProcSuspenso;
begin
  FoDados := TfsgcFilaSuspProcesModelTests(spDataModelTests);

  spNomeMenuItem := 'umfsgcFilaSuspProces';
  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('fsgcFilaSuspProces');

  FoTela := TfsgcFilaSuspProces(spTela);

  if FoDados.fpgNuPedido = STRING_INDEFINIDO then
    FoDados.fpgNuPedido := gsNuPedido;

  if not FoDados.fpgMarcarTodos then
  begin
    FoTela.pbDesmarcarTodos.Click;
    SelecionarPedidoNaGrid;
  end
  else
    FoTela.pbMarcarTodos.Click;

  if FoDados.fpgProcessar then
  begin
    spVerificadorTelas.RegistrarMensagem('Deseja *', 'Sim');
    Processar;
  end;

  Application.ProcessMessages;
  Sleep(1000);

  CheckResultadoEntrega;

end;

//06/12/2016 - Luciano.Fagundes - Task: 70048
function TfsgcFilaSuspProcesTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TfsgcFilaSuspProcesModelTests;
end;

//06/12/2016 - Luciano.Fagundes - Task: 70048
procedure TfsgcFilaSuspProcesTests.Processar;
begin
  FoTela.pbProcessar.Click;
end;

//06/12/2016 - Luciano.Fagundes - Task: 70048
procedure TfsgcFilaSuspProcesTests.TearDown;
begin
  if FoDados.fpgFecharTela then
    FecharTela;
  inherited;
end;

//06/12/2016 - Luciano.Fagundes - Task: 70048
procedure TfsgcFilaSuspProcesTests.TestarFilaProcSuspenso;
begin
  ExecutarRoteiroTestes(FilaProcSuspenso);
end;

//06/12/2016 - Luciano.Fagundes - Task: 70048
procedure TfsgcFilaSuspProcesTests.CheckResultadoEntrega;
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
procedure TfsgcFilaSuspProcesTests.SelecionarPedidoNaGrid;
begin
  FoTela.grDados.DataSource.DataSet.Locate('NUPEDIDO', FoDados.fpgNuPedido, []);
  FoTela.grDados.DataSource.DataSet.Edit;
  FoTela.grDados.DataSource.DataSet.FieldByName('CC_OK').AsString := 'S';
  FoTela.grDados.DataSource.DataSet.Post;
end;

end.

