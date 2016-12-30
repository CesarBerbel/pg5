unit ufpgAnalisePedidoTests;

interface

uses
  ufpgGuiTestCase, ufpgDataModelTests, ufpgAnalisePedido, ufpgAnalisePedidoModelTests;

type
  TffpgAnalisePedidoTests = class(TfpgGuiTestCase)
  private
    FoTela: TffpgAnalisePedido;
    FoDados: TffpgAnalisePedidoModelTests;
    procedure AnalisePedido;
    procedure PreencherDados;
  public
    procedure TearDown; override;
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarAnalisePedido;
  end;

implementation

uses                                                                                                                         
  uspInterface, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgFuncoesGUITestes;

{ TfsgcAnalisePedidoTests }

function TffpgAnalisePedidoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgAnalisePedidoModelTests;
end;

procedure TffpgAnalisePedidoTests.TestarAnalisePedido;
begin
  ExecutarRoteiroTestes(AnalisePedido);
end;

procedure TffpgAnalisePedidoTests.AnalisePedido;
begin
  AbrirTela;
  FoTela := spTela as TffpgAnalisePedido;
  FoDados := spDataModelTests as TffpgAnalisePedidoModelTests;

  PreencherDados;

  FoTela.ccCadastro.Execute(acConsultar);
  checkFalse(FoTela.esgcPedido.IsEmpty, 'Nenhum pedido encontrado');
end;

procedure TffpgAnalisePedidoTests.PreencherDados;
begin
  if FoDados.fpgCdPedido = STRING_INDEFINIDO then
    FoDados.fpgCdPedido := gsNuPedido;

  EnterTextInto(FoTela.dfCdPedido, FoDados.fpgCdPedido);

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  check(FoDados.fpgNuProcesso <> STRING_INDEFINIDO, 'Nenhum Processo Informado');

  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso);
end;

procedure TffpgAnalisePedidoTests.TearDown;
begin
  FecharTela;
  inherited;
end;

end.

