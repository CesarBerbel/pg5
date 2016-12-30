unit usgcFilaEmProcesTests;

interface

uses
  SysUtils, ADODB, uspForm, uspInterface, ufpgDataModelTests, uspTestCase,
  ufpgGUITestCase, DBClient, usgcFilaEmProcesModelTests, usgcFilaEmProces, Forms, Windows;

type
  TfsgcFilaEmProcesTests = class(TfpgGUITestCase)
  private
    FoTela: TfsgcFilaEmProces;
    FoDados: TfsgcFilaEmProcesModelTests;
    procedure ConsultaPedidoProcessamento;
    procedure ConsultarPedido;
    procedure SuspendePedido;
    procedure VerificaSituacaoPedido;

  public
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
    procedure TearDown; override;
  published
    procedure TestarConsultaPedidoProcessamento;
  end;

implementation

{ TfsgcCadPedidoTests }

uses
  ufpgFuncoesGUITestes, ufpgConstanteGUITests, ufpgVariaveisTestesGUI;

function TfsgcFilaEmProcesTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TfsgcFilaEmProcesModelTests;
end;

procedure TfsgcFilaEmProcesTests.TestarConsultaPedidoProcessamento;
begin
  ExecutarRoteiroTestes(ConsultaPedidoProcessamento);
end;

procedure TfsgcFilaEmProcesTests.TearDown;
begin
  if FoDados.fpgFecharTela then
    FecharTela;
  inherited;
end;

procedure TfsgcFilaEmProcesTests.ConsultaPedidoProcessamento;
begin

  FoDados := TfsgcFilaEmProcesModelTests(spDataModelTests);
  if FoDados.fpgAbrirDoMenu then
    AbrirTela
  else
    spTela := PegarTela('fsgcFilaEmProces');

  FoTela := TfsgcFilaEmProces(spTela);


  ConsultarPedido;

  spVerificadorTelas.RegistrarMensagem('Deseja*', '&Sim');
  if FoDados.fpgSuspender then
    SuspendePedido;

  VerificaSituacaoPedido;

end;

procedure TfsgcFilaEmProcesTests.ConsultarPedido;
begin
  FoTela.grDados.DataSource.DataSet.First;
  while not FoTela.grDados.DataSource.DataSet.EOF do
  begin
    //    if FoTela.grDados.DataSource.DataSet.FieldByName('NUPEDIDO').AsString = gsNuPedido then
    if FoTela.grDados.DataSource.DataSet.FieldByName('NUPEDIDO').AsString = '5' then
    begin
      FoTela.grDados.DataSource.DataSet.Edit;

      EnterTextGrid(FoTela.grDados, 'S', 0);
      Break;
    end;
    FoTela.grDados.DataSource.DataSet.Next;
  end;
end;

procedure TfsgcFilaEmProcesTests.SuspendePedido;
begin

  FoTela.pbSuspender.Click;

end;

procedure TfsgcFilaEmProcesTests.VerificaSituacaoPedido;
begin

end;

end.

